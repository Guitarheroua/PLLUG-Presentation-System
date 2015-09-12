#ifndef PRESENTATIONMANAGER_H
#define PRESENTATIONMANAGER_H

#include <QObject>
#include <QMap>
#include <QVariant>

class Helper;
class QQuickWindow;
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
    explicit PresentationManager(const QString&, QQuickWindow *, Helper *helper, QObject *parent = nullptr);
    void savePresentation(const QString &path);
    void loadPresentation();
    PresentationMode mode() const;

signals:

public slots:
    void openPresentation(const QString &path);
    void setBlockProperties(QQuickItem*, QVariantMap);
    void setCreateEditPresentationMode();
    void setShowPresentationMode();

private:
    PresentationMode mMode;
    QString mContentDir;
    Helper* mHelper;
    QQuickItem* mPresentation;
    QQuickWindow* mRootObject;

};

#endif // PRESENTATIONMANAGER_H
