#ifndef MAINVIEW_H
#define MAINVIEW_H

#include <QObject>
#include <QSize>

class Slide;
class Helper;
class MegaParse;
class SlideModel;
class QQuickWindow;
class PresentationManager;
class QQmlApplicationEngine;

class MainView : public QObject
{
    Q_OBJECT
public:
    explicit MainView(const QString& pContentDir, QObject* parent = 0);

protected:
#if defined(Q_OS_WIN)
    bool nativeEvent(const QByteArray&, void*, long*);
#endif

public slots:
    void showWindow(bool state);
    
private:
    Helper* mHelper;
    QSize mActualSize;
    MegaParse *mParser;
    qreal mAspectRatio;
    QString mContentDir;
    SlideModel* mSlideModel;
    QQuickWindow* mMainWindow;
    PresentationManager* mManager;
    QQmlApplicationEngine* mQmlEngine;
};

#endif // MAINVIEW_H
