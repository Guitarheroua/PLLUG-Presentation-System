import QtQuick 2.0
import QtQuick.Controls 1.0
import Qt.labs.presentation 1.0
import "../"
import "../items/"
import "../presentation"

Item
{
    id: templateItem
    anchors.fill: parent

    //    property real topTitleMargin: parent.topTitleMargin
    //    property real contentWidth: parent.contentWidth
    //    property real titleFontSize: parent.titleFontSize


    Rectangle
    {
        id: titleRect
        width: templateItem.parent.contentWidth
        height: textEdit.height
        anchors
        {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: /*templateItem.parent.topTitleMargin*/20
        }
        color: "transparent"

        border
        {
            color: "lightgrey"
            width: 1
        }

        TextInput
        {
            id: textEdit
            anchors
            {
                centerIn: parent
            }

            text: "Click to add text"
            font.pointSize: templateItem.parent.titleFontSize
            horizontalAlignment: Text.Center
            MouseArea
            {
                anchors.fill: parent
                onClicked: {
                    textEdit.text = (textEdit.text === "Click to add text") ? "" : textEdit.text
                    textEdit.forceActiveFocus()
                    //                    borderImage.visible = false
                }
            }
            onFocusChanged: {
                if (!focus)
                {
                    titleRect.visible = false
                    templateItem.parent.title = textEdit.text
                }
            }
        }
    }
    Component {
        id: highlightBar
        Rectangle {
            width: gridView.currentItem.width + 10;
            height: gridView.currentItem.height + 10
            color: "#FFFF88"
            x: gridView.currentItem.x - 5
            y: gridView.currentItem.y - 5
            //            Behavior on y { SpringAnimation { spring: 2; damping: 0.1 } }

        }
    }

    Component
    {
        id: gridDelegate
        Item{
            id: delegateItem
            property bool selected
            width: 410
            height: 260
            Rectangle {
                id: highlightRect
                //                width: block.width + 10;
                //                height: block.height + 10
                anchors.fill: parent
                color: "lightsteelblue"
                //                x: block.x - 5
                //                y: block.y - 5
                visible: (gridView.currentIndex === index && selected)
                onVisibleChanged:
                {
                    if (!visible)
                        templateItem.parent.editSelectedItemProperties = false
                }

                //            Behavior on y { SpringAnimation { spring: 2; damping: 0.1 } }
            }

            Block{
                id: block
                width: parent.width-10
                height: parent.height-10
                anchors.centerIn: parent
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        gridView.currentIndex = index
                        delegateItem.selected = true
                        templateItem.parent.selectedItem = gridView.currentItem
                    }
                    onPressAndHold:
                    {
                        gridView.currentIndex = index
                        delegateItem.selected = true
                        templateItem.parent.selectedItem = gridView.currentItem
                        templateItem.parent.editSelectedItemProperties = !templateItem.parent.editSelectedItemProperties
                    }
                }
            }
            Component.onCompleted:
            {
                selected = false
            }
//            Behavior on x{SmoothedAnimation{velocity: 400}}
//            Behavior on y{SmoothedAnimation{velocity: 400}}
//            Behavior on width{SmoothedAnimation{velocity: 410}}
//            Behavior on height{SmoothedAnimation{velocity: 260}}
        }

    }





    Rectangle
    {
        id: contentRect
        x: templateItem.parent.contentX
        y: templateItem.parent.contentY
        width: templateItem.parent.contentWidth
        height: templateItem.parent.contentHeight+10
        z: parent.z +1


        GridView{
            id: gridView
            anchors
            {
                fill:  parent
                leftMargin: (parent.width - cellWidth*2)/2
                rightMargin: (parent.width - cellWidth*2)/2
            }
            model: 4
            delegate: gridDelegate
            boundsBehavior: GridView.StopAtBounds
            cellWidth: 410
            cellHeight: 260
            interactive: false
            //            highlight: highlightBar
            //            highlightFollowsCurrentItem: false

        }
    }
}
