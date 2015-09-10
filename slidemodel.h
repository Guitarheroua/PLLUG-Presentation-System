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

    explicit SlideModel(QObject *parent = 0);
    ~SlideModel();

    QHash<int, QByteArray> roleNames() const;
    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;

    void append(ContentBlock *item);

private:
    ContentBlock *mRoot;

};

#endif // BLOCKSMODEL_H
