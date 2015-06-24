import QtQuick 2.4

Rectangle {
    id: item
    property color unselectedItemColor: "grey"
    property bool selected: false
    property string imageSource: ""
    property bool selectingItem: true
    color: (item.selected ) ? Qt.darker(item.color, 1.5) : unselectedItemColor
    height: width
    Image {
        anchors.fill: parent
        anchors.margins: 2
        source: imageSource
    }

    MouseArea{
        anchors.fill: parent
        onClicked: {
            if (selectingItem) {
                item.selected = !item.selected
            }
        }
        onPressed: {
            if (!selectingItem) {
                item.selected = true
            }
        }
        onReleased: {
            if (!selectingItem) {
                item.selected = false
            }
        }
    }
}
