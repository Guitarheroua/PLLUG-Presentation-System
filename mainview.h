#ifndef MAINVIEW_H
#define MAINVIEW_H

#include <QObject>
#include <QSize>

class Slide;
class Helper;
class MegaParse;
class QQuickWindow;
class PresentationManager;
class QQmlApplicationEngine;
class MainView : public QObject
{
    Q_OBJECT
public:
    explicit MainView(const QString& pContentDir, QObject* parent = 0);
    void showWindow();

protected:
#if defined(Q_OS_WIN)
    bool nativeEvent(const QByteArray&, void*, long*);
#endif
//    bool event(QEvent * event);

signals:
    
private:
    QQuickWindow* mMainWindow;
    QQmlApplicationEngine* mQmlEngine;
    QString mContentDir;
    MegaParse *mParser;
    QSize mActualSize;
    qreal mAspectRatio;
    Helper* mHelper;
    PresentationManager* mManager;

};

#endif // MAINVIEW_H
