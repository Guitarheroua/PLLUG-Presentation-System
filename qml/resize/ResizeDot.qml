import QtQuick 2.0

Rectangle
{
    anchors.fill: parent
    color: "black"
    radius: 5
    Rectangle{
        anchors.centerIn: parent
        height: parent.height / 2
        width: parent.width / 2
        radius: parent.radius
    }
}

