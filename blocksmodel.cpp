#include "blocksmodel.h"

BlocksModel::BlocksModel(QObject *parent) :
    QAbstractListModel(parent)
{
    mRoleHash.insert(CaptionRole, "caption");
    mRoleHash.insert(MediaContentRole, "mediaContent");
    mRoleHash.insert(SourceTypeRole, "srctype");
    mRoleHash.insert(SourceRole, "source");
    mRoleHash.insert(WidthRole, "width");
    mRoleHash.insert(HeightRole, "height");
    mRoleHash.insert(XRole, "x");
    mRoleHash.insert(YRole, "y");
    mRoleHash.insert(BackgroundRole, "background");
}

BlocksModel::~BlocksModel()
{
    qDeleteAll(mBlocksList);
}

QVariant BlocksModel::data(const QModelIndex &index, int role) const
{
    QVariant returnData;
    if (index.row() >= 0 || index.row() < mBlocksList.count())
    {
        const Block *block = mBlocksList[index.row()];

        switch (role) {
        case CaptionRole:
            returnData.setValue(block->caption());
            break;
        case MediaContentRole:
            returnData.setValue(block->mediaContent());
            break;
        case SourceTypeRole:
            returnData = block->sourceType();
            break;
        case SourceRole:
            returnData.setValue(block->source());
            break;
        case WidthRole:
            returnData = block->width();
            break;
        case HeightRole:
            returnData = block->height();
            break;
        case XRole:
            returnData = block->x();
            break;
        case YRole:
            returnData = block->y();
            break;
        case BackgroundRole:
            returnData = block->background();
            break;
        }
    }
    return returnData;
}

int BlocksModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return mBlocksList.count();
}

QHash<int, QByteArray> BlocksModel::roleNames() const
{
    return mRoleHash;
}

void BlocksModel::addBlock(Block *pBlock)
{
    mBlocksList.append(pBlock);
}
