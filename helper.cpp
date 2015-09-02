#include "helper.h"
#include <QFile>
#include <QColor>
#include <QFontDatabase>


Helper::Helper( QObject *parent) :
    QObject(parent)
  ,mEnableEdit {false}
{
}

QString Helper::readShader(const QString &pFileName)
{
    QString shader {};
    QFile file(QString(":/shaders/%1").arg(pFileName));
    if (file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        shader = file.readAll();
    }
    return shader;
}

qreal Helper::hue(const QString &pColor)
{
    return QColor(pColor).hueF();
}

qreal Helper::brightness(const QString &pColor)
{
    return 1 - QColor(pColor).lightnessF();
}

qreal Helper::alpha(const QString &pColor)
{
    return QColor(pColor).alphaF();
}

QStringList Helper::fonts()
{
    return QFontDatabase().families();
}

int Helper::fontIndex(const QString &pFont)
{
    int index{};
    for (const QString &font : fonts())
    {
        if ( pFont == font)
        {
            index = fonts().indexOf(font);
            break;
        }
    }
    return index;
}

void Helper::openPresentation(const QUrl &pPath)
{
    QString lPath = pPath.path();
#if defined(Q_OS_WIN)
    lPath.remove(0,1);
#endif
    emit open(lPath);
}

void Helper::setCreatePresentationMode()
{
    mEnableEdit = true;
    emit createPresentationMode();
}

bool Helper::enableEdit()
{
    return mEnableEdit;
}

void Helper::setScreenPixelSize(QSize pSize)
{
    mScreenSize = pSize;
}

void Helper::setMainViewSize(QSize pSize)
{
    mMainViewSize = pSize;
}

QSize Helper::screenSize()
{
    return mScreenSize;
}

qreal Helper::mainViewWidth()
{
    return mMainViewSize.width();
}

qreal Helper::mainViewHeight()
{
    return mMainViewSize.height();
}

void Helper::setEnableEdit(bool pValue)
{
    mEnableEdit = pValue;
}


qreal Helper::saturation(const QString& pColor)
{
    return QColor(pColor).saturationF();
}
