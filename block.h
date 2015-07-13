#ifndef BLOCK_H
#define BLOCK_H

#include <QString>
#include <QVariantMap>

class Block
{
public:
    struct MediaContent{
        QString type;
        QString source;
        QString aspect;
    };
    struct Caption{
        QString color;
        QString text;
        QString background;
        int fontSize;
        QString fontFamily;
        QString align;
        QString textAlign;

    };

    Block(QVariantMap pMap);
    int width() const;
    int height() const;
    int x() const;
    int y() const;
    QString background() const;

    QString title() const;
    Block::Caption caption() const;
    Block::MediaContent mediaContent() const;
    QString sourceType() const;
    QString source() const;


private:
    QVariantMap mMap;
};

Q_DECLARE_METATYPE(Block::Caption)
Q_DECLARE_METATYPE(Block::MediaContent)

#endif // BLOCK_H
