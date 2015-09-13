#include "mainview.h"

#include <QQmlContext>
#include <QQuickWindow>
#include <QApplication>
#include <QQmlComponent>
#include <QDesktopWidget>
#include <QQmlApplicationEngine>

#include "helper.h"
#include "slidemodel.h"
#include "contentblock.h"
#include "presentationmanager.h"


MainView::MainView(const QString &contentDir, QObject *parent) :
    QObject{parent}
  ,mHelper{new Helper{this}}
  ,mContentDir{contentDir}
  ,mSlideModel{new SlideModel{this}}
  ,mQmlEngine{new QQmlApplicationEngine{this}}
{
    registerTypesInQml();
    mHelper->setScreenPixelSize(qApp->desktop()->screenGeometry().size());
    mQmlEngine->rootContext()->setContextProperty("slideModel", mSlideModel);
    mQmlEngine->rootContext()->setContextProperty("helper", mHelper);
    mQmlEngine->rootContext()->setContextProperty("screenPixelWidth", mHelper->screenSize().width());
    mQmlEngine->rootContext()->setContextProperty("screenPixelHeight", mHelper->screenSize().height());
    QQmlComponent component(mQmlEngine, QUrl(QStringLiteral("qrc:/main.qml")));
    mMainWindow = qobject_cast<QQuickWindow*>(component.create(mQmlEngine->rootContext()));
    connect(mMainWindow, SIGNAL(changeWindowMode(bool)), this, SLOT(showWindow(bool)), Qt::UniqueConnection);

    mActualSize = QSize(qApp->desktop()->screenGeometry().width() / 1.5,
                        qApp->desktop()->screenGeometry().height() / 1.5);

    mHelper->setMainViewSize(mActualSize);
    mMainWindow->resize(mActualSize);
    mMainWindow->installEventFilter(this);
}

void MainView::showWindow(bool state)
{
    if(state)
    {
        mMainWindow->show();
    }
    else
    {
        mMainWindow->showFullScreen();
    }
}

void MainView::registerTypesInQml()
{
    qmlRegisterType<ContentBlock>("PPS.ContentBlock", 1, 0, "ContentBlock");
    qmlRegisterType<SlideModel>("PPS.SlideModel", 1, 0, "SlideModel");
}
