#ifndef BLOCK_H
#define BLOCK_H

#include <QObject>
#include <QSize>
#include <QPoint>
#include <QVariantMap>

class ContentBlock: public QObject
{
    Q_OBJECT
    Q_ENUMS(ContentBlockType)
    Q_PROPERTY(int x READ x WRITE setX)
    Q_PROPERTY(int y READ y WRITE setY)
    Q_PROPERTY(int z READ z WRITE setZ)
    Q_PROPERTY(int width READ width WRITE setWidth)
    Q_PROPERTY(int height READ height WRITE setHeight)
    Q_PROPERTY(ContentBlockType contentBlockType READ contentBlockType WRITE setContentBlockType)

public:
    enum ContentBlockType
    {
        Text,
        Image,
        Video,
        Browser,
        Code,
        None
    };

    explicit ContentBlock(QObject *parent = 0);

    explicit ContentBlock(int x, int y, int z, int width, int height,
                          ContentBlockType contentBlockType = None, QObject *parent = 0);

    ~ContentBlock();

    int x() const;
    void setX(int x);

    int y() const;
    void setY(int y);

    int z() const;
    void setZ(int z);

    int width() const;
    void setWidth(int width);

    int height() const;
    void setHeight(int height);

    QVariantMap specificContent() const;
    void setSpecificContent(const QString &name, const QVariant value);

    ContentBlockType contentBlockType() const;
    void setContentBlockType(ContentBlockType contentBlockType);

private:
    QSize mSize;
    int mZOrder;
    QPoint mTopLeftPoint;
    QVariantMap mSpecificContent;
    ContentBlockType mContentBlockType;
};

#endif // BLOCK_H
