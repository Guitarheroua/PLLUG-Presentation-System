#include "slidemodel.h"
#include "contentblock.h"

#include <QVariant>

SlideModel::SlideModel(QObject *parent) :
    SlideModel{new ContentBlock, parent}
{
}

SlideModel::SlideModel(ContentBlock *root, QObject *parent):
    QAbstractTableModel{parent}
  ,mRoot{root}
{
}

SlideModel::~SlideModel()
{
    qDeleteAll(mChildsModelsHash);
    delete mRoot;
}

QHash<int, QByteArray> SlideModel::roleNames() const
{
    return QHash<int, QByteArray>{
        {XRole, "x"},
        {YRole, "y"},
        {ZRole, "z"},
        {WidthRole, "width"},
        {HeightRole, "height"},
        {TypeRole, "type"},
        {AdditionalContentRole, "additionalContent"}
    };
}

int SlideModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return mRoot->childsCount();
}

int SlideModel::columnCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return 1;
}

QVariant SlideModel::data(const QModelIndex &index, int role) const
{
    QVariant result;
    if(mRoot)
    {
        int row = index.row();

        if(index.isValid() && row < rowCount() && index.column() < columnCount(QModelIndex()))
        {
            switch(role)
            {
            case XRole :
                result = mRoot->child(row)->x();
                break;
            case YRole :
                result = mRoot->child(row)->y();
                break;
            case ZRole :
                result = mRoot->child(row)->z();
                break;
            case WidthRole :
                result = mRoot->child(row)->width();
                break;
            case HeightRole :
                result = mRoot->child(row)->height();
                break;
            case TypeRole :
                result = mRoot->child(row)->contentBlockType();
                break;
            case AdditionalContentRole :
                result = mRoot->child(row)->additionalContent();
                break;
            }
        }
    }
    return result;
}

void SlideModel::append(ContentBlock *item)
{
    insert(rowCount(), item);
}

void SlideModel::insert(int index, ContentBlock *child)
{
    if(index < 0 || index > rowCount())
    {
        return;
    }
    if(mRoot)
    {
        beginInsertRows(QModelIndex(), index, index);
        mRoot->insertChild(index, child);
        endInsertRows();
    }
}

void SlideModel::swap(int firstIndex, int secondIndex)
{
    if(mRoot)
    {
        mRoot->swapChild(firstIndex, secondIndex);
        emit dataChanged(index(firstIndex, 0), index(firstIndex, columnCount(QModelIndex()) - 1));
        emit dataChanged(index(secondIndex, 0), index(secondIndex, columnCount(QModelIndex()) - 1));
    }
}

void SlideModel::remove(int index)
{
    if(mRoot)
    {
        if(index >= 0 || index < rowCount())
        {
            beginRemoveRows(QModelIndex(), index, index);
            delete mRoot->child(index);
            mRoot->removeChild(index);
            endRemoveRows();
        }
    }
}
SlideModel *SlideModel::getModelFromChild(int index)
{
    SlideModel *slideModel = nullptr;
    if(mRoot)
    {
        if(mChildsModelsHash.contains(getChild(index)->id()))
        {
            slideModel = mChildsModelsHash.value(getChild(index)->id());
        }
        else
        {
            ContentBlock *item = getChild(index);
            if(item)
            {
                slideModel = new SlideModel(item, this);
                mChildsModelsHash.insert(item->id(), slideModel);
            }
        }
    }
    return slideModel;
}

ContentBlock *SlideModel::getChild(int index) const
{
    return (mRoot) ? mRoot->child(index) : nullptr;
}
