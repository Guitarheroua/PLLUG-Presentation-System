import QtQuick 2.4
import QtQuick.Controls 1.2
import "resize"

ApplicationWindow {
    id: mainRect
    objectName: "mainRect"
    width: 1280
    height: 720
    property bool isContextMenuVisible: true
    MouseArea{
        anchors.fill: parent
        onClicked: {
            contextMenuid.popup(isContextMenuVisible);
            isContextMenuVisible = !isContextMenuVisible;
        }
    }

    Menu {
        id:contextMenuid
        title: "Edit"

        MenuItem {
            text: "Cut"
            shortcut: "Ctrl+X"
        }

        MenuItem {
            text: "Copy"
            shortcut: "Ctrl+C"
        }

        MenuItem {
            text: "Paste"
            shortcut: "Ctrl+V"
        }

        MenuSeparator { }

        Menu {
            title: "More Stuff"

            MenuItem {
                text: "Do Nothing"
            }
        }
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
