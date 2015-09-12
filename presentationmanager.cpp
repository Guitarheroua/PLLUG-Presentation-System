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

PresentationManager::PresentationManager(const QString &contentDir, QQuickWindow *rootObject, Helper* helper, QObject *parent):
    QObject{parent}
   ,mMode {PresentationManager::SlideShow}
   ,mContentDir{contentDir}
   ,mHelper {helper}
   ,mRootObject {rootObject}
{
}

void PresentationManager::openPresentation(const QString &path)
{
    Q_UNUSED(path);
}

void PresentationManager::savePresentation(const QString& path)
{
    Q_UNUSED(path);
}

void PresentationManager::loadPresentation()
{
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
