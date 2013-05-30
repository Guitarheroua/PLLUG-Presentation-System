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
        TitleRole = Qt::UserRole + 1,
        SourceTypeRole = Qt::UserRole + 2,
        SourceRole = Qt::UserRole + 3,
        WidthRole = Qt::UserRole + 4,
        HeightRole = Qt::UserRole + 5,
        XRole = Qt::UserRole + 6,
        YRole = Qt::UserRole + 7
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
