#include "helper.h"
#include <QDebug>
#include <QFile>

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
