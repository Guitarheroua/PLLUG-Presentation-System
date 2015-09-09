#ifndef BLOCKSMODEL_H
#define BLOCKSMODEL_H

#include <QAbstractListModel>

class Slide;

class SlideModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit SlideModel(QObject *parent = 0);
    ~SlideModel();

    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    bool setData(const QModelIndex &index, const QVariant &value, int role);

    Q_INVOKABLE void appendSlide();
    Q_INVOKABLE Slide *getSlide(int index) const;
private:
    QList<Slide *> mSlideList;

};

#endif // BLOCKSMODEL_H
