import QtQuick 2.4

Rectangle {
    id: menuItemRoot
    property string title
    signal triggered

    color: "gray"
    Text {
        text: title
        anchors.centerIn: parent
        font.pixelSize: parent.width/4
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            menuItemRoot.triggered()
        }
    }
}
