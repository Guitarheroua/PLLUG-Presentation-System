#ifndef SLIDE_H
#define SLIDE_H

#include <QQuickItem>
#include "block.h"

class Helper;
class BlocksModel;
class QQmlEngine;
class BlocksModel;
class Slide : public QQuickItem
{
    Q_OBJECT
public:
    Slide(QVariantMap,const QString&, const QSize&, QQuickItem *parent = 0);
    Slide(QQuickItem *content = 0, QQuickItem *parent = 0);
    ~Slide();
    void setModel(BlocksModel* pModel);
    BlocksModel *blockModel() const;


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
    QQuickItem *mSlide;
    Helper *mHelper;
};

#endif // SLIDE_H
