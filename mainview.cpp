#include "mainview.h"
#include <QDebug>
#include <QQmlContext>
#include <QQuickWindow>
#include <QApplication>
#include <QQmlComponent>
#include <QDesktopWidget>
#include "contentblock.h"
#include <QQmlApplicationEngine>

#include "helper.h"
#include "presentationmanager.h"
#include "slidemodel.h"

MainView::MainView(const QString &pContentDir, QObject *parent) :
    QObject(parent)
   ,mQmlEngine(new QQmlApplicationEngine(this))
   ,mContentDir(pContentDir)
   ,mHelper(new Helper(this))
   ,mSlideModel(new SlideModel(this))
{
    registerTypesInQml();

    mHelper->setScreenPixelSize(qApp->desktop()->screenGeometry().size());

    mQmlEngine->rootContext()->setContextProperty("helper", mHelper);
    mQmlEngine->rootContext()->setContextProperty("screenPixelWidth", mHelper->screenSize().width());
    mQmlEngine->rootContext()->setContextProperty("screenPixelHeight", mHelper->screenSize().height());
    ContentBlock *cb = new ContentBlock(50, 50, 200, 200, 20, ContentBlock::ContentBlockType::Text, this);
    cb->setSpecificContent("color","blue");
    ContentBlock *cb2 = new ContentBlock(500, 300, 200, 200, 20, ContentBlock::ContentBlockType::Text, this);
    cb2->setSpecificContent("color","red");
    //mSlideModel->addBlock(cb);
    //mSlideModel->addBlock(cb2);
   // SlideModel *sm = new SlideModel;

    mQmlEngine->rootContext()->setContextProperty("slideModel", mSlideModel);

    QQmlComponent component(mQmlEngine, QUrl(QStringLiteral("qrc:/main.qml")));
    if (!component.isReady())
    {
        qDebug() << "Error while creating New Project window :" << component.errorString();
    }
    mMainWindow = qobject_cast<QQuickWindow*>(component.create(mQmlEngine->rootContext()));
    mManager = new PresentationManager(mContentDir, mMainWindow, mHelper, this);

    connect(mHelper, SIGNAL(createPresentationMode()),
            mManager, SLOT(setCreateEditPresentationMode()), Qt::UniqueConnection);
    connect(mHelper, SIGNAL(open(QString)),
            mManager, SLOT(openPresentation(QString)), Qt::UniqueConnection);
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
        mMainWindow->show();
    else
        mMainWindow->showFullScreen();
}

void MainView::registerTypesInQml()
{
    qmlRegisterType<ContentBlock>("PPS.ContentBlock", 1, 0, "ContentBlock");
}

#if defined(Q_OS_WIN)
bool MainView::nativeEvent(const QByteArray& eventType, void* pMessage, long* result)
{
    Q_UNUSED(eventType);
    Q_UNUSED(pMessage);
    Q_UNUSED(result);
    return false;
}
#endif
