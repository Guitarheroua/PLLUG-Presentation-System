#include "megaparse.h"
#include <QStandardPaths>
#include <QDesktopWidget>
#include <QJsonDocument>
#include <QApplication>
#include <QTextStream>
#include <QDebug>
#include <QFile>
#include <QDir>

#include "page.h"

MegaParse::MegaParse(QObject *parent) :
    QObject(parent)
{
}

MegaParse::~MegaParse()
{
    qDeleteAll(mPagesList);
    qDeleteAll(mTemplatesList);
}

void MegaParse::parsePagesData()
{
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
        mPagesList.append(new Page(page.toMap(), mContentDir, QSize(qApp->desktop()->screenGeometry().width()/1.5, qApp->desktop()->screenGeometry().height()/1.5)));
    }
}

void MegaParse::parseTemplatesData()
{
    QString jsonData;
    QDir lDataDir = QDir(mContentDir + "/templates/");
    foreach(QFileInfo lFileInfo, lDataDir.entryInfoList(QDir::Files))
    {
        QFile data(lFileInfo.absoluteFilePath());
        if (data.open(QFile::ReadOnly))
        {
            QTextStream in(&data);
            jsonData = in.readAll();
        }
        QJsonDocument jsonDoc = QJsonDocument::fromJson(jsonData.toUtf8());
    //    qDebug() << jsonDoc.isObject();
        qDebug() << jsonDoc.toVariant().toMap();
        mTemplatesList.append(new Page(jsonDoc.toVariant().toMap(), mContentDir, QSize(800,800)));
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
