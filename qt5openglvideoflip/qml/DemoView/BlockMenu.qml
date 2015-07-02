import QtQuick 2.4
import QtQuick.Dialogs 1.2

Item {
    id: menu
    property int selectedItem: 0
    property int itemWidth: width/2 - 1
    objectName: "menu"
    z: parent.z+1
    anchors {
        centerIn: parent
    }
    visible: helper.enableEdit()

    Grid {
        columns: 2
        rows: 2
        spacing: 2
        anchors.fill: parent
        BlockMenuItem {
            width: menu.itemWidth
            height: menu.itemWidth
            title: "Text"
            onTriggered: {
                blockLoader.source = "items/TextItem1.qml"
                menu.selectedItem = 0
                menu.visible = false
            }
        }
        BlockMenuItem {
            width: menu.itemWidth
            height: menu.itemWidth
            title: "Image"
            onTriggered: {
                fileDialog.nameFilters = ["Image files (*.jpg *.png)"]
                fileDialog.open()
                menu.selectedItem = 1
            }
        }
        BlockMenuItem {
            width: menu.itemWidth
            height: menu.itemWidth
            title: "Video"
            onTriggered: {
                fileDialog.nameFilters = ["Video files (*.mp4 *.avi)"]
                fileDialog.open()
                menu.selectedItem = 2
            }
        }
        BlockMenuItem {
            width: menu.itemWidth
            height: menu.itemWidth
            title: "Browser"
            onTriggered: {
                blockLoader.source = "items/WebItem.qml"
                menu.selectedItem = 3
                menu.visible = false
            }
        }
    }

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        selectMultiple: false
        onAccepted: {
            switch(menu.selectedItem) {
            case 1: blockLoader.setSource("items/ImageItem.qml", { "source": fileDialog.fileUrl })
                break
            case 2:
                blockLoader.setSource("items/VideoItem.qml", { "source": fileDialog.fileUrl })
                break
            }
            menu.visible = false

        }

    }
}


