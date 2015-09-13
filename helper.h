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
    explicit Helper(QObject *parent = nullptr);
    Q_INVOKABLE QString readShader(const QString& fileName);
    Q_INVOKABLE qreal hue(const QString &color);
    Q_INVOKABLE qreal saturation(const QString &color);
    Q_INVOKABLE qreal brightness(const QString &color);
    Q_INVOKABLE qreal alpha(const QString &color);

    Q_INVOKABLE QStringList fonts();
    Q_INVOKABLE int fontIndex(const QString &font);

    Q_INVOKABLE void openPresentation(const QUrl &);
    Q_INVOKABLE void setCreatePresentationMode();
    Q_INVOKABLE bool enableEdit();

    void setScreenPixelSize(QSize size);
    void setMainViewSize(QSize size);
    Q_INVOKABLE QSize screenSize() const;
    Q_INVOKABLE qreal mainViewWidth() const;
    Q_INVOKABLE qreal mainViewHeight() const;

    Q_INVOKABLE void setEnableEdit(bool enabled);
    
signals:
    void open(const QString &);
    void createPresentationMode();
    
private:
    bool mEnableEdit;
    QSize mScreenSize;
    QSize mMainViewSize;
};
#endif // HELPER_H
