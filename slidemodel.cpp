#include "slidemodel.h"
#include "slide.h"

SlideModel::SlideModel(QObject *parent) :
    QAbstractListModel(parent)
{
//    mRoleHash.insert(ContentBlockTypeRole, "type");
//    mRoleHash.insert(SpecificContentRole, "specificContent");
//    mRoleHash.insert(WidthRole, "width");
//    mRoleHash.insert(HeightRole, "height");
//    mRoleHash.insert(XRole, "x");
//    mRoleHash.insert(YRole, "y");
//    mRoleHash.insert(ZRole, "z");
    addSlide();
}

SlideModel::~SlideModel()
{
//    qDeleteAll(mBlocksList);
    qDeleteAll(mSlideList);
}

void SlideModel::addSlide()
{
    mSlideList.append(new Slide);
}

void SlideModel::deleteSlide(int index)
{
    mSlideList.removeAt(index);
}

//QVariant SlideModel::data(const QModelIndex &index, int role) const
//{
//    QVariant returnData;
//    if (index.row() >= 0 || index.row() < mBlocksList.count())
//    {
//        const ContentBlock *contentBlock = mBlocksList[index.row()];

//        switch (role)
//        {
//        case ContentBlockTypeRole:
//            returnData = contentBlock->contentBlockType();
//            break;
//        case SpecificContentRole:
//            returnData = contentBlock->specificContent();
//            break;
//        case WidthRole:
//            returnData = contentBlock->width();
//            break;
//        case HeightRole:
//            returnData = contentBlock->height();
//            break;
//        case XRole:
//            returnData = contentBlock->x();
//            break;
//        case YRole:
//            returnData = contentBlock->y();
//            break;
//        case ZRole:
//            returnData = contentBlock->z();
//            break;
//        }
//    }
//    return returnData;
//}

//int SlideModel::rowCount(const QModelIndex &parent) const
//{
//    Q_UNUSED(parent);
//    return mBlocksList.count();
//}

//QHash<int, QByteArray> SlideModel::roleNames() const
//{
//    return mRoleHash;
//}

