#ifndef MACHELPER_H
#define MACHELPER_H

#include <QObject>
#include <QQuickView>


class MacHelper: public QObject
{
    Q_OBJECT
public:
    MacHelper();
    void setAspectRatio(WId);
};

#endif // MACHELPER_H
