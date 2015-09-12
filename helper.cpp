#include "helper.h"
#include <QFile>
#include <QColor>
#include <QFontDatabase>


Helper::Helper( QObject *parent) :
    QObject{parent}
  ,mEnableEdit {false}
{
}

QString Helper::readShader(const QString &fileName)
{
    QString shader {};
    QFile file(QString(":/shaders/%1").arg(fileName));
    if (file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        shader = file.readAll();
    }
    return shader;
}

qreal Helper::hue(const QString &color)
{
    return QColor(color).hueF();
}

qreal Helper::brightness(const QString &color)
{
    return 1 - QColor(color).lightnessF();
}

qreal Helper::alpha(const QString &color)
{
    return QColor(color).alphaF();
}

qreal Helper::saturation(const QString& color)
{
    return QColor(color).saturationF();
}

QStringList Helper::fonts()
{
    return QFontDatabase().families();
}

int Helper::fontIndex(const QString &font)
{
    return fonts().indexOf(font);
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

void Helper::setScreenPixelSize(QSize size)
{
    mScreenSize = size;
}

void Helper::setMainViewSize(QSize size)
{
    mMainViewSize = size;
}

QSize Helper::screenSize() const
{
    return mScreenSize;
}

qreal Helper::mainViewWidth() const
{
    return mMainViewSize.width();
}

qreal Helper::mainViewHeight() const
{
    return mMainViewSize.height();
}

void Helper::setEnableEdit(bool enabled)
{
    mEnableEdit = enabled;
}
