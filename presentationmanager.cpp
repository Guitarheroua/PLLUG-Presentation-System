#include "presentationmanager.h"
#include <QQuickItem>
#include <QMessageBox>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QQmlEngine>
#include <QQmlContext>
#include <QQuickWindow>

#include "helper.h"

PresentationManager::PresentationManager(const QString &pDir, QQuickWindow *pRootObject, Helper* pHelper, QObject *parent):
    QObject{parent}
   ,mMode {PresentationManager::SlideShow}
   ,mContentDir{pDir}
   ,mHelper {pHelper}
   ,mRootObject {pRootObject}
{
}

void PresentationManager::openPresentation(const QString &pPath)
{
    loadPresentation();
    setShowPresentationMode();

    QString jsonData;

    QFile lFile(pPath);
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
    QQmlEngine* lEngine = new QQmlEngine();
    QQmlContext* lContext = lEngine->rootContext();
    lContext->setContextProperty("helper",mHelper);
    lContext->setContextProperty("screenPixelWidth",mHelper->screenSize().width());
    lContext->setContextProperty("screenPixelHeight",mHelper->screenSize().height());

    QJsonDocument jsonDoc = QJsonDocument::fromJson(jsonData.toUtf8());
    QString lTransition = jsonDoc.toVariant().toMap().value("transition").toString();
    QQmlComponent *lComp = new QQmlComponent(lEngine,QUrl::fromLocalFile(QString::fromLatin1("%1/../qml/DemoView/transition/%2.qml").arg(mContentDir).arg(lTransition)));
    QObject *lTransitionObject = lComp->create(lContext);
    if (lTransitionObject)
    {
        qobject_cast<QQuickItem*>(lTransitionObject)->setParentItem(mPresentation);
        qobject_cast<QQuickItem*>(lTransitionObject)->setProperty("objectName",lTransition);
        qobject_cast<QQuickItem*>(lTransitionObject)->setProperty("currentSlide",0);
        qobject_cast<QQuickItem*>(lTransitionObject)->setProperty("screenWidth",mHelper->screenSize().width());
        qobject_cast<QQuickItem*>(lTransitionObject)->setProperty("screenHeight",mHelper->screenSize().height());
        QVariant var1;
        mPresentation->setProperty("transition", var1.fromValue<QObject*>(lTransitionObject));
    }

    QVariantList lSlidesList = jsonDoc.toVariant().toMap().value("slides").toList();

    QVariant var;

    QVariantList lSlidesItemList;

    int i=0;

    QList<QQuickItem*> lBlocksItemList;
    for(QVariantList::const_iterator slideIterator = lSlidesList.constBegin();
        slideIterator != lSlidesList.constEnd(); ++slideIterator, ++i)
    {
        QVariantMap lSlideMap = (*slideIterator).toMap();
        lBlocksItemList.clear();
        QQmlComponent *component = new QQmlComponent(lEngine,QUrl::fromLocalFile(QString::fromLatin1("%1/../qml/DemoView/presentation/Slide.qml").arg(mContentDir)));
        QObject *object = component->create();
        qobject_cast<QQuickItem*>(object)->setParentItem(mPresentation);
        var.setValue<QObject*>(object);
        bool b = true;
        QMetaObject::invokeMethod(mPresentation, "newSlide", Q_ARG(QVariant, var), Q_ARG(QVariant, i), Q_ARG(QVariant, b));
        lSlidesItemList = mPresentation->property("slides").value<QVariantList>();
        QQuickItem* lSlideItem = lSlidesItemList.at(i).value<QQuickItem*>();
        lSlideItem->setProperty("title", lSlideMap.value("title").toString() );
        lSlideItem->setProperty("layout", lSlideMap.value("layout").toString() );
        if ((*slideIterator).toMap().value("layout").toString() != "")
        {
            QQmlComponent *c = new QQmlComponent(lEngine,QUrl::fromLocalFile(QString::fromLatin1("%1/../qml/DemoView/layouts/%2.qml").arg(mContentDir).arg((*slideIterator).toMap().value("layout").toString())));
            QObject *o = c->create();
            QQuickItem* layout = qobject_cast<QQuickItem*>(o);
            layout->setParentItem(lSlideItem);
            layout->setObjectName("layout");
            QQuickItem* lBlocksView = layout->findChild<QQuickItem*>("blocksView", Qt::FindChildrenRecursively);
            QVariantList lBlocksJsonList = (*slideIterator).toMap().value("blocks").toList();
            if (lBlocksView)
            {
                int lBlocksCount = lBlocksView->property("count").toInt();
                for(int j=0; j<lBlocksCount; ++j)
                {
                    QVariant lVar;
                    QMetaObject::invokeMethod(lBlocksView, "getItem", Q_RETURN_ARG(QVariant, lVar), Q_ARG(QVariant, j));
                    QQuickItem* lItem = lVar.value<QQuickItem*>();
                    QQuickItem* lBlock = lItem->findChild<QQuickItem*>("block", Qt::FindChildrenRecursively);
                    setBlockProperties(lBlock, lBlocksJsonList.at(j).toMap());
                }
            }
            else
            {
                lBlocksItemList = layout->findChildren<QQuickItem*>("block", Qt::FindChildrenRecursively);
            }
        }
        QVariantList lBackgrounds = lSlideMap.value("backgrounds").toList();
        for (const QVariant &lBackground : lBackgrounds)
        {
            QQmlComponent *c1 = new QQmlComponent(lEngine,QUrl::fromLocalFile(QString::fromLatin1("%1/../qml/DemoView/background/%2.qml").arg(mContentDir).arg(lBackground.toString())));
            QObject *o1 = c1->create(lContext);
            qobject_cast<QQuickItem*>(o1)->setParentItem(lSlideItem);
            qobject_cast<QQuickItem*>(o1)->setProperty("z",-1);
        }
    }
}

