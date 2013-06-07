#include "page.h"
#include "blocksmodel.h"
#include <QQmlEngine>
#include <QDebug>
#include <QDir>

Page::Page(QVariantMap pMap, const QString& pContentDir, const QSize &pSize, QQuickItem *parent) :
    QQuickItem(parent)
{
    mEngine = new QQmlEngine();
    mContentDir = pContentDir;

//    QQmlComponent *component = new QQmlComponent(mEngine,QUrl("qrc:/qml/rectangle.qml"));
    QQmlComponent *component = new QQmlComponent(mEngine,QUrl("qml/rectangle.qml"));
    QObject *object = component->create();
    mBackgroundRect = qobject_cast<QQuickItem*>(object);

    connect(this,SIGNAL(widthChanged()), this, SLOT(slotPageWidgthChanged()));
    connect(this,SIGNAL(heightChanged()), this, SLOT(slotPageHeightChanged()));

    this->setWidth(pSize.width());
    this->setHeight(pSize.height());

    mBlockModel = new BlocksModel();
    QString lBackColor = pMap.value("background-color").toString();
    mBackgroundRect->setProperty("color", lBackColor);
    QString lBackImage = pMap.value("background-image").toString();
    mBackgroundRect->setProperty("backgroundImage", "file:///" + mContentDir  + "/image/" + lBackImage);
    QVariantList lVarBlockList = pMap.value("blocks").toList();
    foreach(QVariant lvarBlock, lVarBlockList)
    {
        mBlockModel->addBlock(new Block(lvarBlock.toMap()));
    }
    mBackgroundRect->setParentItem(this);
    connect(this, SIGNAL(modelChanged()), this, SLOT(createBlocks()));

    emit modelChanged();
}

Page::~Page()
{
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

            QQuickItem* item = createItem(lMediaContent,lCaption,lWidth,lHeight,lX,lY,lBackground);
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


QQuickItem *Page::createItem(Block::MediaContent pMediaContent, Block::Caption pCaption, int pWidth, int pHeight,float pX, float pY, QString pBackgrond)
{
    QQmlComponent *component = new QQmlComponent(mEngine, QUrl("qml/" + pMediaContent.type + ".qml"));
    QObject *object = component->create();

    qDebug() << component->errorString();

    QQuickItem *item = qobject_cast<QQuickItem*>(object);
    if (pMediaContent.type == "web")
    {
        item->setProperty("source", pMediaContent.source);
    }
    else
    {
        item->setProperty("source", "file:///" + mContentDir  + "/" + pMediaContent.type + "/" + pMediaContent.source);
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
    if (item)
    {
//        qDebug() << "source" << item->property("source").toString();
        item->setParentItem(mBackgroundRect);
    }
    return item;
}
