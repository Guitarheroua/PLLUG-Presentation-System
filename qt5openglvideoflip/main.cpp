#include <QtGui/QGuiApplication>
#include <QtWidgets/QApplication>
#include <QDir>
#include <QString>
#include <QDebug>
#include <QQmlContext>
#include <QDesktopWidget>
#include <QQuickView>
#include "mainview.h"
#include "page.h"
#include "megaparse.h"

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
                contentDir = QString::fromLatin1("%1/../Resources/data").arg(QCoreApplication::applicationDirPath())

            #endif
        }
    }
    qDebug() << contentDir;
    MainView *view = new MainView(contentDir);
    view->show();


    return app.exec();
}
