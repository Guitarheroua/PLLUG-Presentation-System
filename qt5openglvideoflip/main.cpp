#include <QtGui/QGuiApplication>
#include <QtWidgets/QApplication>
#include <QtWebKitWidgets/QWebView>
#include <QNetworkProxyFactory>
#include <QDesktopWidget>
#include <QLibraryInfo>
#include <QQmlContext>
#include <QQuickView>
#include <QString>
#include <QDebug>
#include <QDir>

#include "webviewitem.h"
#include "megaparse.h"
#include "mainview.h"
#include "machelper.h"
#include "page.h"

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
//    MainView *view = new MainView(contentDir);
//#if defined(Q_OS_MAC)
//    MacHelper *helper = new MacHelper();
//    helper->setAspectRatio(view->winId());
//#endif
//    view->show();

    //    QString expectedPath = QCoreApplication::applicationDirPath() + QDir::separator() + "QtWebProcess";
    //    qDebug() << "\n!!!!!\n" << expectedPath << QFile(expectedPath).exists();
    //    expectedPath =  QLibraryInfo::location(QLibraryInfo::LibraryExecutablesPath) + QDir::separator() + + "QtWebProcess";
    //    qDebug() << "\n>>>>>>>>\n" << expectedPath << QFile(expectedPath).exists();


//         QNetworkProxyFactory::setUseSystemConfiguration(true);
//        QWebSettings::globalSettings()->setAttribute(QWebSettings::LocalStorageEnabled,
//        true);

//        QWebSettings::globalSettings()->setAttribute(QWebSettings::LocalContentCanAccessRemoteUrls,
//        true);

//        QWebSettings::globalSettings()->setAttribute(QWebSettings::OfflineWebApplicationCacheEnabled,
//        true);

//        QWebSettings::globalSettings()->setAttribute(QWebSettings::PluginsEnabled,
//        true);

//        QWebSettings::globalSettings()->setAttribute(QWebSettings::AutoLoadImages,
//        true);

//        QWebSettings::globalSettings()->setAttribute(QWebSettings::JavaEnabled,
//        true);
//        QWebSettings::globalSettings()->setAttribute(QWebSettings::WebGLEnabled,
//        true);

//        QWebSettings::globalSettings()->setAttribute(QWebSettings::JavascriptEnabled,
//        true);

    //    qmlRegisterType<WebViewItem>("CustomComponents", 1, 0, "WebViewItem");

    //    QString s1 ="http://www.youtube.com/embed/XGSy3_Czz8k";
//        QString s2 = "http://www.youtube.com/watch?v=XGSy3_Czz8k";
    //    QString s3 = "http://www.youtube.com/v/XGSy3_Czz8k?version=3";
    //    QString s4 = "http://www.youtube.com/apiplayer?video_id=XGSy3_Czz8k&version=3";
    //    QString s5 = "http://www.html5test.com";
    //    QString s6 = "http://shapeshed.com/examples/HTML5-video-element/";
    //    QString s7 = "http://www.youtube.com/html5?hl=ru";

    ////    WebViewItem* view = new WebViewItem();
    ////    view->load(QUrl(s7));
    ////    view->show();
//    #if defined(Q_OS_WIN)
//        qputenv("QTWEBKIT_PLUGIN_PATH", "C:\\Windows\\System32\\Macromed\\Flash");
//    #endif

    QString fshader;
    QFile file1(":/shaders/flipPage.fsh"/*pContentDir+"/../resources/shaders/flipPage.fsh"*/);
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


            QQuickView view1;
            view1.rootContext()->setContextProperty("vshader", vshader);
            view1.rootContext()->setContextProperty("fshader",fshader);
            view1.rootContext()->setContextProperty("screenPixelWidth", qApp->desktop()->screenGeometry().width());
            view1.rootContext()->setContextProperty("screenPixelHeight",qApp->desktop()->screenGeometry().height());
            view1.setSource(QUrl::fromLocalFile("qml/DemoView/TestPresentation.qml"));
    //        QQuickItem *item = view1.rootObject()->findChild<QQuickItem*>("webView",Qt::FindChildrenRecursively);
    //        if (item)
    //        {
    //            qDebug() << "ITEM"<< item->setProperty("settings.pluginsEnabled", true) << item->setProperty("url", s5);
    //        }
            view1.show();

    return app.exec();
}
