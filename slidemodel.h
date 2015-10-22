#ifndef BLOCKSMODEL_H
#define BLOCKSMODEL_H

#include <QAbstractListModel>

class ContentBlock;

class SlideModel : public QAbstractTableModel
{
    Q_OBJECT
public:
    enum Roles
    {
        XRole = Qt::UserRole + 1,
        YRole,
        ZRole,
        WidthRole,
        HeightRole,
        TypeRole,
        AdditionalContentRole
    };

    explicit SlideModel(QObject *parent = nullptr);
    explicit SlideModel(ContentBlock *root, QObject *parent = nullptr);
    ~SlideModel();

    QHash<int, QByteArray> roleNames() const;
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    int columnCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

    Q_INVOKABLE void append(ContentBlock *item = nullptr);
    Q_INVOKABLE void insert(int row, ContentBlock *child = nullptr);
    Q_INVOKABLE void swap(int firstRow, int secondRow);
    Q_INVOKABLE void remove(int row);
    Q_INVOKABLE SlideModel *getModelFromChild(int row);
    Q_INVOKABLE ContentBlock *getChild(int row) const;

private:
    ContentBlock * mRoot;
    QHash<QString, SlideModel *> mChildsModelsHash;
};

#endif // BLOCKSMODEL_H
