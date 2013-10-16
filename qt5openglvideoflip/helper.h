#ifndef HELPER_H
#define HELPER_H

#include <QObject>

class Helper : public QObject
{
    Q_OBJECT
public:
    explicit Helper(QObject *parent = 0);
    Q_INVOKABLE void test1(const QString& pString);
    Q_INVOKABLE QString readShader(const QString& );
    
signals:
    
public slots:
    
};

#endif // HELPER_H
