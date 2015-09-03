#ifndef BLOCKSMODEL_H
#define BLOCKSMODEL_H

#include <QAbstractListModel>

//class ContentBlock;
class Slide;

class SlideModel : public QAbstractListModel
{
    Q_OBJECT
public:
//    enum ContentBlockRoles
//    {
//        ContentBlockTypeRole = Qt::UserRole + 1,
//        SpecificContentRole,
//        WidthRole,
//        HeightRole,
//        XRole,
//        YRole,
//        ZRole,
//    };

    explicit SlideModel(QObject *parent = 0);
    ~SlideModel();

//    QVariant data(const QModelIndex &index, int role) const;
//    int rowCount(const QModelIndex &parent) const;
//    QHash<int, QByteArray>  roleNames() const;
    Q_INVOKABLE void addSlide();
    Q_INVOKABLE void deleteSlide(int index);

private:
//    QHash<int, QByteArray> mRoleHash;
//    QList<ContentBlock *> mBlocksList;
    QList<Slide *> mSlideList;

};

#endif // BLOCKSMODEL_H
