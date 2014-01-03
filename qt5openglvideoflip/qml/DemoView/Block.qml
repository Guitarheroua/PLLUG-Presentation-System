import QtQuick 2.0
import QtQuick.Dialogs 1.0

Rectangle {
    id: item
    property alias contentItem: pageLoader.item
//    property bool enableEdit: true

    objectName: "block"
    color: (helper.enableEdit())? "white" :"transparent"
    border
    {
        color: "lightgray"
        width: (/*enableEdit*/ helper.enableEdit())? 1 : 0
    }
    function load(url)
    {
        pageLoader.setSource(url, {})
    }


    Loader
    {
        id: pageLoader
        objectName: "blockLoader"
        anchors.fill: parent
        z: 2
    }

    Item
    {
        id: menu
        objectName: "menu"
        z: parent.z+1
        anchors
        {
            centerIn: parent
        }
        width: Math.min(item.width, item.height)/4.5
        height: width
        visible: /*item.enableEdit*/ helper.enableEdit()

        property int selectedItem: 0
        property int itemWidth: width/2 - 1

        Grid
        {
            columns: 2
            rows: 2
            spacing: 2
            anchors.fill: parent
            Rectangle
            {
                width: menu.itemWidth
                height:  menu.itemWidth
                color: "gray"
                Text
                {
                    text: "Text"
                    anchors.centerIn: parent
                    font.pixelSize: menu.itemWidth/4
                }
                MouseArea
                {
                    anchors.fill: parent
                    onClicked: {
                        pageLoader.source = "items/TextItem.qml"
                        menu.selectedItem = 0;
                        menu.visible = false
                    }
                }
            }
            Rectangle
            {
                width:  menu.itemWidth
                height:  menu.itemWidth
                color: "gray"
                Text
                {
                    text: "Image"
                    anchors.centerIn: parent
                    font.pixelSize: menu.itemWidth/4
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
                width:  menu.itemWidth
                height:  menu.itemWidth
                color: "gray"
                Text
                {
                    text: "Video"
                    anchors.centerIn: parent
                    font.pixelSize: menu.itemWidth/4
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
                width:  menu.itemWidth
                height:  menu.itemWidth
                color: "gray"
                Text
                {
                    text: "Browser"
                    anchors.centerIn: parent
                    font.pixelSize: menu.itemWidth/4
                }
                MouseArea
                {
                    anchors.fill: parent
                    onClicked: {
                        pageLoader.source = "items/web.qml"
                        menu.selectedItem = 3;
                        menu.visible = false
                    }
                }
            }
        }
    }

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
            menu.visible = false

        }

    }


}
