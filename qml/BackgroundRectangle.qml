import QtQuick 2.4

Rectangle {
    id: rect
    property string backgroundImage
    Image {
        anchors.fill: parent
        source: rect.backgroundImage
    }
}
