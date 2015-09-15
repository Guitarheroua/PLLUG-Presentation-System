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
    Q_PROPERTY(int x READ x WRITE setX NOTIFY xChanged)
    Q_PROPERTY(int y READ y WRITE setY NOTIFY yChanged)
    Q_PROPERTY(int z READ z WRITE setZ NOTIFY zChanged)
    Q_PROPERTY(int width READ width WRITE setWidth NOTIFY widthChanged)
    Q_PROPERTY(int height READ height WRITE setHeight NOTIFY heightChanged)
    Q_PROPERTY(ContentBlockType contentBlockType READ contentBlockType WRITE setContentBlockType)
    Q_PROPERTY(QVariantMap additionalContent READ additionalContent NOTIFY additionalContentChanged)

public:
    enum ContentBlockType
    {
        Text,
        Image,
        Video,
        Browser,
        Code,
        Slide,
        None
    };

    explicit ContentBlock(ContentBlock *parent = nullptr);

    explicit ContentBlock(int x, int y, int z, int width, int height,
                          ContentBlockType contentBlockType = None, ContentBlock *parent = nullptr);

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

    QVariantMap additionalContent() const;
    Q_INVOKABLE void setAdditionalContent(const QString &name, const QVariant value);

    ContentBlockType contentBlockType() const;
    void setContentBlockType(ContentBlockType contentBlockType);

    ContentBlock *parent() const;
    void setParent(ContentBlock *parent);

    QString id();

    int childsCount() const;
    ContentBlock *child(int index) const;
    void appendChild(ContentBlock *child = nullptr);
    void insertChild(int index, ContentBlock *child = nullptr);
    void swapChild(int firstIndex, int secondIndex);
    void removeChild(int index);

signals:
    void xChanged();
    void yChanged();
    void zChanged();
    void widthChanged();
    void heightChanged();
    void additionalContentChanged();

private:
    QSize mSize;
    QString mId;
    int mZOrder;
    QPoint mTopLeftPoint;
    ContentBlock *mParent;
    QVariantMap mSpecificContent;
    QList<ContentBlock *> mChildsList;
    ContentBlockType mContentBlockType;
};
#endif // BLOCK_H
