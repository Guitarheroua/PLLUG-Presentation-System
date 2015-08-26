import QtQuick 2.4
import QtQuick.Controls 1.2
import "resize"
import "backgrounds"

ApplicationWindow {
    id: mainRect
    objectName: "mainRect"
    width: 1280
    height: 720
    property bool isContextMenuVisible: true


    MouseArea{
        id:ma
        anchors.fill: parent

        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onClicked: {

            if (mouse.button == Qt.RightButton)
            {
                contextMenuid.popup(isContextMenuVisible);
                isContextMenuVisible = !isContextMenuVisible;
            }
            //            else
            //                isContextMenuVisible = true
        }
    }

    //    MouseArea{
    //        anchors.fill: parent
    //        onClicked: {
    //            contextMenuid.popup(isContextMenuVisible);
    //            isContextMenuVisible = !isContextMenuVisible;
    //        }
    //    }

    //    Menu {
    //        id:contextMenuid
    //        title: "Edit"

    //        MenuItem {
    //            text: "Cut"
    //            shortcut: "Ctrl+X"
    //        }

    //        MenuItem {
    //            text: "Copy"
    //            shortcut: "Ctrl+C"
    //        }

    //        MenuItem {
    //            text: "Paste"
    //            shortcut: "Ctrl+V"
    //        }

    //        MenuSeparator { }

    //        Menu {
    //            title: "More Stuff"

    //            MenuItem {
    //                text: "Do Nothing"
    //            }
    //        }
    //    }


    Menu {
        id:contextMenuid
        title: qsTr("File")
        MenuItem {
            text: qsTr("Exit")
            onTriggered: Qt.quit();
        }


        MenuItem {
            text: qsTr("BackgroundSwirls")
            onTriggered: {
                presentationLoader.setSource("BackgroundSwirls.qml")
            }
        }
        MenuItem {
            text: qsTr("Export Ego")
            onTriggered: {
                var reader = Qt.createComponent("qrc:///qml/ExportEgo.qml");
                var readerWnd = reader.createObject();
                readerWnd.show();
            }
        }

        MenuItem {
            text: qsTr("Profile")
            onTriggered: {
                var profile = Qt.createComponent("qrc:///qml/Profile.qml");
                var profileWnd = profile.createObject();
                profileWnd.show();
            }
        }

        MenuItem {
            text: qsTr("Single Chat")
            onTriggered: {
                var single = Qt.createComponent("qrc:///qml/SingleConversation.qml");
                var singleWnd = single.createObject();
                singleWnd.show();
            }
        }

        MenuItem {
            text: qsTr("Threaded Chat")
            onTriggered: {
                var threaded = Qt.createComponent("qrc:///qml/ThreadChat.qml");
                var threadedWnd = threaded.createObject();
                threadedWnd.show();
            }
        }

        MenuItem {
            text: qsTr("About")
            onTriggered: {
                var threaded = Qt.createComponent("qrc:///qml/About.qml");
                var threadedWnd = threaded.createObject();
                threadedWnd.show();
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
