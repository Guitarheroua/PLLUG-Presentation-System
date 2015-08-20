#include <QApplication>
#include <QQmlApplicationEngine>

#include "mainview.h"
#include "machelper.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QString contentDir;
    for (QString arg: QCoreApplication::arguments())
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
    MainView view(contentDir);

#if defined(Q_OS_MAC)
    MacHelper *helper = new MacHelper();
    helper->setAspectRatio(view->winId());
#endif

    view.showWindow(true);
    return app.exec();
}
