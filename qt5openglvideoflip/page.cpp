#include "page.h"
#include "blocksmodel.h"
#include <QQmlEngine>
#include <QDebug>
#include <QDir>

Page::Page(QVariantMap pMap,QQuickItem *parent) :
    QQuickItem(parent)
{
    mEngine = new QQmlEngine();

    QQmlComponent *component = new QQmlComponent(mEngine,QUrl("qrc:/qml/rectangle.qml"));
    QObject *object = component->create();
    mBackgroundRect = qobject_cast<QQuickItem*>(object);

    mBlockModel = new BlocksModel();
    QString lBackColor = pMap.value("background-color").toString();
    mBackgroundRect->setProperty("color", lBackColor);
    QVariantList lVarBlockList = pMap.value("blocks").toList();
    foreach(QVariant lvarBlock, lVarBlockList)
    {
        mBlockModel->addBlock(new Block(lvarBlock.toMap()));
    }
    connect(this, SIGNAL(modelChanged()), this, SLOT(test()));
    emit modelChanged();


    mBackgroundRect->setParentItem(this);
    this->setProperty("height", 800);
    this->setProperty("width", 800);

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

void Page::test()
{
    if ( mBlockModel )
    {
        for (int i=0; i < mBlockModel->rowCount(QModelIndex()); ++i)
        {
            QModelIndex index = mBlockModel->index(i,0);
            QString lType = mBlockModel->data(index,mBlockModel->SourceTypeRole).toString();
            QString lSource = mBlockModel->data(index,mBlockModel->SourceRole).toString();
            int lWidth = mBlockModel->data(index,mBlockModel->WidthRole).toInt();
            int lHeight = mBlockModel->data(index,mBlockModel->HeightRole).toInt();
            float lX = mBlockModel->data(index,mBlockModel->XRole).toFloat();
            float lY = mBlockModel->data(index,mBlockModel->YRole).toFloat();
            QQuickItem* item = createItem(lType,lSource,lWidth,lHeight,lX,lY);
        }

    }
}


QQuickItem *Page::createItem(QString pType, QString pSource, int pWidth, int pHeight,float pX, float pY)
{
    QQmlComponent *component = new QQmlComponent(mEngine,QUrl("qrc:/qml/" + pType + ".qml"));
    QObject *object = component->create();

    QQuickItem *item = qobject_cast<QQuickItem*>(object);
    if (pType == "web")
    {
        item->setProperty("source", pSource);
    }
    else
    {
        item->setProperty("source", "qrc:/" + pType + "/" + pSource);
    }
    item->setProperty("mainWidth", pWidth);
    item->setProperty("mainHeight", pHeight);
    item->setProperty("mainX", pX);
    item->setProperty("mainY", pY);
    item->setProperty("width", pWidth);
    item->setProperty("height", pHeight);
    item->setProperty("x", pX);
    item->setProperty("y", pY);

    if (item)
    {
//        qDebug() << "source" << item->property("source").toString();
        item->setParentItem(mBackgroundRect);
    }
    return item;
}
