#ifndef HELPER_H
#define HELPER_H

#include <QObject>
#include <QStringList>
#include <QUrl>
#include <QSize>

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
    Q_INVOKABLE void setCreatePresentationMode();
    Q_INVOKABLE bool enableEdit();

    void setScreenPixelSize(QSize);
    void setMainViewSize(QSize);
    Q_INVOKABLE QSize screenSize();
    Q_INVOKABLE qreal mainViewWidth();
    Q_INVOKABLE qreal mainViewHeight();

    Q_INVOKABLE void setEnableEdit(bool);
    
signals:
    void open(const QString &);
    void createPresentationMode();
    
public slots:

private:
    QSize mScreenSize;
    QSize mMainViewSize;
    bool mEnableEdit;
    
};

#endif // HELPER_H
