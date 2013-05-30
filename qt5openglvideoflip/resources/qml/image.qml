import QtQuick 2.0

Rectangle
{
    id: item
    property string type : "image"
    property string source
    property int mainWidth
    property int mainHeight
    property int mainX
    property int mainY
    Image
    {
        anchors.fill : parent
        source: item.source
    }

}


