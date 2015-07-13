#ifndef BLOCKSMODEL_H
#define BLOCKSMODEL_H

#include <QAbstractListModel>
#include <QHash>
#include "block.h"

class BlocksModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum BlockRoles
    {
        CaptionRole = Qt::UserRole + 1,
        MediaContentRole = Qt::UserRole + 2,
        SourceTypeRole = Qt::UserRole + 3,
        SourceRole = Qt::UserRole + 4,
        WidthRole = Qt::UserRole + 5,
        HeightRole = Qt::UserRole + 6,
        XRole = Qt::UserRole + 7,
        YRole = Qt::UserRole + 8,
        BackgroundRole = Qt::UserRole + 9
    };
    explicit BlocksModel(QObject *parent = 0);
    ~BlocksModel();
    QVariant data(const QModelIndex &index, int role) const;
    int rowCount(const QModelIndex &parent) const;
    QHash<int, QByteArray>  roleNames() const;
    void addBlock(Block *pBlock);

signals:
    
private:
    QHash<int, QByteArray> mRoleHash;
    QList<Block*> mBlocksList;
};

#endif // BLOCKSMODEL_H
