#ifndef PAGE_H
#define PAGE_H

#include <QQuickItem>
#include "block.h"

class BlocksModel;
class QQmlEngine;
class BlocksModel;
class Page : public QQuickItem
{
    Q_OBJECT
public:
    Page(QVariantMap pMap, const QString& pContentDir, QQuickItem *parent = 0);
    ~Page();
    void setModel(BlocksModel* pModel);
    BlocksModel *blockModel() const;

    Q_INVOKABLE bool test1(qreal x, qreal y);

signals:
    void modelChanged();

public slots:
    void createBlocks();
    void slotPageWidgthChanged();
    void slotPageHeightChanged();

public:
    QQuickItem* createItem(Block::MediaContent pMediaContent, Block::Caption pCaption, int pWidth, int pHeight, float pX, float pY,  QString pBackgrond);

private:
    QString mContentDir;
    BlocksModel *mBlockModel;
    QQmlEngine* mEngine;
    QQuickItem *mBackgroundRect;
};

#endif // PAGE_H
