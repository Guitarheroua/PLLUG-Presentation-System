#include <QtGui/QGuiApplication>
#include <QtWidgets/QApplication>
#include <QDir>
#include <QString>
#include <QDebug>
#include <QQmlContext>
#include <QDesktopWidget>
#include <QQuickView>
#include <QtWebKitWidgets/QWebView>
#include <QNetworkProxyFactory>
#include "mainview.h"
#include "page.h"
#include "megaparse.h"
//#include "testwebview.h"
#include <QLibraryInfo>
#include <QDebug>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QString contentDir;
    foreach (QString arg, QCoreApplication::arguments())
    {
        if ( arg.contains("-contentdir="))
        {
            contentDir = arg.remove("-contentdir=");
        }
        else
        {
            #if defined(Q_OS_WIN)
                contentDir = QString::fromLatin1("%1/../data").arg(QCoreApplication::applicationDirPath());
            #elif defined(Q_OS_MAC)
                contentDir = QString::fromLatin1("%1/../Resources/data").arg(QCoreApplication::applicationDirPath());

            #endif
        }
    }
    qDebug() << contentDir;
//    MainView *view = new MainView(contentDir);
//    view->show();

//    QString expectedPath = QCoreApplication::applicationDirPath() + QDir::separator() + "QtWebProcess";
//    qDebug() << "\n!!!!!\n" << expectedPath << QFile(expectedPath).exists();
//    expectedPath =  QLibraryInfo::location(QLibraryInfo::LibraryExecutablesPath) + QDir::separator() + + "QtWebProcess";
//    qDebug() << "\n>>>>>>>>\n" << expectedPath << QFile(expectedPath).exists();


     QNetworkProxyFactory::setUseSystemConfiguration(true);
    QWebSettings::globalSettings()->setAttribute(QWebSettings::LocalStorageEnabled,
    true);

    QWebSettings::globalSettings()->setAttribute(QWebSettings::LocalContentCanAccessRemoteUrls,
    true);

    QWebSettings::globalSettings()->setAttribute(QWebSettings::OfflineWebApplicationCacheEnabled,
    true);

    QWebSettings::globalSettings()->setAttribute(QWebSettings::PluginsEnabled,
    true);

    QWebSettings::globalSettings()->setAttribute(QWebSettings::AutoLoadImages,
    true);

    QWebSettings::globalSettings()->setAttribute(QWebSettings::JavaEnabled,
    true);

    QWebSettings::globalSettings()->setAttribute(QWebSettings::JavascriptEnabled,
    true);
    QString s1 ="http://www.youtube.com/embed/XGSy3_Czz8k";
    QString s2 = "http://www.youtube.com/watch?v=XGSy3_Czz8k";
    QString s3 = "http://www.youtube.com/v/XGSy3_Czz8k?version=3";
    QString s4 = "http://www.youtube.com/apiplayer?video_id=XGSy3_Czz8k&version=3";
    QString s5 = "http://www.html5test.com";
    QString s6 = "http://shapeshed.com/examples/HTML5-video-element/";

    QWebView view;
    view.load(QUrl(s5));
       view.show();

//        QQuickView view1;
//        view1.setSource(QUrl::fromLocalFile("qml/DemoView/testwebview.qml"));
//        QQuickItem *item = view1.rootObject()->findChild<QQuickItem*>("webView",Qt::FindChildrenRecursively);
//        if (item)
//        {
//            qDebug() << "ITEM"<< item->setProperty("settings.pluginsEnabled", true) << item->setProperty("url", s5);
//        }
//        view1.show();

    return app.exec();
}
