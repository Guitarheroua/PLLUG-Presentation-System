#include "contentblock.h"

ContentBlock::ContentBlock(QObject *parent):
    ContentBlock{0, 0, 0, 0, 0, None, parent}
{
}

ContentBlock::ContentBlock(int x, int y, int z, int width, int height, ContentBlock::ContentBlockType contentType, QObject *parent):
    mTopLeftPoint{x, y},
    mSize{width, height},
    mZOrder{z},
    mContentBlockType{contentType},
    QObject{parent}
{
}

ContentBlock::~ContentBlock()
{
}

int ContentBlock::x() const
{
    return mTopLeftPoint.x();
}

void ContentBlock::setX(int x)
{
    mTopLeftPoint.setX(x);
}

int ContentBlock::y() const
{
    return mTopLeftPoint.y();
}

void ContentBlock::setY(int y)
{
    mTopLeftPoint.setY(y);
}

int ContentBlock::z() const
{
    return mZOrder;
}

void ContentBlock::setZ(int z)
{
    mZOrder = z;
}

int ContentBlock::width() const
{
    return mSize.width();
}

void ContentBlock::setWidth(int width)
{
    mSize.setWidth(width);
}

int ContentBlock::height() const
{
    return mSize.height();
}

void ContentBlock::setHeight(int height)
{
    mSize.setHeight(height);
}

ContentBlock::ContentBlockType ContentBlock::contentBlockType() const
{
    return mContentBlockType;
}

void ContentBlock::setContentBlockType(ContentBlock::ContentBlockType contentBlockType)
{
    mContentBlockType = contentBlockType;
}

QVariantMap ContentBlock::specificContent() const
{
    return mSpecificContent;
}

void ContentBlock::setSpecificContent(const QString &name, const QVariant value)
{
    mSpecificContent.insert(name, value);
}
