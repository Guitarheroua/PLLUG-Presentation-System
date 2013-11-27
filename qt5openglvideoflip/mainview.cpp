#include "mainview.h"
#include <QQuickView>
#include <QtWidgets/QApplication>
#include <QtWidgets/QDesktopWidget>
#include <QQmlContext>
#include <QQmlEngine>
#include <QUrl>
#include <QFile>
#include <QDir>
#include <QDebug>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>
#include <QMessageBox>

#include "megaparse.h"
#include "blocksview.h"
#include "slide.h"
#include "helper.h"

#if defined(Q_OS_WIN)
#include "qt_windows.h"
#endif

MainView::MainView(const QString &pContentDir, QWindow *parent) :
    QQuickView(parent)
{
    //    mParser = new MegaParse(this);
    //    mParser->setContentDir(pContentDir);
    //    qDebug() << "content dir = " << pContentDir;
    //    mParser->parsePagesData();
    //    mParser->parseTemplatesData();
    mContentDir = pContentDir;
    this->setSurfaceType(QQuickView::OpenGLSurface);

    mHelper = new Helper();
    connect(mHelper, SIGNAL(open(QString)), this, SLOT(openPresentation(QString)));
    this->rootContext()->setContextProperty("helper",mHelper);
    this->rootContext()->setContextProperty("screenPixelWidth", qApp->desktop()->screenGeometry().width());
    this->rootContext()->setContextProperty("screenPixelHeight",qApp->desktop()->screenGeometry().height());

    //    QDir dir( pContentDir+"/image/");
    //    QStringList list;
    //    foreach (QFileInfo file, dir.entryInfoList(QDir::AllEntries | QDir::NoDotAndDotDot))
    //    {
    //        list.append("file:///" + file.absoluteFilePath());
    //    }
    //    this->rootContext()->setContextProperty("filesModel", list);


    QString lSourceFile = QString::fromLatin1("%1/../qml/DemoView/main.qml").arg(pContentDir);
    this->setSource(QUrl::fromLocalFile(lSourceFile));

    //    QQuickItem *rootItem = this->rootObject();

    //    for (int i=0; i < mParser->pagesList().count(); i++)
    //    {
    //        Page* item = mParser->pagesList().at(i);
    //        item->setVisible(false);
    //        item->setVisible((i == 0));
    //        item->setParentItem(rootItem);
    //        // connect(item, SIGNAL(fullBrowser(QQuickItem*)), this, SLOT(test(QQuickItem*)));
    //        mPagesList.append(item);
    //    }
    this->setResizeMode(QQuickView::SizeRootObjectToView);


    mActualSize = QSize(qApp->desktop()->screenGeometry().width()/1.1, qApp->desktop()->screenGeometry().height()/1.1);
    mOldSize = mActualSize;
    mAspectRatio = (qreal)mActualSize.width() / mActualSize.height();
    resize(mActualSize);

    //    connect(this, SIGNAL(heightChanged(int)), this, SLOT(test1(int)));
}

