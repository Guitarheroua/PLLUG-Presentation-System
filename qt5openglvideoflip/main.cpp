#include <QtGui/QGuiApplication>
#include <QtWidgets/QApplication>
#include <QtWidgets/QDesktopWidget>
#include <QQuickView>
#include <QQmlContext>
#include <QUrl>
#include <QFile>
#include <QDir>
#include "megaparse.h"
#include "blocksview.h"
#include "page.h"
#include <QQmlEngine>
#include <QDebug>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    MegaParse parser;

    QString contentDir;
    foreach (QString arg, QCoreApplication::arguments())
    {
        if ( arg.contains("-contentdir="))
        {
            contentDir = arg.remove("-contentdir=");
            parser.setContentDir(contentDir);
        }
        else
        {
            QDir appDir = QCoreApplication::applicationDirPath();
            appDir.cdUp();
            appDir.cdUp();
            #ifdef Q_OS_WIN
            contentDir = appDir.absolutePath() + "/data";
            #endif
            #ifdef Q_OS_MAC
            appDir.cdUp();
            appDir.cdUp();
            contentDir = appDir.absolutePath() + "/data";
            #endif
        }
    }
    parser.setContentDir(contentDir);
    qDebug() << "content dir = " << contentDir;
    parser.parseData();

    QQuickView view;
    view.setResizeMode(QQuickView::SizeRootObjectToView);

    QString fshader;
    QFile file1(":/shaders/flipPage.fsh");
    if (file1.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        fshader = file1.readAll();
    }
    QString vshader;
    QFile file2(":/shaders/flipPage.vsh");
    if (file2.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        vshader = file2.readAll();
    }

    view.rootContext()->setContextProperty("vshader", vshader);
    view.rootContext()->setContextProperty("fshader",fshader);
    view.rootContext()->setContextProperty("screenPixelWidth", app.desktop()->screenGeometry().width());
    view.rootContext()->setContextProperty("screenPixelHeight",app.desktop()->screenGeometry().height());

    view.setSource(QString("qml/main.qml"));
//    view.setSource(QString("resources/qml/test.qml"));
//        view.setSource(QString("qrc:/qml/test.qml"));
    QQuickItem *rootItem = view.rootObject();

    QList<Page*> pagesModel;
    for (int i=0; i<parser.pagesList().count(); i++)
    {
        Page* item = parser.pagesList().at(i);
        pagesModel.append(item);
        item->setVisible(false);
        item->setVisible((i == 0));
        item->setParentItem(rootItem);
    }
    view.show();

    return app.exec();
}
