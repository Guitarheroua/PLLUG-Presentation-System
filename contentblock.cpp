#include "contentblock.h"

ContentBlock::ContentBlock()
{
    initContentTypeHash();
}

ContentBlock::ContentBlock(int x, int y, int width, int height, int z, ContentBlock::ContentBlockType contentType):
    ContentBlock(QPoint(x, y), QSize(width, height), z, contentType)
{
}

ContentBlock::~ContentBlock()
{
}

ContentBlock::ContentBlock(const QPoint &topLeft, const QSize &size, int z, ContentBlock::ContentBlockType contentType):
    QRect{topLeft, size},
    mZOrder{z},
    mContentBlockType{contentType}
{
    initContentTypeHash();
}

ContentBlock::ContentBlock(const QPoint &topLeft, const QPoint &bottomRight, int z, ContentBlock::ContentBlockType contentType):
    QRect{topLeft, bottomRight},
    mZOrder{z},
    mContentBlockType{contentType}
{
    initContentTypeHash();
}

int ContentBlock::z() const
{
    return mZOrder;
}

void ContentBlock::setZ(int z)
{
    mZOrder = z;
}

ContentBlock::ContentBlockType ContentBlock::contentBlockType() const
{
    return mContentBlockType;
}

void ContentBlock::setContentBlockType(ContentBlock::ContentBlockType contentBlockType)
{
    mContentBlockType = contentBlockType;
}

ContentBlock::ContentBlockType ContentBlock::contentBlockType(const QString &contetBlockType) const
{
    return mContentBlockTypeHash[contetBlockType];
}

void ContentBlock::initContentTypeHash()
{
    mContentBlockTypeHash.insert("Text", Text);
    mContentBlockTypeHash.insert("Image", Image);
    mContentBlockTypeHash.insert("Video", Video);
    mContentBlockTypeHash.insert("Browser", Browser);
    mContentBlockTypeHash.insert("Code", Code);
}

QVariantMap ContentBlock::content() const
{
    return mContent;
}

void ContentBlock::setContent(const QString &name, const QVariant value)
{
    mContent.insert(name, value);
}
