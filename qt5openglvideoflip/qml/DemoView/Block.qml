import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0
import QtQuick.Dialogs 1.0

Rectangle {
    border{
        color: "lightgray"
        width: 1
    }

    Loader
    {
        id: pageLoader
        anchors.fill: parent
        z: 2
//        onLoaded:
//        {
//            contextMenu.enabled = false
//        }
    }


//    MouseArea {
//        anchors.fill: parent
//        acceptedButtons: Qt.AllButtons
//        onClicked:
//        {
//            if( mouse.button === Qt.RightButton && pageLoader.status != Loader.Ready)
//            {
//                contextMenu.popup()
//            }
//        }
//    }


    Item
    {
        id: menu
        anchors
        {
            centerIn: parent
        }
        width: 102
        height: 102

        property int selectedItem: 0

        Grid
        {
            columns: 2
            rows: 2
            spacing: 2
            anchors.fill: parent
            Rectangle
            {
                width: 50
                height: 50
                color: "gray"
                Text
                {
                    text: "Text"
                    anchors.centerIn: parent
                }
                MouseArea
                {
                    anchors.fill: parent
                    onClicked: {
                        pageLoader.source = "items/text.qml"
                        menu.selectedItem = 0;
                    }
                }
            }
            Rectangle
            {
                width: 50
                height: 50
                color: "gray"
                Text
                {
                    text: "Image"
                    anchors.centerIn: parent
                }
                MouseArea
                {
                    anchors.fill: parent
                    onClicked: {
                        fileDialog.nameFilters = ["Image files (*.jpg *.png)"];
                        fileDialog.open();
                        menu.selectedItem = 1;
                    }
                }
            }
            Rectangle
            {
                width: 50
                height: 50
                color: "gray"
                Text
                {
                    text: "Video"
                    anchors.centerIn: parent
                }
                MouseArea
                {
                    anchors.fill: parent
                    onClicked: {
                        fileDialog.nameFilters = ["Video files (*.mp4 *.avi)"];
                        fileDialog.open();
                        menu.selectedItem = 2;
                    }
                }
            }
            Rectangle
            {
                width: 50
                height: 50
                color: "gray"
                Text
                {
                    text: "Browser"
                    anchors.centerIn: parent
                }
                MouseArea
                {
                    anchors.fill: parent
                    onClicked: {
                        pageLoader.source = "items/web.qml"
                        menu.selectedItem = 3;
                    }
                }
            }
        }
    }

//    Menu
//    {
//        id: contextMenu
//        title: "Menu"
//        MenuItem
//        {
//            text: "Image"
//            onTriggered:
//            {
//                fileDialog.nameFilters = ["Image files (*.jpg *.png)"];
//                fileDialog.open();
//            }

//        }
//        MenuItem
//        {
//            text: "Video"
//            onTriggered:
//            {
//                fileDialog.nameFilters = ["Video files (*.mp4 *.avi)"];
//                fileDialog.open();
//            }
//        }
//        MenuItem
//        {
//            text: "Browser"
//            onTriggered:
//            {
//                pageLoader.source = "web.qml"
//            }
//        }
//    }

    FileDialog{
        id: fileDialog
        title: "Please choose a file"
        selectMultiple: false
        onAccepted: {
            switch(menu.selectedItem)
            {
            case 1: pageLoader.setSource("items/image.qml", { "source": fileDialog.fileUrl })
                break
            case 2:
                pageLoader.setSource("items/video.qml", { "source": fileDialog.fileUrl })
                break

            }

        }

    }


}
