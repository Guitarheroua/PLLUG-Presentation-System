#ifndef BLOCK_H
#define BLOCK_H

#include <QRect>
#include <QVariantHash>

class ContentBlock: public QRect
{
public:
    enum ContentBlockType
    {
        Text,
        Image,
        Video,
        Browser,
        Code
    };

    ContentBlock();

    ContentBlock(const QPoint & topLeft, const QPoint & bottomRight,
                 int z, ContentBlockType contentBlockType);

    ContentBlock(const QPoint & topLeft, const QSize & size,
                 int z, ContentBlockType contentBlockType);

    ContentBlock(int x, int y, int width, int height,
                 int z, ContentBlockType contentBlockType);

    ~ContentBlock();

    int z() const;
    void setZ(int z);

    QVariantMap content() const;
    void setContent(const QString &name, const QVariant value);

    ContentBlockType contentBlockType() const;
    void setContentBlockType(ContentBlockType contentBlockType);

    ContentBlockType contentBlockType(const QString &contetBlockType) const;

private:
    void initContentTypeHash();

private:
    int mZOrder;
    QVariantMap mContent;
    ContentBlockType mContentBlockType;
    QHash<QString, ContentBlockType> mContentBlockTypeHash;
};

#endif // BLOCK_H
