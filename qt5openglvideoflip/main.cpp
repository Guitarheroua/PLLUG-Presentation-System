#include <QtGui/QGuiApplication>
#include <QtWidgets/QApplication>
#include <QtWidgets/QDesktopWidget>
#include <QQuickView>
#include <QQmlContext>
#include <QUrl>
#include <QFile>
#include "megaparse.h"
#include "blocksview.h"
#include "page.h"
#include <QQmlEngine>
#include <QDebug>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    MegaParse p;
    p.parseData();

    QQuickView view;
    view.setResizeMode(QQuickView::SizeRootObjectToView);

    QString fshader;
    QFile file1("resources/shaders/flipPage.fsh");
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

    //    view.rootContext()->setContextProperty("pagesModel", QVariant::fromValue(pagesModel));

    view.setSource(QString("resources/qml/main.qml"));
//    view.setSource(QString("resources/qml/test.qml"));
//        view.setSource(QString("qrc:/qml/test.qml"));
    QQuickItem *itm = view.rootObject();

    QList<Page*> pagesModel;
    for (int i=0; i<p.pagesList().count(); i++)
    {
        Page* item = p.pagesList().at(i);
        pagesModel.append(item);
        item->setVisible(false);
        item->setVisible((i == 0));
        item->setParentItem(itm);
    }
    view.show();

    return app.exec();
}
