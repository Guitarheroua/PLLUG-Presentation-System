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
//    QWebView view;
//       view.load(QUrl("http://www.youtube.com"));
//       view.show();

        QQuickView view;
        view.setSource(QUrl::fromLocalFile("qml/DemoView/testwebview.qml"));
        QQuickItem *item = view.rootObject()->findChild<QQuickItem*>("webView",Qt::FindChildrenRecursively);
        if (item)
        {
            qDebug() << "ITEM"<< item->setProperty("settings.pluginsEnabled", true) << item->setProperty("url", "http://www.qt-project.org");
        }
        view.show();

    return app.exec();
}
