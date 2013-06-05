#ifndef MEGAPARSE_H
#define MEGAPARSE_H

#include <QObject>

class Page;

class MegaParse : public QObject
{
    Q_OBJECT
public:
    explicit MegaParse(QObject *parent = 0);
    ~MegaParse();
    void parseData();
    void setContentDir(const QString pDir);
    QList<Page*> pagesList();

signals:
    
private:
    QList<Page*> mPagesList;
    QString mContentDir;
};

#endif // MEGAPARSE_H
