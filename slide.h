#ifndef SLIDE_H
#define SLIDE_H

#include <QObject>

class ContentBlock;

class Slide : public QObject
{
    Q_OBJECT
public:
    explicit Slide(QObject *parent = 0);
    ~Slide();

    void appendBlock(ContentBlock *contentBlock);

    int blockCount() const;
    ContentBlock *contentBlock(int index) const;
    QList<ContentBlock *> contentBlocks() const;

private:
    QList<ContentBlock *> mContentBlocksList;
};

#endif // SLIDE_H
