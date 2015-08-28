#ifndef BLOCKSMODEL_H
#define BLOCKSMODEL_H

#include <QAbstractListModel>
#include <QHash>

class ContentBlock;

class SlideModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum ContentBlockRoles
    {
        ContentBlockTypeRole = Qt::UserRole + 1,
        SoursesRole = Qt::UserRole + 2,
        WidthRole = Qt::UserRole + 3,
        HeightRole = Qt::UserRole + 4,
        XRole = Qt::UserRole + 5,
        YRole = Qt::UserRole + 6,
        ZRole = Qt::UserRole + 7,
    };

    explicit SlideModel(QObject *parent = 0);
    ~SlideModel();

    QVariant data(const QModelIndex &index, int role) const;
    int rowCount(const QModelIndex &parent) const;
    QHash<int, QByteArray>  roleNames() const;
    void addBlock(ContentBlock *contentBlock);

private:
    QHash<int, QByteArray> mRoleHash;
    QList<ContentBlock *> mBlocksList;
};

#endif // BLOCKSMODEL_H
