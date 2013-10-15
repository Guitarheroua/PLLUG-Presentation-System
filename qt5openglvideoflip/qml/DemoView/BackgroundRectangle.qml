import QtQuick 2.0

Rectangle
{
    id: rect
    property string backgroundImage
    Image
    {
        anchors.fill: parent
        source: rect.backgroundImage
    }
}
