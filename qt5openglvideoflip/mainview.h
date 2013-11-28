#ifndef MAINVIEW_H
#define MAINVIEW_H

#include <QQuickView>

class Slide;
class QWindow;
class Helper;
class MegaParse;
class MainView : public QQuickView
{
    Q_OBJECT
public:
    enum PresentationMode
    {
        Create,
        Edit,
        SlideShow
    };

    explicit MainView( const QString& pContentDir, QWindow *parent = 0);
    void savePresentation(const QString& );

protected:
//    void resizeEvent(QResizeEvent *);
    bool nativeEvent(const QByteArray&, void*, long*);
    bool event(QEvent * event);

signals:
    
private slots:
    void openPresentation(const QString& );
    void setCreatePresentationMode();
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
    PresentationMode mMode;

};

#endif // MAINVIEW_H
