#include "megaparse.h"
#include <QFile>
#include <QStandardPaths>
#include <QDir>
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
//    QDir lCurrDir = QDir::currentPath();
//    lCurrDir.cdUp();
//    QDir lDataDir(lCurrDir.absolutePath() + "/data");

    QString jsonData;
    QFile data(mContentDir + "/data.json");
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
        mPagesList.append(new Page(page.toMap(), mContentDir));
    }
}

void MegaParse::setContentDir(const QString pDir)
{
    mContentDir = pDir;
}

QList<Page *> MegaParse::pagesList()
{
    return mPagesList;
}
