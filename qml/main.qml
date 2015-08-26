import QtQuick 2.4
import QtQuick.Controls 1.2

import "resize"
//import "background"
import "panels"

ApplicationWindow {
    id: mainRect
    objectName: "mainRect"
    width: 1280
    height: 720

    property bool isContextMenuVisible: true

    MouseArea{
        anchors.fill: parent

        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: {
            if (mouse.button == Qt.RightButton)
            {
                idContextMenu.popup(isContextMenuVisible);
                isContextMenuVisible = !isContextMenuVisible;
            }
        }
    }

    ContextMenu {
        id: idContextMenu
    }

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
