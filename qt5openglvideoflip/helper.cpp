#include "helper.h"
#include <QDebug>

Helper::Helper(QObject *parent) :
    QObject(parent)
{
}

void Helper::test1(const QString &pString)
{
    qDebug() << "##########"<< pString;
}
