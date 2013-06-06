#include "mainview.h"
#include <QQuickView>
#include <QtWidgets/QApplication>
#include <QtWidgets/QDesktopWidget>
#include <QQmlContext>
#include <QUrl>
#include <QFile>
#include <QDir>
#include "megaparse.h"
#include "blocksview.h"
#include "page.h"
#include <QQmlEngine>
#include <QDebug>

MainView::MainView(const QString &pContentDir, QWindow *parent) :
    QQuickView(parent)
{
    mParser = new MegaParse(this);
    mParser->setContentDir(pContentDir);
    qDebug() << "content dir = " << pContentDir;
    mParser->parseData();

    this->setSurfaceType(QQuickView::OpenGLSurface);

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
    this->rootContext()->setContextProperty("vshader", vshader);
    this->rootContext()->setContextProperty("fshader",fshader);
    this->rootContext()->setContextProperty("screenPixelWidth", qApp->desktop()->screenGeometry().width());
    this->rootContext()->setContextProperty("screenPixelHeight",qApp->desktop()->screenGeometry().height());

    this->setSource(QString("qml/main.qml"));

    QQuickItem *rootItem = this->rootObject();

    for (int i=0; i<mParser->pagesList().count(); i++)
    {
        Page* item = mParser->pagesList().at(i);
        item->setVisible(false);
        item->setVisible((i == 0));
        item->setParentItem(rootItem);
        mPagesList.append(item);
    }
    this->resize(800,800);

    this->setResizeMode(QQuickView::SizeRootObjectToView);
}

void MainView::resizeEvent(QResizeEvent *)
{
    foreach (Page *page, mPagesList)
    {
        page->setProperty("height", this->height());
        page->setProperty("width", this->width());
    }
}
