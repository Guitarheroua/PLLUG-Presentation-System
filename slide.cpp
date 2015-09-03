#include "slide.h"
#include "contentblock.h"

Slide::Slide(QObject *parent) :
    QObject{parent}
{
}

Slide::~Slide()
{
    qDeleteAll(mContentBlocksList);
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

