#include "contentblock.h"

ContentBlock::ContentBlock()
{
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
}

ContentBlock::ContentBlock(const QPoint &topLeft, const QPoint &bottomRight, int z, ContentBlock::ContentBlockType contentType):
    QRect{topLeft, bottomRight},
    mZOrder{z},
    mContentBlockType{contentType}
{
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

QVariantHash ContentBlock::content() const
{
    return mContent;
}

void ContentBlock::setContent(const QString name, const QVariant value)
{
    mContent.insert(name, value);
}
