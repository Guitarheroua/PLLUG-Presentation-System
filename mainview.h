#ifndef MAINVIEW_H
#define MAINVIEW_H

#include <QSize>
#include <QObject>

class Helper;
class MegaParse;
class SlideModel;
class QQuickWindow;
class QQmlApplicationEngine;

class MainView : public QObject
{
    Q_OBJECT
public:
    explicit MainView(const QString& contentDir, QObject* parent = nullptr);

public slots:
    void showWindow(bool state);

private:
    void registerTypesInQml();

private:
    Helper* mHelper;
    QSize mActualSize;
    MegaParse *mParser;
    qreal mAspectRatio;
    QString mContentDir;
    SlideModel* mSlideModel;
    QQuickWindow* mMainWindow;
    QQmlApplicationEngine* mQmlEngine;
};

#endif // MAINVIEW_H
