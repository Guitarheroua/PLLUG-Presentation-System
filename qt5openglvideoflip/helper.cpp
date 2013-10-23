#include "helper.h"
#include <QDebug>
#include <QFile>
#include <QColor>

Helper::Helper(QObject *parent) :
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
    qDebug() << "++++++" << color.hueF() ;
    return color.hueF();
}

qreal Helper::brightness(const QString &pColor)
{
    QColor color(pColor);
    qDebug() << "==========" << color.lightnessF() << 1 - color.lightnessF();
    return color.lightnessF();
}

qreal Helper::saturation(const QString& pColor)
{
    QColor color(pColor);
    qDebug() << "__________" << color.saturationF();
    return color.saturationF();
}
