import QtQuick 2.4
import QtQuick.Controls 1.2
import "resize"

ApplicationWindow {
    id: mainRect
    objectName: "mainRect"
    width: 1280
    height: 720







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