void MainView::savePresentation(const QString& pPath)
{
    QFile lFile("test.json");
    if (lFile.open(QIODevice::WriteOnly))
    {
        QJsonObject lObject;
        lObject.insert("name", QJsonValue(QString("Test Presentation")));
        lObject.insert("schemeVersion", QJsonValue(QString("1.0")));

        QQuickItem* lPresentation = this->rootObject()->findChild<QQuickItem*>("PresentationLoader")->property("item").value<QQuickItem*>();
        QVariantList lSlides =  lPresentation->property("slides").value<QVariantList>();
        QJsonObject lJsonSlide;
        QJsonArray lSlidesArray;
        foreach (QVariant lSlide, lSlides)
        {
            QQuickItem* slide = lSlide.value<QQuickItem*>();
            qDebug() << slide->property("title");
            lJsonSlide = QJsonObject();
            lJsonSlide.insert("title",QJsonValue(QString(slide->property("title").toString())));
            QJsonArray lEffects;
            QList<QQuickItem*> lBlockList;
            foreach (QQuickItem* item, slide->childItems())
            {
                lBlockList.clear();
                QString lObjectName = item->objectName();
                qDebug() << lObjectName;
                QString lLayoutName = slide->property("layout").toString().remove("layouts/");
                lJsonSlide.insert("layout", QJsonValue(QString(lLayoutName.remove(lLayoutName.length()-4,4))));
                if (lObjectName.contains("background/"))
                {
                    QString lEffectName = lObjectName.remove(0,11);
                    lEffects.append(QJsonValue(QString(lEffectName.remove(lEffectName.length()-4,4))));
                }
                else if (lObjectName=="layout" && lLayoutName != "")
                {

                    QJsonArray lJsonBlocksArray;
                    QQuickItem* lBlocksView = item->findChild<QQuickItem*>("blocksView", Qt::FindChildrenRecursively);
                    if (lBlocksView)
                    {
                        int lBlocksCount = lBlocksView->property("model").toInt();
                        for(int i=0; i<lBlocksCount; ++i)
                        {
                            lBlocksView->setProperty("currentIndex",i);
                            QQuickItem* l = lBlocksView->property("currentItem").value<QQuickItem*>();
                            lBlockList.append(l->findChild<QQuickItem*>("block", Qt::FindChildrenRecursively));
                        }
                        qDebug() << "\nBLOCK VIEW\n" << lBlocksView->property("model");
                    }
                    else
                    {
                        lBlockList = item->findChildren<QQuickItem*>("block", Qt::FindChildrenRecursively);
                    }
                    foreach(QQuickItem* blockLoader, lBlockList)
                    {
                        qDebug() << "^^^^^^";
                        QJsonObject lJsonBlock;
                        QQuickItem* lBlock = blockLoader->property("contentItem").value<QQuickItem*>();
                        QString lBlockType = lBlock->property("type").toString();
                        lJsonBlock.insert("type", QJsonValue(QString(lBlockType)));
                        if ("text" == lBlockType)
                        {
                            lJsonBlock.insert("fontFamily", QJsonValue(QString(lBlock->property("fontFamily").toString())));
                            lJsonBlock.insert("fontColor", QJsonValue(QString(lBlock->property("fontColor").toString())));
                            lJsonBlock.insert("fontBold", QJsonValue(bool(lBlock->property("fontBold").toBool())));
                            lJsonBlock.insert("fontItalic", QJsonValue(bool(lBlock->property("fontItalic").toBool())));
                            lJsonBlock.insert("fontSize", QJsonValue(double(lBlock->property("fontSize").toDouble())));
                            lJsonBlock.insert("fontUnderline", QJsonValue(bool(lBlock->property("fontUnderline").toBool())));
                            lJsonBlock.insert("fontStrikeout", QJsonValue(bool(lBlock->property("fontStrikeout").toBool())));
                        }
                        else
                        {
                            lJsonBlock.insert("source", QJsonValue(QString(lBlock->property("source").toString())));
                        }
                        lJsonBlock.insert("widthCoeff", QJsonValue(QString(lBlock->property("widthCoeff").toString())));
                        lJsonBlock.insert("heightCoeff", QJsonValue(QString(lBlock->property("heightCoeff").toString())));
                        lJsonBlock.insert("xCoeff", QJsonValue(QString(lBlock->property("xCoeff").toString())));
                        lJsonBlock.insert("yCoeff", QJsonValue(QString(lBlock->property("yCoeff").toString())));
                        lJsonBlocksArray.append(lJsonBlock);
                    }
                    qDebug() << "\n~~~~~~\n" << lJsonBlocksArray;
                    lJsonSlide.insert("blocks",lJsonBlocksArray);
                }
            }
            lJsonSlide.insert("effects",lEffects);

            qDebug() << "\n++++++\n" << lJsonSlide;
            lSlidesArray.append(lJsonSlide);
        }
        lObject.insert("slides", lSlidesArray);

        QJsonDocument lDoc;
        lDoc.setObject(lObject);
        lFile.write(lDoc.toJson());
    }
}

