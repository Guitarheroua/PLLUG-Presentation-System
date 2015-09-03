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

    Q_INVOKABLE void appendBlock(ContentBlock *contentBlock);

    Q_INVOKABLE int blockCount() const;
    Q_INVOKABLE ContentBlock *contentBlock(int index) const;
    Q_INVOKABLE QList<ContentBlock *> contentBlocks() const;

private:
    QList<ContentBlock *> mContentBlocksList;
};

#endif // SLIDE_H
