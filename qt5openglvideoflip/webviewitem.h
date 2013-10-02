#ifndef WEBVIEWITEM_H
#define WEBVIEWITEM_H

#include <QWebView>

class WebViewItem : public QObject
{
    Q_OBJECT
public:
    explicit WebViewItem(QWidget* parent = 0);
    
signals:
    
public slots:

private:
    QWebView* mView;
    
};

#endif // WEBVIEWITEM_H
