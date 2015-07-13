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

QString Block::background() const
{
   return mMap.value("background-color").toString();
}

QString Block::title() const
{
    return mMap.value("text container").toMap().value("value").toString();
}

Block::Caption Block::caption() const
{
    Caption rCaption;
    rCaption.text = mMap.value("text container").toMap().value("value").toString();
    rCaption.color = mMap.value("text container").toMap().value("color").toString();
    rCaption.background = mMap.value("text container").toMap().value("background").toString();
    rCaption.align = mMap.value("text container").toMap().value("align").toString();
    rCaption.fontSize = mMap.value("text container").toMap().value("font-size").toInt();
    rCaption.fontFamily = mMap.value("text container").toMap().value("font-family").toString();
    rCaption.textAlign = mMap.value("text container").toMap().value("text-align").toString();
    return rCaption;

}

Block::MediaContent Block::mediaContent() const
{
    MediaContent rMediaContent;
    rMediaContent.source = mMap.value("media content").toMap().value("source").toString();
    rMediaContent.type = mMap.value("media content").toMap().value("type").toString();
    rMediaContent.aspect = mMap.value("media content").toMap().value("aspect").toString();
    return rMediaContent;
}

QString Block::sourceType() const
{
    return mMap.value("media content").toMap().value("type").toString();
}

QString Block::source() const
{
    return mMap.value("media content").toMap().value("source").toString();
}
