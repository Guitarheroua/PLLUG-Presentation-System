#ifndef PAGE_H
#define PAGE_H

#include <QQuickItem>
#include "block.h"

class Helper;
class BlocksModel;
class QQmlEngine;
class BlocksModel;
class Page : public QQuickItem
{
    Q_OBJECT
public:
    Page(QVariantMap pMap, const QString& pContentDir, const QSize& pSize, QQuickItem *parent = 0);
    Page(QQuickItem *content = 0, QQuickItem *parent = 0);
    ~Page();
    void setModel(BlocksModel* pModel);
    BlocksModel *blockModel() const;

    Q_INVOKABLE bool test1(qreal x, qreal y);

signals:
    void modelChanged();
    void fullBrowser(QQuickItem*);

public slots:
    void createBlocks();
    void slotPageWidgthChanged();
    void slotPageHeightChanged();
    void webViewUrlChanged(QString);

public:
    QQuickItem* createItem(Block::MediaContent pMediaContent, Block::Caption pCaption, int pWidth, int pHeight, float pX, float pY,  QString pBackgrond);

private:
    QString mContentDir;
    BlocksModel *mBlockModel;
    QQmlEngine* mEngine;
    QQuickItem *mBackgroundRect;
    Helper *mHelper;
};

#endif // PAGE_H
