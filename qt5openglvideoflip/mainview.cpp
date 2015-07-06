#include "mainview.h"
#include <QQuickView>
#include <QtWidgets/QApplication>
#include <QtWidgets/QDesktopWidget>
#include <QQmlContext>
#include <QQmlEngine>
#include <QUrl>
#include <QFile>
#include <QDir>
#include <QDebug>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>
#include <QMessageBox>
#include <QTimer>
#include <QFileDialog>

#include "presentationmanager.h"
#include "megaparse.h"
#include "blocksview.h"
#include "slide.h"
#include "helper.h"

#if defined(Q_OS_WIN)
#include "qt_windows.h"
#endif

MainView::MainView(const QString &pContentDir, QWindow *parent) :
    QQuickView(parent)
{
    //    mParser = new MegaParse(this);
    //    mParser->setContentDir(pContentDir);
    //    qDebug() << "content dir = " << pContentDir;
    //    mParser->parsePagesData();
    //    mParser->parseTemplatesData();
    mContentDir = pContentDir;
#if defined(Q_OS_MAC)
    //DON"T FORGET TO CHANGE PATH BEFORE DEPLOY!!!!
    mContentDir = "/Users/Admin/Projects/qt5openglvideoflip_1/qt5openglvideoflip/data";
#endif
    this->setSurfaceType(QQuickView::OpenGLSurface);

    mHelper = new Helper();
    mHelper->setScreenPixelSize(qApp->desktop()->screenGeometry().size());
    this->rootContext()->setContextProperty("helper",mHelper);
    this->rootContext()->setContextProperty("screenPixelWidth", mHelper->screenSize().width());
    this->rootContext()->setContextProperty("screenPixelHeight", mHelper->screenSize().height());

    //    QDir dir( pContentDir+"/image/");
    //    QStringList list;
    //    foreach (QFileInfo file, dir.entryInfoList(QDir::AllEntries | QDir::NoDotAndDotDot))
    //    {
    //        list.append("file:///" + file.absoluteFilePath());
    //    }
    //    this->rootContext()->setContextProperty("filesModel", list);


    QString lSourceFile = QString::fromLatin1("%1/../qml/DemoView/main.qml").arg(mContentDir);
    this->setSource(QUrl::fromLocalFile(lSourceFile));

    mManager = new PresentationManager(mContentDir, this->rootObject(), mHelper);
    connect(mHelper, SIGNAL(createPresentationMode()), mManager, SLOT(setCreateEditPresentationMode()));
    connect(mHelper, SIGNAL(open(QString)), mManager, SLOT(openPresentation(QString)));

    this->setResizeMode(QQuickView::SizeRootObjectToView);


    mActualSize = QSize(qApp->desktop()->screenGeometry().width()/2.0, qApp->desktop()->screenGeometry().height()/2.0);
    mHelper->setMainViewSize(mActualSize);
    mOldSize = mActualSize;
    mAspectRatio = (qreal)mActualSize.width() / mActualSize.height();
    qDebug() << mActualSize;
    resize(mActualSize);

    //    connect(this, SIGNAL(heightChanged(int)), this, SLOT(test1(int)));
}

#if defined(Q_OS_WIN)
bool MainView::nativeEvent(const QByteArray& eventType, void* pMessage, long* result)
{
    Q_UNUSED(eventType);
    Q_UNUSED(result);

//#if defined(Q_OS_WIN)
    MSG* message = (MSG*)pMessage;
    switch(message->message)
    {
    case (WM_SIZING):
    {
        RECT* rect = (RECT*) message->lParam;
        int fWidth = frameGeometry().width() - width();
        int fHeight = frameGeometry().height() - height();
        int nWidth = rect->right-rect->left - fWidth;
        int nHeight = rect->bottom-rect->top - fHeight;

        switch(message->wParam) {
        case WMSZ_BOTTOM:
        case WMSZ_TOP:
            rect->right = rect->left+(qreal)nHeight*mAspectRatio + fWidth;
            break;

        case WMSZ_BOTTOMLEFT:
        case WMSZ_BOTTOMRIGHT:
            if( (qreal)nWidth / nHeight > mAspectRatio )
                rect->bottom = rect->top+(qreal)nWidth/mAspectRatio +fHeight;
            else
                rect->right = rect->left+(qreal)nHeight*mAspectRatio + fWidth;
            break;

        case WMSZ_LEFT:
        case WMSZ_RIGHT:
            rect->bottom = rect->top+(qreal)nWidth/mAspectRatio +fHeight;
            break;

        case WMSZ_TOPLEFT:
        case WMSZ_TOPRIGHT:
            if( (qreal)nWidth / nHeight > mAspectRatio )
                rect->bottom = rect->top+(qreal)nWidth/mAspectRatio +fHeight;
            else
                rect->right = rect->left+(qreal)nHeight*mAspectRatio + fWidth;
            break;
        }
    }
        return true;
    default:
        return false;
    };
    return true;
//#endif

}
#endif

bool MainView::event(QEvent *event)
{
    if (event->type() == QEvent::Close)
    {
        if (mManager->mode() == PresentationManager::Create || mManager->mode() == PresentationManager::Edit )
        {
            QString lFilePath = QFileDialog::getSaveFileName(0, tr("Save Presentation"), QDir::currentPath(), tr("Presentation (*.json)"));
            mManager->savePresentation(lFilePath);
        }
    }
    return QQuickView::event(event);
}



//void MainView::resizeEvent(QResizeEvent *event)
//{
//    qDebug() << "event size" << event->size() << event->oldSize() << mOldSize;
//    qDebug() <<"+++++"<< frameGeometry();
//    QSize lNewSize = event->size();

//    if (lNewSize != event->oldSize())
//    {
//        if (event->size().width() != event->oldSize().width())
//        {
//            lNewSize = QSize(event->size().width(), event->size().width()/mAspectRatio);
//        }
//        else if (event->size().height() != event->oldSize().height())
//        {
//            lNewSize = QSize(event->size().height()*mAspectRatio, event->size().height());
//        }
//        foreach (Page *page, mPagesList)
//        {
//            page->setProperty("height", this->height());
//            page->setProperty("width", this->width());
//        }

//        mOldSize = lNewSize;
//        resize(lNewSize);
//        qDebug() <<"after"<< width();
//        qDebug() << height();
//    }
//    else
//    {
//        mOldSize = lNewSize;
//    }

//    QQuickView::resizeEvent(event);
//}


void MainView::test(QQuickItem* item)
{
    qDebug() << "full browser";
    Slide *page = new Slide(item);
    if (!page)
    {
        qDebug() << "ZZZZZZZZZZz";
    }
    page->setParentItem(this->rootObject());
    //    mSlidesList.append(page);

}

void MainView::test1(int w)
{
    w++;
}
