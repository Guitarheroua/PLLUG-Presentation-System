#include "block.h"
#include <QDebug>

Block::Block(QVariantMap pMap)
{
    mMap = pMap;
//    qDebug() << "BLOCK" << title();
}


int Block::width() const
{
    return mMap.value("width").toInt();
}

int Block::height() const
{
    return mMap.value("height").toInt();
}

int Block::x() const
{
    return mMap.value("x").toInt();
}

int Block::y() const
{
    return mMap.value("y").toInt();
}

QString Block::title() const
{
    return mMap.value("text container").toMap().value("value").toString();
}

QString Block::sourceType() const
{
    return mMap.value("media content").toMap().value("type").toString();
}

QString Block::source() const
{
    return mMap.value("media content").toMap().value("source").toString();
}