void PresentationManager::savePresentation(const QString& pPath)
{
    QFile lFile(pPath);
    if (lFile.open(QIODevice::WriteOnly))
    {
        QJsonObject lObject;
        lObject.insert("name", QJsonValue(QString("Test Presentation")));
        lObject.insert("schemeVersion", QJsonValue(QString("1.0")));

        QQuickItem* lPresentation = mRootObject->findChild<QQuickItem*>("PresentationLoader")->property("item").value<QQuickItem*>();
        QVariantList lSlides =  lPresentation->property("slides").value<QVariantList>();
        QQuickItem* lTransition =  lPresentation->property("transition").value<QQuickItem*>();
        if (lTransition)
        {
            QString lTransitionName = lTransition->objectName().remove(0,11);
            lObject.insert("transition",QString(lTransitionName.remove(lTransitionName.length()-4,4)) );
        }
        QJsonObject lJsonSlide;
        QJsonArray lSlidesArray;
        for(const QVariant &lSlide : lSlides)
        {
            QQuickItem* slide = lSlide.value<QQuickItem*>();
            lJsonSlide = QJsonObject();
            lJsonSlide.insert("title",QJsonValue(QString(slide->property("title").toString())));
            QJsonArray lBackgrounds;
            QList<QQuickItem*> lBlockList;
            for (const QQuickItem* item: slide->childItems())
            {
                lBlockList.clear();
                QString lObjectName = item->objectName();
                QString lLayoutName = slide->property("layout").toString().remove("layouts/");
                lJsonSlide.insert("layout", QJsonValue(QString(lLayoutName.remove(lLayoutName.length()-4,4))));
                if (lObjectName.contains("background/"))
                {
                    QString lEffectName = lObjectName.remove(0,11);
                    lBackgrounds.append(QJsonValue(QString(lEffectName.remove(lEffectName.length()-4,4))));
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
                    }
                    else
                    {
                        lBlockList = item->findChildren<QQuickItem*>("block", Qt::FindChildrenRecursively);
                    }
                    for(const QQuickItem* blockLoader: lBlockList)
                    {
                        QJsonObject lJsonBlock;
                        QQuickItem* lBlock = blockLoader->property("contentItem").value<QQuickItem*>();
                        if (!lBlock)
                        {
                            return;
                        }
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
                            lJsonBlock.insert("text", QJsonValue(QString(lBlock->property("text").toString())));
                        }
                        else
                        {
                            lJsonBlock.insert("source", QJsonValue(QString(lBlock->property("source").toString())));
                        }
                        lJsonBlock.insert("widthCoeff", QJsonValue(QString(lBlock->property("widthCoeff").toString())));
                        lJsonBlock.insert("heightCoeff", QJsonValue(QString(lBlock->property("heightCoeff").toString())));
                        lJsonBlock.insert("xCoeff", QJsonValue(QString(lBlock->property("xCoeff").toString())));
                        lJsonBlock.insert("yCoeff", QJsonValue(QString(lBlock->property("yCoeff").toString())));
                        lJsonBlock.insert("rotation", QJsonValue(QString(lBlock->property("rotation").toString())));
                        lJsonBlocksArray.append(lJsonBlock);
                    }
                    lJsonSlide.insert("blocks",lJsonBlocksArray);
                }
            }
            lJsonSlide.insert("backgrounds",lBackgrounds);
            lSlidesArray.append(lJsonSlide);
        }
        lObject.insert("slides", lSlidesArray);

        QJsonDocument lDoc;
        lDoc.setObject(lObject);
        lFile.write(lDoc.toJson());
    }
}

