#include "blocksview.h"
#include "blocksmodel.h"
#include <QQuickView>
#include <QQmlEngine>
#include <QDebug>
#include <QAbstractItemModel>

BlocksView::BlocksView(QQuickItem *parent) :
    QQuickItem(parent)
   ,mEngine(new QQmlEngine())
{
    connect(this, SIGNAL(modelChanged()), this, SLOT(test()));
}

void BlocksView::setModel(BlocksModel *pModel)
{
    mModel = pModel;
    qDebug() << mModel;
    emit modelChanged();
}

BlocksModel *BlocksView::model()
{
    return mModel;
}


void BlocksView::test()
{
    if ( mModel )
    {
        qDebug() << "model";
        for (int i=0; i < mModel->rowCount(QModelIndex()); ++i)
        {
            QModelIndex index = mModel->index(i,0);
            QString lType = mModel->data(index,mModel->SourceTypeRole).toString();
            QString lSource = mModel->data(index,mModel->SourceRole).toString();
            int lWidth = mModel->data(index,mModel->WidthRole).toInt();
            int lHeight = mModel->data(index,mModel->HeightRole).toInt();
//            float lX = mModel->data(index,mModel->XRole).toInt();
//            float lY = mModel->data(index,mModel->YRole).toInt();
            QQuickItem* item = createItem(lType,lSource,lWidth,lHeight);
            if (item)
            {
                item->setParentItem(this);
            }
        }

    }
}

QQuickItem *BlocksView::createItem(QString pType, QString pSource, int pWidth, int pHeight)
{
    Q_UNUSED(pType);
    QQmlComponent *component = new QQmlComponent(mEngine,QUrl::fromLocalFile("VideoItem.qml"));
    QObject *object = component->create();

    QQuickItem *item = qobject_cast<QQuickItem*>(object);
    item->setProperty("source", pSource);
    item->setProperty("width", pWidth);
    item->setProperty("height", pHeight);

    if (item)
    {
        qDebug() << "source" << item->property("source").toString();
    }
    return item;
}
