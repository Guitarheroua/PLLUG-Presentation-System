#ifndef MAINVIEW_H
#define MAINVIEW_H

#include <QQuickView>

class Slide;
class QWindow;
class Helper;
class MegaParse;
class PresentationManager;
class MainView : public QQuickView
{
    Q_OBJECT
public:
    explicit MainView( const QString& pContentDir, QWindow *parent = 0);

protected:
//    void resizeEvent(QResizeEvent *);
    bool nativeEvent(const QByteArray&, void*, long*);
    bool event(QEvent * event);

signals:
    
private slots:
    void openPresentation(const QString& );
    void test(QQuickItem*);
    void test1(int);


private:
    QString mContentDir;
    MegaParse *mParser;
    QList<Slide*> mSlidesList;
    QSize mActualSize;
    QSize mOldSize;
    qreal mAspectRatio;
    Helper* mHelper;
    PresentationManager* mManager;

};

#endif // MAINVIEW_H