void MainView::openPresentation(const QString& pPath)
{
    QString jsonData;
    QFile lFile(pPath);
    qDebug() << pPath;
    if (lFile.open(QFile::ReadOnly))
    {
        QTextStream in(&lFile);
        jsonData = in.readAll();
    }
    else
    {
        QMessageBox::warning(0, tr("Error"), tr("Can't open presentation"), QMessageBox::Ok, QMessageBox::Cancel);
        return;
    }
    QJsonDocument jsonDoc = QJsonDocument::fromJson(jsonData.toUtf8());
    QString lPresentationName = jsonDoc.toVariant().toMap().value("name").toString();
    QString lSchemeVersion = jsonDoc.toVariant().toMap().value("schemeVersion").toString();
    qDebug() << lPresentationName << lSchemeVersion;


    QQuickItem* lLoader = this->rootObject()->findChild<QQuickItem*>("PresentationLoader", Qt::FindChildrenRecursively);
    lLoader->setProperty("source",QUrl::fromLocalFile(QString::fromLatin1("%1/../qml/DemoView/presentation/Presentation.qml").arg(mContentDir)));

    QVariantList lSlidesList = jsonDoc.toVariant().toMap().value("slides").toList();
    qDebug() << lSlidesList;
    QVariant var;
    QQuickItem* pres = lLoader->property("item").value<QQuickItem*>();
    QVariantList lSlidesItemList;

    int i=0;
    QQmlEngine* lEngine = new QQmlEngine();
    QQmlContext* lContext = lEngine->rootContext();
    lContext->setContextProperty("helper",mHelper);
    lContext->setContextProperty("screenPixelWidth", qApp->desktop()->screenGeometry().width());
    lContext->setContextProperty("screenPixelHeight",qApp->desktop()->screenGeometry().height());

    QList<QQuickItem*> lBlocksItemList;
    foreach(QVariant slide, lSlidesList)
    {
        QVariantMap lSlideMap = slide.toMap();
        qDebug() << lSlideMap;
        lBlocksItemList.clear();
        QQmlComponent *component = new QQmlComponent(lEngine,QUrl::fromLocalFile(QString::fromLatin1("%1/../qml/DemoView/presentation/Slide.qml").arg(mContentDir)));
        QObject *object = component->create();
        qobject_cast<QQuickItem*>(object)->setParentItem(pres);

        //        QQuickItem* item = new Slide(slide.toMap(), mContentDir, QSize(qApp->desktop()->screenGeometry().width()/1.5, qApp->desktop()->screenGeometry().height()/1.5));
        var.setValue<QObject*>(object);
        QMetaObject::invokeMethod(pres, "newSlide", Q_ARG(QVariant, var), Q_ARG(QVariant, i));
        lSlidesItemList = pres->property("slides").value<QVariantList>();
        QQuickItem* lSlideItem = lSlidesItemList.at(i).value<QQuickItem*>();
        lSlideItem->setProperty("title", lSlideMap.value("title").toString() );
        qDebug() << lSlideMap.value("title").toString();
        lSlideItem->setProperty("layout", lSlideMap.value("layout").toString() );
        if (slide.toMap().value("layout").toString() != "")
        {
            QQmlComponent *c = new QQmlComponent(lEngine,QUrl::fromLocalFile(QString::fromLatin1("%1/../qml/DemoView/layouts/%2.qml").arg(mContentDir).arg(slide.toMap().value("layout").toString())));
            QObject *o = c->create();
            QQuickItem* layout = qobject_cast<QQuickItem*>(o);
            layout->setParentItem(lSlideItem);
            layout->setObjectName("layout");
            QQuickItem* lBlocksView = layout->findChild<QQuickItem*>("blocksView", Qt::FindChildrenRecursively);
            if (lBlocksView)
            {
                int lBlocksCount = lBlocksView->property("model").toInt();
                for(int i=0; i<lBlocksCount; ++i)
                {
                    lBlocksView->setProperty("currentIndex",i);
                    QQuickItem* l = lBlocksView->property("currentItem").value<QQuickItem*>();
                    lBlocksItemList.append(l->findChild<QQuickItem*>("block", Qt::FindChildrenRecursively));
                }
                qDebug() << "\nBLOCK VIEW\n" << lBlocksView->property("model");
            }
            else
            {
                lBlocksItemList = layout->findChildren<QQuickItem*>("block", Qt::FindChildrenRecursively);
            }
            QVariantList lBlocksJsonList = slide.toMap().value("blocks").toList();
            qDebug() << "\nblocks\n" << lBlocksItemList << lBlocksJsonList ;
            int i=0;
            foreach(QQuickItem* blockItem, lBlocksItemList)
            {
                qDebug() << "^^^^^^" ;
                QVariantMap lBlockMap = lBlocksJsonList.at(i).toMap();
                QString lBlockType = lBlockMap.value("type").toString();
                QString lItemName = lBlockType;
                if ("text" == lBlockType)
                {
                    lItemName = "textItem";
                }

                QQuickItem* lBlockLoader = blockItem->findChild<QQuickItem*>("blockLoader");
                qDebug() << "..." << lBlockLoader;
                    qDebug() << QUrl::fromLocalFile(QString::fromLatin1("%1/../qml/DemoView/items/%2.qml").arg(mContentDir).arg(lItemName));
                lBlockLoader->setProperty("source", QUrl::fromLocalFile(QString::fromLatin1("%1/../qml/DemoView/items/%2.qml").arg(mContentDir).arg(lItemName)));
                blockItem->findChild<QQuickItem*>("menu")->setProperty("visible", false);
                qDebug() << "/////";
                QQuickItem* lBlock = lBlockLoader->property("item").value<QQuickItem*>();
                lBlock->setProperty("source", lBlockMap.value("source") );
                i++;
////                lJsonBlock.insert("type", QJsonValue(QString(lBlockType)));
////                if ("text" == lBlockType)
////                {
////                    lJsonBlock.insert("fontFamily", QJsonValue(QString(lBlock->property("fontFamily").toString())));
////                    lJsonBlock.insert("fontColor", QJsonValue(QString(lBlock->property("fontColor").toString())));
////                    lJsonBlock.insert("fontBold", QJsonValue(bool(lBlock->property("fontBold").toBool())));
////                    lJsonBlock.insert("fontItalic", QJsonValue(bool(lBlock->property("fontItalic").toBool())));
////                    lJsonBlock.insert("fontSize", QJsonValue(double(lBlock->property("fontSize").toDouble())));
////                    lJsonBlock.insert("fontUnderline", QJsonValue(bool(lBlock->property("fontUnderline").toBool())));
////                    lJsonBlock.insert("fontStrikeout", QJsonValue(bool(lBlock->property("fontStrikeout").toBool())));
////                }
////                else
////                {
////                    lJsonBlock.insert("source", QJsonValue(QString(lBlock->property("source").toString())));
////                }
////                lJsonBlock.insert("widthCoeff", QJsonValue(QString(lBlock->property("widthCoeff").toString())));
////                lJsonBlock.insert("heightCoeff", QJsonValue(QString(lBlock->property("heightCoeff").toString())));
////                lJsonBlock.insert("xCoeff", QJsonValue(QString(lBlock->property("xCoeff").toString())));
////                lJsonBlock.insert("yCoeff", QJsonValue(QString(lBlock->property("yCoeff").toString())));
////                lJsonBlocksArray.append(lJsonBlock);
            }
////            qDebug() << "\n~~~~~~\n" << lJsonBlocksArray;
////            lJsonSlide.insert("blocks",lJsonBlocksArray);
        }
        QVariantList effects = lSlideMap.value("effects").toList();
        foreach (QVariant effect, effects)
        {

            QQmlComponent *c1 = new QQmlComponent(lEngine,QUrl::fromLocalFile(QString::fromLatin1("%1/../qml/DemoView/background/%2.qml").arg(mContentDir).arg(effect.toString())));
            QObject *o1 = c1->create(lContext);
            qobject_cast<QQuickItem*>(o1)->setParentItem(lSlideItem);
            qobject_cast<QQuickItem*>(o1)->setProperty("z",-1);
        }
        i++;
    }
    qDebug() << "\nSlides: " << pres->property("slides");






}



