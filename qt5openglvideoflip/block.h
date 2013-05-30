#ifndef BLOCK_H
#define BLOCK_H

#include <QString>
#include <QVariantMap>

class Block
{
public:
    struct MediaCont{
        QString type;
        QString source;
    };
    struct Caption{
        QString color;
        QString text;
    };

    Block(QVariantMap pMap);
    int width() const;
    int height() const;
    int x() const;
    int y() const;

    QString title() const;
    QString sourceType() const;
    QString source() const;


private:
    QVariantMap mMap;
};

#endif // BLOCK_H
