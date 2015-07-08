#ifndef BLOCKSVIEW_H
#define BLOCKSVIEW_H

#include <QQuickItem>

class BlocksModel;
class QQmlEngine;
class BlocksView : public QQuickItem
{
    Q_OBJECT
public:
    explicit BlocksView(QQuickItem *parent = 0);
    void setModel(BlocksModel* pModel);
    BlocksModel* model();
    
signals:
    void modelChanged();
    
public slots:
    void test();

private:
    QQuickItem* createItem(QString pType, QString pSource, int pWidth, int pHeight);

private:
    BlocksModel* mModel;
    QQmlEngine* mEngine;
    
};

#endif // BLOCKSVIEW_H

