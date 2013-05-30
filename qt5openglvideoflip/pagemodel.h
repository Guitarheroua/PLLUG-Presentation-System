#ifndef PAGEMODEL_H
#define PAGEMODEL_H

#include <QAbstractListModel>

class PageModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit PageModel(QObject *parent = 0);

    enum ScenariosListRoles
    {
        BackgroundRole = Qt::UserRole + 1,
        IdRole = Qt::UserRole + 2
    };
signals:
    
public slots:
    
};

#endif // PAGEMODEL_H
