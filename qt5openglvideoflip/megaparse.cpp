#include "megaparse.h"
#include <QFile>
#include <QTextStream>
#include <QJsonDocument>
#include <QDebug>
#include "page.h"
MegaParse::MegaParse(QObject *parent) :
    QObject(parent)
{
}

MegaParse::~MegaParse()
{
    qDeleteAll(mPagesList);
}

void MegaParse::parseData()
{
    QString jsonData;
    QFile data("data1.json");
    if (data.open(QFile::ReadOnly))
    {
        QTextStream in(&data);
        jsonData = in.readAll();
    }
    QJsonDocument jsonDoc = QJsonDocument::fromJson(jsonData.toUtf8());
//    qDebug() << jsonDoc.isObject();
    QVariantList lPagesList = jsonDoc.toVariant().toMap().value("pages").toList();
    foreach(QVariant page, lPagesList)
    {
        mPagesList.append(new Page(page.toMap()));
    }
}

QList<Page *> MegaParse::pagesList()
{
    return mPagesList;
}
