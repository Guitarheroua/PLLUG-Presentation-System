#include "slidemodel.h"
#include "contentblock.h"

SlideModel::SlideModel(QObject *parent) :
    QAbstractListModel(parent)
{
    mRoleHash.insert(ContentBlockTypeRole, "type");
    mRoleHash.insert(SoursesRole, "sourses");
    mRoleHash.insert(WidthRole, "width");
    mRoleHash.insert(HeightRole, "height");
    mRoleHash.insert(XRole, "x");
    mRoleHash.insert(YRole, "y");
    mRoleHash.insert(ZRole, "z");
}

SlideModel::~SlideModel()
{
    qDeleteAll(mBlocksList);
}

QVariant SlideModel::data(const QModelIndex &index, int role) const
{
    QVariant returnData;
    if (index.row() >= 0 || index.row() < mBlocksList.count())
    {
        const ContentBlock *contentBlock = mBlocksList[index.row()];

        switch (role)
        {
        case ContentBlockTypeRole:
            returnData = contentBlock->contentBlockType();
            break;
        case SoursesRole:
            returnData = contentBlock->content();
            break;
        case WidthRole:
            returnData = contentBlock->width();
            break;
        case HeightRole:
            returnData = contentBlock->height();
            break;
        case XRole:
            returnData = contentBlock->x();
            break;
        case YRole:
            returnData = contentBlock->y();
            break;
        case ZRole:
            returnData = contentBlock->z();
            break;
        }
    }
    return returnData;
}

int SlideModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return mBlocksList.count();
}

QHash<int, QByteArray> SlideModel::roleNames() const
{
    return mRoleHash;
}

void SlideModel::addBlock(ContentBlock *contentBlock)
{
    mBlocksList.append(contentBlock);
}

void SlideModel::addBlock2(int x, int y, int width, int height, int z, QVariant contentBlockType)
{
    ContentBlock cb;
    auto cbt = cb.contentBlockType(contentBlockType.toString());
    mBlocksList.append(new ContentBlock(x, y, width, height, z, cbt));
}
