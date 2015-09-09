#include "slide.h"
#include "contentblock.h"

Slide::Slide(QObject *parent) :
    QObject{parent}
{
    appendBlock(new ContentBlock(10, 10, 10, 100, 100));
    appendBlock(new ContentBlock(100, 100, 10, 150, 100));
    appendBlock(new ContentBlock(150, 150, 10, 150, 100));
}

Slide::~Slide()
{
//    qDeleteAll(mContentBlocksList);
}

void Slide::appendBlock(ContentBlock *contentBlock)
{
    mContentBlocksList.append(contentBlock);
}

ContentBlock *Slide::contentBlock(int index) const
{
    return mContentBlocksList.value(index);
}

int Slide::blockCount() const
{
    return mContentBlocksList.count();
}

QList<ContentBlock *> Slide::contentBlocks() const
{
    return mContentBlocksList;
}

