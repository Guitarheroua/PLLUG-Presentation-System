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
    void resizeEvent(QResizeEvent *);
    
signals:
    
private slots:
    void test(QQuickItem*);

private:
    MegaParse *mParser;
    QList<Page*> mPagesList;

};

#endif // MAINVIEW_H
