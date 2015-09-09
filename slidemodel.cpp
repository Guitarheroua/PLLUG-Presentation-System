#include "slidemodel.h"
#include "slide.h"
#include <QVariant>

SlideModel::SlideModel(QObject *parent) :
    QAbstractListModel(parent)
{
    mSlideList.append(new Slide);
}

SlideModel::~SlideModel()
{
    qDeleteAll(mSlideList);
}

int SlideModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return mSlideList.count();
}

QVariant SlideModel::data(const QModelIndex &index, int role) const
{
    QVariant result;
    int row = index.row();

    if(row > 0 || row <= rowCount(index))
    {
        if(role == Qt::DisplayRole)
        {
            result.setValue(mSlideList[row]);
        }
    }
    return result;
}

bool SlideModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    bool isSeted = false;
    if(role == Qt::DisplayRole)
    {
        mSlideList[index.row()] = qvariant_cast<Slide *>(value);
        isSeted =true;
    }
    return isSeted;
}
#include <iostream>
void SlideModel::appendSlide()
{
    QModelIndex index;
    emit beginInsertRows(index, rowCount(index), rowCount(index));
    mSlideList.append(new Slide);
    emit endInsertRows();
}

Slide *SlideModel::getSlide(int index) const
{
    return mSlideList[index];
}
