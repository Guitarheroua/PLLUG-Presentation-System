#include "presentationmanager.h"
#include <QQuickItem>

#include "helper.h"

PresentationManager::PresentationManager(const QString &contentDir, QQuickWindow *rootObject, Helper* helper, QObject *parent):
    QObject{parent}
   ,mMode {PresentationManager::SlideShow}
   ,mContentDir{contentDir}
   ,mHelper {helper}
   ,mPresentation{nullptr}
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
    Q_UNUSED(pBlock);
    Q_UNUSED(pPropertiesMap);
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
