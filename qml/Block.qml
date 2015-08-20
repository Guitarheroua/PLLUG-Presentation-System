import QtQuick 2.4
import QtQuick.Dialogs 1.2

Rectangle {
    id: blockRoot


    property alias contentItem: blockLoader.item

    objectName: "block"
    enabled: !mainRect.presmode
    color: (mainRect.presmode)? "transparent" :"white"
    border {
        color: "lightgray"
        width: mainRect.presmode ? 0 : 1
    }
    function load(url) {
        blockLoader.setSource(url, {})
    }

    Loader {
        id: blockLoader
        objectName: "blockLoader"
        anchors.fill: parent
        z: 2
    }


    BlockMenu {

        width: Math.min(parent.width, parent.height)/4.5
        height: width
    }
}
