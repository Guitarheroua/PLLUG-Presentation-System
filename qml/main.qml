import QtQuick 2.5
import QtQuick.Controls 1.4
import "resize"

ApplicationWindow {
    property bool presmode: false
    id: mainRect
    objectName: "mainRect"
//    width: 700
//    height: 500

    signal changeWindowMode(bool state)

    Loader {
        id: presentationLoader
        objectName: "PresentationLoader"
        anchors.fill: parent
        focus: true
    }

    StartScreen {
        id: startScreen
        width: parent.width
        height: parent.height
        color: "lightsteelblue"
    }
}
