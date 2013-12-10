#include "helper.h"
#include <QDebug>
#include <QFile>
#include <QColor>
#include <QFontDatabase>


Helper::Helper( QObject *parent) :
    QObject(parent)
{
}

void Helper::test1(const QString &pString)
{
    qDebug() << "##########"<< pString;
}

QString Helper::readShader(const QString &pFileName)
{
    QFile file(QString(":/shaders/%1").arg(pFileName));
    if (file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        return file.readAll();
    }
    return "";
}

qreal Helper::hue(const QString &pColor)
{
    QColor color(pColor);
    return color.hueF();
}

qreal Helper::brightness(const QString &pColor)
{
    QColor color(pColor);
    return 1 - color.lightnessF();
}

qreal Helper::alpha(const QString &pColor)
{
    QColor color(pColor);
    return color.alphaF();
}

QStringList Helper::fonts()
{
    QFontDatabase lDatabase;
    return lDatabase.families();
}

int Helper::fontIndex(const QString &pFont)
{
    foreach (QString font, fonts())
    {
        if ( pFont == font)
        {
            return fonts().indexOf(font);
        }
    }
    return 0;
}

void Helper::openPresentation(const QUrl &pPath)
{
    emit open(pPath.path().remove(0,1));
}

void Helper::setCreatePresentationMode()
{
    emit createPresentationMode();
}

void Helper::setScreenPixelSize(QSize pSize)
{
    mScreenSize = pSize;
}

QSize Helper::screenSize()
{
    return mScreenSize;
}


qreal Helper::saturation(const QString& pColor)
{
    QColor color(pColor);
    return color.saturationF();
}
