#ifndef PAGE_H
#define PAGE_H

#include <QQuickItem>

class BlocksModel;
class QQmlEngine;
class BlocksModel;
class Page : public QQuickItem
{
    Q_OBJECT
public:
    Page(QVariantMap pMap,QQuickItem *parent = 0);
    ~Page();
    void setModel(BlocksModel* pModel);
    BlocksModel *blockModel() const;

    Q_INVOKABLE bool test1(qreal x, qreal y);

signals:
    void modelChanged();

public slots:
    void test();

public:
    QQuickItem* createItem(QString pType, QString pSource, int pWidth, int pHeight, float pX, float pY);

private:
    BlocksModel *mBlockModel;
    QQmlEngine* mEngine;
    QQuickItem *mBackgroundRect;
};

#endif // PAGE_H
