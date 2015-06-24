import QtQuick 2.4

Rectangle {
    id: buttonRoot
    property string text
    signal pressed
    width: 350
    height: 50
    radius: 10
    Text {
        anchors.centerIn: parent
        text: buttonRoot.text
        font {
            pointSize: 20
            italic: true
        }
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            buttonRoot.pressed()
        }
    }

}
