import QtQuick 2.4
import QtQuick.Controls 1.2

import "resize"
import "panels"

ApplicationWindow {
    property bool presmode: false
    id: mainRect
    objectName: "mainRect"
    width: 700
    height: 500

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

    ActionMenu{
        id:idActionMenu
    }

    MainMenu {
        id: idMainMenu
    }
}
