import QtQuick 2.0
import "../"

Item
{
    id: templateItem
    anchors.fill: parent

    Rectangle
    {
        id: contentRect
        x: templateItem.parent.contentX
        y: templateItem.parent.contentY
        width: templateItem.parent.contentWidth
        height: templateItem.parent.contentHeight
        z: parent.z + 1

        Item
        {
            id: blockItem
            width: parent.width
            height: parent.height
            property bool selected
            Rectangle
            {
                id: highlightRect
                anchors.fill: parent
                color: "lightsteelblue"
                visible: blockItem.selected
                antialiasing: true
                onVisibleChanged:
                {
                    if (!visible)
                        templateItem.parent.editSelectedItemProperties = false
                }
            }
            //            Behavior on y { SpringAnimation { spring: 2; damping: 0.1 } }

            Block{
                id: block
                width: parent.width - 10
                height:  parent.height - 10
                anchors.centerIn: parent

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        blockItem.selected = !blockItem.selected
                        templateItem.parent.selectedItem = (block.contentItem.textItem) ? block.contentItem : blockItem

                    }
                    onPressAndHold:
                    {
                        console.log("QQQQQQ")
                        blockItem.selected = true
                        templateItem.parent.selectedItem =  (block.contentItem.textItem) ? block.contentItem : blockItem
                        templateItem.parent.editSelectedItemProperties = !templateItem.parent.editSelectedItemProperties
                    }
                }


            }
            Component.onCompleted:
            {
                selected = false
            }
        }
    }
    MouseArea
    {
        anchors.fill: parent
        onClicked:
        {
            templateItem.forceActiveFocus()
            blockItem.selected = false
        }
    }

    focus: true
    Keys.onEnterPressed:
    {
        console.log("@@@@@@")
    }
    Keys.onPressed:
    {
        if (event.key === 16777220) // enter
        {
            console.log("ENTER")
            blockItem.selected = false
            templateItem.forceActiveFocus()
        }
    }
    Component.onCompleted:
    {
        templateItem.parent.title = "Click to add title"
    }
}

