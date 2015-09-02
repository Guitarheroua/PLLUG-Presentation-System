#include <QApplication>
#include "mainview.h"

QString extractContentDir()
{
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
    return contentDir;
}

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    MainView view(extractContentDir());
    view.showWindow(true);

    return app.exec();
}
