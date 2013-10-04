#ifndef MAINVIEW_H
#define MAINVIEW_H

#include <QQuickView>

class Page;
class QWindow;
class MegaParse;
class MainView : public QQuickView
{
    Q_OBJECT
public:
    explicit MainView( const QString& pContentDir, QWindow *parent = 0);

protected:
//    void resizeEvent(QResizeEvent *);
    bool nativeEvent(const QByteArray&, void*, long*);

    
signals:
    
private slots:
    void test(QQuickItem*);
    void test1(int);

private:
    MegaParse *mParser;
    QList<Page*> mPagesList;
    QSize mActualSize;
    QSize mOldSize;
    qreal mAspectRatio;

};

#endif // MAINVIEW_H
