#include "slidemodel.h"
#include "contentblock.h"
#include <QVariant>

SlideModel::SlideModel(QObject *parent) :
    QAbstractListModel{parent},
    mRoot{new ContentBlock}
{
    for (int i = 0; i < 3; ++i) {
        append(new ContentBlock(mRoot));
    }
}

SlideModel::~SlideModel()
{
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

    if(row > 0 || row <= rowCount(index))
    {
        switch(role)
        {
        case XRole :
            mRoot->child(row)->x();
            break;
        case YRole :
            mRoot->child(row)->y();
            break;
        case ZRole :
            mRoot->child(row)->z();
            break;
        case WidthRole :
            mRoot->child(row)->width();
            break;
        case HeightRole :
            mRoot->child(row)->height();
            break;
        case TypeRole :
            mRoot->child(row)->contentBlockType();
            break;
        case AdditionalContentRole :
            break;
        }
    }
    return result;
}

#include <iostream>
void SlideModel::append(ContentBlock *item)
{
    std::cout << "SlideModel::append" << std::endl;
    if(mRoot)
    {
        std::cout << "SlideModel::append" << std::endl;
        QModelIndex index;
        beginInsertRows(index, rowCount(index), rowCount(index));
        mRoot->appendChild(item);
        endInsertRows();
    }
}
void SlideModel::changeParent(ContentBlock *item)
{
    std::cout << "SlideModel::changeParent " << item->width() << std::endl;
    if(item)
    {
        std::cout << "SlideModel::changeParent" << std::endl;
        mRoot = item;
    }
}

ContentBlock *SlideModel::getChild(int index) const
{
    std::cout << "SlideModel::getChild " << index << std::endl;
    return mRoot->child(index);
}
