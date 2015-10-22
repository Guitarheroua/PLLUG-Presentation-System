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
    qDeleteAll(mChildsModelsHash.values());
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

void SlideModel::insert(int row, ContentBlock *child)
{
    if(mRoot)
    {
        if(row >= 0 || row <= rowCount())
        {
            beginInsertRows(QModelIndex(), row, row);
            mRoot->insertChild(row, child);
            endInsertRows();
        }
    }
}

void SlideModel::swap(int firstRow, int secondRow)
{
    if(mRoot)
    {
        mRoot->swapChild(firstRow, secondRow);
        emit dataChanged(index(firstRow, 0), index(firstRow, columnCount(QModelIndex()) - 1));
        emit dataChanged(index(secondRow, 0), index(secondRow, columnCount(QModelIndex()) - 1));
    }
}

void SlideModel::remove(int row)
{
    if(mRoot)
    {
        if(row >= 0 || row < rowCount())
        {
            beginRemoveRows(QModelIndex(), row, row);
            mRoot->removeChild(row);
            endRemoveRows();
        }
    }
}
SlideModel *SlideModel::getModelFromChild(int row)
{
    SlideModel *slideModel = nullptr;
    if(mChildsModelsHash.contains(getChild(row)->id()))
    {
        slideModel = mChildsModelsHash.value(getChild(row)->id());
    }
    else
    {
        ContentBlock *item = getChild(row);
        if(item)
        {
            slideModel = new SlideModel(item, this);
            mChildsModelsHash.insert(item->id(), slideModel);
        }
    }
    return slideModel;
}

ContentBlock *SlideModel::getChild(int row) const
{
    return (mRoot) ? mRoot->child(row) : nullptr;
}
