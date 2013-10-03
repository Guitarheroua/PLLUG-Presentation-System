#include "page.h"
#include "blocksmodel.h"
#include <QQmlEngine>
#include <QDebug>
#include <QDir>
#include <QApplication>
#include "helper.h"

Page::Page(QVariantMap pMap, const QString& pContentDir, const QSize &pSize, QQuickItem *parent) :
    QQuickItem(parent)
{
    mEngine = new QQmlEngine();
    mContentDir = pContentDir;

    QQmlComponent *component = new QQmlComponent(mEngine,QUrl::fromLocalFile(QString::fromLatin1("%1/../qml/DemoView/rectangle.qml").arg(pContentDir)));
    QObject *object = component->create();
    mBackgroundRect = qobject_cast<QQuickItem*>(object);

    connect(this,SIGNAL(widthChanged()), this, SLOT(slotPageWidgthChanged()));
    connect(this,SIGNAL(heightChanged()), this, SLOT(slotPageHeightChanged()));

    this->setProperty("width",pSize.width());
    this->setProperty("height",pSize.height());
    mBackgroundRect->setProperty("width",pSize.width());
    mBackgroundRect->setProperty("height",pSize.height());

    QString lBackColor = pMap.value("background-color").toString();
    mBackgroundRect->setProperty("color", lBackColor);
    QString lBackImage = pMap.value("background-image").toString();
    if (!lBackImage.isEmpty())
    {
        mBackgroundRect->setProperty("backgroundImage", QUrl::fromLocalFile(QString::fromLatin1("%1/image/%2").arg(mContentDir).arg(lBackImage)));
    }

    QVariantList lVarBlockList = pMap.value("blocks").toList();
    mBlockModel = new BlocksModel();
    foreach(QVariant lvarBlock, lVarBlockList)
    {
        mBlockModel->addBlock(new Block(lvarBlock.toMap()));
    }
    mBackgroundRect->setParentItem(this);
    connect(this, SIGNAL(modelChanged()), this, SLOT(createBlocks()));

    emit modelChanged();
}

Page::Page(QQuickItem *content, QQuickItem *parent)
{
    QQmlComponent *component = new QQmlComponent(mEngine,"/qml/DemoView/rectangle.qml");
    QObject *object = component->create();
    mBackgroundRect = qobject_cast<QQuickItem*>(object);

    connect(this,SIGNAL(widthChanged()), this, SLOT(slotPageWidgthChanged()));
    connect(this,SIGNAL(heightChanged()), this, SLOT(slotPageHeightChanged()));

    this->setWidth(content->width());
    this->setHeight(content->height());

    mBackgroundRect->setParentItem(this);
    content->setParentItem(mBackgroundRect);
}

Page::~Page()
{
    delete mEngine;
    delete mBlockModel;
}


void Page::setModel(BlocksModel *pModel)
{
    mBlockModel = pModel;
    emit modelChanged();
}

BlocksModel *Page::blockModel() const
{
    return mBlockModel;
}

bool Page::test1(qreal x, qreal y)
{
    return true;
}

void Page::createBlocks()
{
    if ( mBlockModel )
    {
        for (int i=0; i < mBlockModel->rowCount(QModelIndex()); ++i)
        {
            QModelIndex index = mBlockModel->index(i,0);
            QString lType = mBlockModel->data(index,mBlockModel->SourceTypeRole).toString();
            QString lSource = mBlockModel->data(index,mBlockModel->SourceRole).toString();
            QString lBackground = mBlockModel->data(index,mBlockModel->BackgroundRole).toString();
            Block::MediaContent lMediaContent = mBlockModel->data(index,mBlockModel->MediaContentRole).value<Block::MediaContent>();
            Block::Caption lCaption = mBlockModel->data(index,mBlockModel->CaptionRole).value<Block::Caption>();
            int lWidth = mBlockModel->data(index,mBlockModel->WidthRole).toInt();
            int lHeight = mBlockModel->data(index,mBlockModel->HeightRole).toInt();
            float lX = mBlockModel->data(index,mBlockModel->XRole).toFloat();
            float lY = mBlockModel->data(index,mBlockModel->YRole).toFloat();

            createItem(lMediaContent,lCaption,lWidth,lHeight,lX,lY,lBackground);
        }

    }
}

void Page::slotPageWidgthChanged()
{
    mBackgroundRect->setProperty("width", this->width());
}

void Page::slotPageHeightChanged()
{
    mBackgroundRect->setProperty("height", this->height());
}

void Page::webViewUrlChanged(QString pUrl )
{
    qDebug() << "____________________" << pUrl;
    QQuickItem *item = qobject_cast<QQuickItem*>(sender());
    QQuickItem *child = item->findChild<QQuickItem*>("fullScreenImage",Qt::FindChildrenRecursively);
    QQuickItem* newitem = item;
    qDebug() << item->objectName() << newitem->objectName()<<  child->property("state").toString();
    if (child->property("state").toString() == "full" )
    {
        emit fullBrowser(newitem);
    }

}


QQuickItem *Page::createItem(Block::MediaContent pMediaContent, Block::Caption pCaption, int pWidth, int pHeight,float pX, float pY, QString pBackgrond)
{
    QQmlComponent *component = new QQmlComponent(mEngine, QUrl::fromLocalFile(QString::fromLatin1("%1/../qml/DemoView/%2.qml").arg(mContentDir).arg(pMediaContent.type)));
    QObject *object = component->create();

    QQuickItem *item = qobject_cast<QQuickItem*>(object);
    if (!item)
    {
        qDebug() << "\nCan't create item\n";
        return NULL;
    }

    item->setParentItem(mBackgroundRect);
    item->setFlags(QQuickItem::ItemHasContents);

    if (pMediaContent.type == "web")
    {
        item->setProperty("source", pMediaContent.source);
        //        connect(item, SIGNAL(urlChanged(QString)), this, SLOT(webViewUrlChanged(QString)));
    }
    else
    {
        item->setProperty("source", QUrl::fromLocalFile(QString::fromLatin1("%1/%2/%3").arg(mContentDir).arg(pMediaContent.type).arg(pMediaContent.source)));
    }
    item->setProperty("color", pBackgrond);
    item->setProperty("aspect", pMediaContent.aspect);
    item->setProperty("widthCoeff", pWidth/mBackgroundRect->width());
    item->setProperty("heightCoeff", pHeight/mBackgroundRect->height());
    item->setProperty("xCoeff", pX/mBackgroundRect->width());
    item->setProperty("yCoeff", pY/mBackgroundRect->height());

    item->setProperty("fontSize", pCaption.fontSize);
    item->setProperty("fontFamily", pCaption.fontFamily);
    item->setProperty("captionAlign", pCaption.align);
    item->setProperty("textAlign", pCaption.textAlign);
    QQuickItem *lCaption = item->findChild<QQuickItem*>("Caption",Qt::FindChildrenRecursively);
    if (lCaption)
    {
        lCaption->setProperty("color",  pCaption.background);
        QQuickItem *lCaptionText = item->findChild<QQuickItem*>("CaptionText",Qt::FindChildrenRecursively);
        if (lCaptionText)
        {
            lCaptionText->setProperty("text", pCaption.text );
            lCaptionText->setProperty("color", pCaption.color );
        }
    }

    return item;
}