bool MainView::nativeEvent(const QByteArray& eventType, void* pMessage, long* result)
{
#if defined(Q_OS_WIN)
    MSG* message = (MSG*)pMessage;
    switch(message->message)
    {
    case (WM_SIZING):
    {
        RECT* rect = (RECT*) message->lParam;
        int fWidth = frameGeometry().width() - width();
        int fHeight = frameGeometry().height() - height();
        int nWidth = rect->right-rect->left - fWidth;
        int nHeight = rect->bottom-rect->top - fHeight;

        switch(message->wParam) {
        case WMSZ_BOTTOM:
        case WMSZ_TOP:
            rect->right = rect->left+(qreal)nHeight*mAspectRatio + fWidth;
            break;

        case WMSZ_BOTTOMLEFT:
        case WMSZ_BOTTOMRIGHT:
            if( (qreal)nWidth / nHeight > mAspectRatio )
                rect->bottom = rect->top+(qreal)nWidth/mAspectRatio +fHeight;
            else
                rect->right = rect->left+(qreal)nHeight*mAspectRatio + fWidth;
            break;

        case WMSZ_LEFT:
        case WMSZ_RIGHT:
            rect->bottom = rect->top+(qreal)nWidth/mAspectRatio +fHeight;
            break;

        case WMSZ_TOPLEFT:
        case WMSZ_TOPRIGHT:
            if( (qreal)nWidth / nHeight > mAspectRatio )
                rect->bottom = rect->top+(qreal)nWidth/mAspectRatio +fHeight;
            else
                rect->right = rect->left+(qreal)nHeight*mAspectRatio + fWidth;
            break;
        }
    }
        return true;
    default:
        return false;
    };
    return true;
#endif
}

