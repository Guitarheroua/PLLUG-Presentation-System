#include "megaparse.h"
#include <QJsonDocument>
#include <QTextStream>
#include <QDebug>
#include <QFile>
#include <QDir>
#include "slide.h"


MegaParse::MegaParse(QObject *parent) :
    QObject(parent)
{
}

MegaParse::~MegaParse()
{
    qDeleteAll(mPagesList);
    qDeleteAll(mTemplatesList);
}

void MegaParse::parsePresenationData()
{
    QString jsonData;
    QFile data(mContentDir + "/data.json");
    if (data.open(QFile::ReadOnly))
    {
        QTextStream in(&data);
        jsonData = in.readAll();
    }
//    QJsonDocument jsonDoc = QJsonDocument::fromJson(jsonData.toUtf8());
//    QString lPresentationName = jsonDoc.toVariant().toMap().value("name").toString();
//    QString lSchemeVersion = jsonDoc.toVariant().toMap().value("schemeVersion").toString();
//    QVariantList lSlidesList = jsonDoc.toVariant().toMap().value("slides").toList();
//    QVariantList list;
//    foreach(QVariant slide, lSlidesList)
//    {
//       mPagesList.append(new Slide(slide.toMap(), mContentDir, QSize(qApp->desktop()->screenGeometry().width()/1.5, qApp->desktop()->screenGeometry().height()/1.5)));
//       list.append(QVariant(new Slide(slide.toMap(), mContentDir, QSize(qApp->desktop()->screenGeometry().width()/1.5, qApp->desktop()->screenGeometry().height()/1.5))));
//    }


}

void MegaParse::parseTemplatesData()
{
    QString jsonData;
    QDir lDataDir = QDir(mContentDir + "/templates/");
    for(const QFileInfo &lFileInfo : lDataDir.entryInfoList(QDir::Files))
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
        mTemplatesList.append(new Slide(jsonDoc.toVariant().toMap(), mContentDir, QSize(800,800)));
    }


}

void MegaParse::setContentDir(const QString pDir)
{
    mContentDir = pDir;
}

QList<Slide *> MegaParse::pagesList()
{
    return mPagesList;
}
