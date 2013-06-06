#include <QtGui/QGuiApplication>
#include <QtWidgets/QApplication>
#include <QDir>
#include "mainview.h"

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

    MainView *view = new MainView(contentDir);
    view->show();

    return app.exec();
}
