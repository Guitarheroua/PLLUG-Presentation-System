import QtQuick 2.0

Rectangle {
    id: item
    property color unselectedItemColor: "grey"
    property bool selected: false
    property string imageSource: ""
    color: (item.selected ) ? Qt.darker(item.color, 1.5) : unselectedItemColor

    Image
    {
        anchors.fill: parent
        anchors.margins: 2
        source: imageSource
    }

    MouseArea
    {
        anchors.fill: parent
        onClicked:
        {
            item.selected = !item.selected
        }
    }
}
