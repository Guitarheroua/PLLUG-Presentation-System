import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0
import QtQuick.Dialogs 1.0

Rectangle {
//    width: 400
//    height: 400
    Loader
    {
        id: pageLoader
        anchors.fill: parent
        z: 2
        onLoaded:
        {
            contextMenu.enabled = false
        }
    }


    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.AllButtons
        onClicked:
        {
            if( mouse.button === Qt.RightButton && pageLoader.status != Loader.Ready)
            {
                contextMenu.popup()
            }
        }
    }

    Menu
    {
        id: contextMenu
        title: "Menu"
        MenuItem
        {
            text: "Image"
            onTriggered:
            {
                fileDialog.nameFilters = ["Image files (*.jpg *.png)"];
                fileDialog.open();
            }

        }
        MenuItem
        {
            text: "Video"
            onTriggered:
            {
                fileDialog.nameFilters = ["Video files (*.mp4 *.avi)"];
                fileDialog.open();
            }
        }
        MenuItem
        {
            text: "Browser"
            onTriggered:
            {
                pageLoader.source = "web.qml"
            }
        }
    }

    FileDialog{
        id: fileDialog
        title: "Please choose a file"
        selectMultiple: false
        onAccepted: {
            switch(contextMenu.__selectedIndex)
            {
            case 0: pageLoader.setSource("image.qml", { "source": fileDialog.fileUrl })
                break
            case 1:
                pageLoader.setSource("video.qml", { "source": fileDialog.fileUrl })
                break

            }

            console.log("@@@",contextMenu.__selectedIndex)
        }

    }


}
