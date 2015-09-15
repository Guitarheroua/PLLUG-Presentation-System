#include "contentblock.h"
#include <QUuid>

ContentBlock::ContentBlock(ContentBlock *parent):
    ContentBlock{0, 0, 0, 0, 0, None, parent}
{
}

ContentBlock::ContentBlock(int x, int y, int z, int width, int height, ContentBlock::ContentBlockType contentType, ContentBlock *parent):
    QObject{parent},
    mSize{width, height},
    mZOrder{z},
    mTopLeftPoint{x, y},
    mParent{parent},
    mContentBlockType{contentType}
{
}

ContentBlock::~ContentBlock()
{
    qDeleteAll(mChildsList);
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

ContentBlock *ContentBlock::parent() const
{
    return mParent;
}

void ContentBlock::setParent(ContentBlock *parent)
{
    mParent = parent;
}

QString ContentBlock::id()
{
    if(mId.isEmpty())
    {
        mId = QUuid::createUuid().toString();
    }
    return mId;
}

ContentBlock *ContentBlock::child(int index) const
{
    return mChildsList.value(index);
}

void ContentBlock::appendChild(ContentBlock *child)
{
    if(!child)
    {
        child = new ContentBlock(this);
    }
    mChildsList.append(child);
}

void ContentBlock::insertChild(int index, ContentBlock *child)
{
    if(!child)
    {
        child = new ContentBlock(this);
    }
    mChildsList.insert(index, child);
}

void ContentBlock::swapChild(int firstIndex, int secondIndex)
{
    mChildsList.swap(firstIndex, secondIndex);
}

void ContentBlock::removeChild(int index)
{
    mChildsList.removeAt(index);
}

int ContentBlock::childsCount() const
{
    return mChildsList.count();
}

QVariantMap ContentBlock::additionalContent() const
{
    return mSpecificContent;
}

void ContentBlock::setAdditionalContent(const QString &name, const QVariant value)
{
    mSpecificContent.insert(name, value);
}