bool MainView::event(QEvent *event)
{
    if (event->type() == QEvent::Close)
    {
        //        savePresentation("");
    }
    return QQuickView::event(event);
}



//void MainView::resizeEvent(QResizeEvent *event)
//{
//    qDebug() << "event size" << event->size() << event->oldSize() << mOldSize;
//    qDebug() <<"+++++"<< frameGeometry();
//    QSize lNewSize = event->size();

//    if (lNewSize != event->oldSize())
//    {
//        if (event->size().width() != event->oldSize().width())
//        {
//            lNewSize = QSize(event->size().width(), event->size().width()/mAspectRatio);
//        }
//        else if (event->size().height() != event->oldSize().height())
//        {
//            lNewSize = QSize(event->size().height()*mAspectRatio, event->size().height());
//        }
//        foreach (Page *page, mPagesList)
//        {
//            page->setProperty("height", this->height());
//            page->setProperty("width", this->width());
//        }

//        mOldSize = lNewSize;
//        resize(lNewSize);
//        qDebug() <<"after"<< width();
//        qDebug() << height();
//    }
//    else
//    {
//        mOldSize = lNewSize;
//    }

//    QQuickView::resizeEvent(event);
//}


void MainView::test(QQuickItem* item)
{
    qDebug() << "full browser";
    Slide *page = new Slide(item);
    if (!page)
    {
        qDebug() << "ZZZZZZZZZZz";
    }
    page->setParentItem(this->rootObject());
    mSlidesList.append(page);

}

void MainView::test1(int w)
{
}
