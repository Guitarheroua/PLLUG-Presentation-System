#include "slidemodel.h"
#include "contentblock.h"

#include <QVariant>

SlideModel::SlideModel(QObject *parent) :
    SlideModel{new ContentBlock, parent}
{
}

SlideModel::SlideModel(ContentBlock *root, QObject *parent):
    QAbstractListModel{parent}
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

QVariant SlideModel::data(const QModelIndex &index, int role) const
{
    QVariant result;
    int row = index.row();


    if(row > 0 || row < rowCount(index))
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
    return result;
}

void SlideModel::append(ContentBlock *item)
{
    if(mRoot)
    {
        QModelIndex index;
        beginInsertRows(index, rowCount(index), rowCount(index));
        mRoot->appendChild(item);
        endInsertRows();
    }
}

void SlideModel::insert(int index, ContentBlock *child)
{
    QModelIndex modelIndex;
    if(index > 0 || index < rowCount(modelIndex))
    {
        beginInsertRows(modelIndex, index, index);
        mRoot->insertChild(index, child);
        endInsertRows();
    }
}

void SlideModel::remove(int index)
{
    QModelIndex modelIndex;
    if(index > 0 || index < rowCount(modelIndex))
    {
        beginRemoveRows(modelIndex, index, index);
        mRoot->removeChild(index);
        endRemoveRows();
    }
}
SlideModel *SlideModel::getModelFromChild(int index)
{
    SlideModel *slideModel;
    if(mChildsModelsHash.contains(index))
    {
        slideModel = mChildsModelsHash.value(index);
    }
    else
    {
        ContentBlock *item = getChild(index);
        if(item)
        {
            slideModel = new SlideModel(item, this);
            mChildsModelsHash.insert(index, slideModel);
        }
    }
    return slideModel;
}

ContentBlock *SlideModel::getChild(int index) const
{
    return mRoot->child(index);
}
