#include "webviewitem.h"
#include <QNetworkProxyFactory>
#include <QUrl>
#include <QWidget>

WebViewItem::WebViewItem(QWidget *parent) : QObject(parent)
{
   QNetworkProxyFactory::setUseSystemConfiguration(true);
   QWebSettings::globalSettings()->setAttribute(QWebSettings::LocalStorageEnabled,
   true);

   QWebSettings::globalSettings()->setAttribute(QWebSettings::LocalContentCanAccessRemoteUrls,
   true);

   QWebSettings::globalSettings()->setAttribute(QWebSettings::OfflineWebApplicationCacheEnabled,
   true);

   QWebSettings::globalSettings()->setAttribute(QWebSettings::PluginsEnabled,
   true);

   QWebSettings::globalSettings()->setAttribute(QWebSettings::AutoLoadImages,
   true);

   QWebSettings::globalSettings()->setAttribute(QWebSettings::JavaEnabled,
   true);
   QWebSettings::globalSettings()->setAttribute(QWebSettings::WebGLEnabled,
   true);

   QWebSettings::globalSettings()->setAttribute(QWebSettings::JavascriptEnabled,
   true);

   mView = new QWebView();
   mView->setUrl(QUrl("http://www.youtube.com/watch?v=XGSy3_Czz8k"));
   mView->show();
}
