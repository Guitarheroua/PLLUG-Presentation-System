#ifndef BLOCKSMODEL_H
#define BLOCKSMODEL_H

#include <QAbstractListModel>

class ContentBlock;

class SlideModel : public QAbstractListModel
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
    ~SlideModel();

    QHash<int, QByteArray> roleNames() const;
    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;

    Q_INVOKABLE void append(ContentBlock *item);
    Q_INVOKABLE void changeParent(ContentBlock *item);
    Q_INVOKABLE ContentBlock *getChild(int index) const;

private:
    ContentBlock *mRoot;
};

#endif // BLOCKSMODEL_H