void PresentationManager::loadPresentation()
{
    QQuickItem* lLoader = mRootObject->findChild<QQuickItem*>("PresentationLoader", Qt::FindChildrenRecursively);
    lLoader->setProperty("source", QUrl::fromLocalFile(QString::fromLatin1("%1/../qml/DemoView/presentation/Presentation.qml").arg(mContentDir)));

    mPresentation = lLoader->property("item").value<QQuickItem*>();
}

PresentationManager::PresentationMode PresentationManager::mode() const
{
    return mMode;
}

void PresentationManager::setBlockProperties(QQuickItem *pBlock, QVariantMap pPropertiesMap)
{
    QString lBlockType = pPropertiesMap.value("type").toString();
    QString lItemName = lBlockType;
    if ("text" == lBlockType)
    {
        lItemName = "TextItem";
    }
    QUrl url = QUrl::fromLocalFile(QString::fromLatin1("%1/../qml/DemoView/items/%2.qml").arg(mContentDir).arg(lItemName));

    QMetaObject::invokeMethod(pBlock, "load", Q_ARG(QVariant, url));
    pBlock->findChild<QQuickItem*>("menu")->setProperty("visible", false);

    QQuickItem* loader = pBlock->findChild<QQuickItem*>("blockLoader");
    QQuickItem* item = loader->property("item").value<QQuickItem*>();
    if (item)
    {
        for (const QString &key : pPropertiesMap.keys())
        {
            const char* lKey = key.toLatin1().constData();
            item->setProperty(lKey, pPropertiesMap.value(key) );
            if ("widthCoeff" == key)
            {
                item->setProperty("width",  pPropertiesMap.value(key).toReal()*pBlock->property("width").toReal());
            }
            if ("heightCoeff" == key)
            {
                item->setProperty("height",  pPropertiesMap.value(key).toReal()*pBlock->property("height").toReal());
            }
            if ("xCoeff" == key)
            {
                item->setProperty("x",  pPropertiesMap.value(key).toReal()*pBlock->property("width").toReal());
            }
            if ("yCoeff" == key)
            {
                item->setProperty("y",  pPropertiesMap.value(key).toReal()*pBlock->property("height").toReal());
            }
        }
    }
}

void PresentationManager::setCreateEditPresentationMode()
{
    mMode = PresentationManager::Create;
    mHelper->setEnableEdit(true);
}

void PresentationManager::setShowPresentationMode()
{
    mMode = PresentationManager::SlideShow;
    mPresentation->setProperty("enableEdit", false);
}
