#include "blocksmodel.h"

BlocksModel::BlocksModel(QObject *parent) :
    QAbstractListModel(parent)
{
    mRoleHash.insert(TitleRole, "title");
    mRoleHash.insert(SourceTypeRole, "srctype");
    mRoleHash.insert(SourceRole, "source");
    mRoleHash.insert(WidthRole, "width");
    mRoleHash.insert(HeightRole, "height");
    mRoleHash.insert(XRole, "x");
    mRoleHash.insert(YRole, "y");
}

BlocksModel::~BlocksModel()
{
    qDeleteAll(mBlocksList);
}

QVariant BlocksModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= mBlocksList.count())
        return QVariant();

    const Block *block = mBlocksList[index.row()];
    if (role == TitleRole)
        return block->title();
    else if (role == SourceTypeRole)
        return block->sourceType();
    else if (role == SourceRole)
        return block->source();
    else if (role == WidthRole)
        return block->width();
    else if (role == HeightRole)
        return block->height();
    else if (role == XRole)
        return block->x();
    else if (role == YRole)
        return block->y();

    return QVariant();
}

int BlocksModel::rowCount(const QModelIndex &parent) const
{
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
