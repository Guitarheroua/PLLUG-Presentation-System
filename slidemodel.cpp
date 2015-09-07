#include "slidemodel.h"
#include "slide.h"
#include <QVariant>

SlideModel::SlideModel(QObject *parent) :
    QAbstractListModel(parent)
{
    mSlideList.append(new Slide());
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
    if(role == Qt::DisplayRole)
    {
        result.setValue(mSlideList[index.row()]);
        return result;
    }
    return result;
}
