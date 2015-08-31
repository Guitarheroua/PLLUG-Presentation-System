#ifndef BLOCKSMODEL_H
#define BLOCKSMODEL_H

#include <QAbstractListModel>

class ContentBlock;

class SlideModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum ContentBlockRoles
    {
        ContentBlockTypeRole = Qt::UserRole + 1,
        SoursesRole,
        WidthRole,
        HeightRole,
        XRole,
        YRole,
        ZRole,
    };

    explicit SlideModel(QObject *parent = 0);
    ~SlideModel();

    QVariant data(const QModelIndex &index, int role) const;
    int rowCount(const QModelIndex &parent) const;
    QHash<int, QByteArray>  roleNames() const;
    void addBlock(ContentBlock *contentBlock);
    Q_INVOKABLE void addBlock2(int x, int y, int width, int height,
                             int z, QVariant contentBlockType);
private:
    QHash<int, QByteArray> mRoleHash;
    QList<ContentBlock *> mBlocksList;

};

#endif // BLOCKSMODEL_H
