#ifndef MEGAPARSE_H
#define MEGAPARSE_H

#include <QObject>

class Slide;

class MegaParse : public QObject
{
    Q_OBJECT
public:
    explicit MegaParse(QObject *parent = 0);
    ~MegaParse();
    void parsePresenationData();
    void parseTemplatesData();
    void setContentDir(const QString pDir);
    QList<Slide*> pagesList();

signals:
    
private:
    QList<Slide*> mPagesList;
    QList<Slide*> mTemplatesList;
    QString mContentDir;
};

#endif // MEGAPARSE_H
