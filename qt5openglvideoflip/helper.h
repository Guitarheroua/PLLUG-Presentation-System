#ifndef HELPER_H
#define HELPER_H

#include <QObject>
#include <QStringList>
#include <QUrl>

class MainView;
class Helper : public QObject
{
    Q_OBJECT
public:
    explicit Helper(QObject *parent = 0 );
    Q_INVOKABLE void test1(const QString& pString);
    Q_INVOKABLE QString readShader(const QString& );
    Q_INVOKABLE qreal hue(const QString&);
    Q_INVOKABLE qreal saturation(const QString&);
    Q_INVOKABLE qreal brightness(const QString&);
    Q_INVOKABLE qreal alpha(const QString&);

    Q_INVOKABLE QStringList fonts();
    Q_INVOKABLE int fontIndex(const QString&);

    Q_INVOKABLE void openPresentation(const QUrl &);
    
signals:
    void open(const QString &);
    
public slots:

private:
    
};

#endif // HELPER_H
