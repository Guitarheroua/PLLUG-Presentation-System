#ifndef PRESENTATIONMANAGER_H
#define PRESENTATIONMANAGER_H

#include <QObject>
#include <QMap>
#include <QVariant>

class Helper;
class QQuickItem;
class PresentationManager : public QObject
{
    Q_OBJECT
public:
    enum PresentationMode
    {
        Create,
        Edit,
        SlideShow
    };
    explicit PresentationManager(const QString&, QQuickItem*, QObject *parent = 0);
    void openPresentation(const QString&);
    void savePresentation(const QString &);
    void loadPresentation();
    PresentationMode mode();

signals:

public slots:
    void setBlockProperties(QQuickItem*, QVariantMap);
    void setCreatePresentationMode();
    void setShowPresentationMode();

private:
    PresentationMode mMode;
    QString mContentDir;
    Helper* mHelper;
    QQuickItem* mPresentation;
    QQuickItem* mRootObject;

};

#endif // PRESENTATIONMANAGER_H
