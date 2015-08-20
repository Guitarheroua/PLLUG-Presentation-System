import QtQuick 2.4
import "../"
import "../items/"

Item
{
    id: templateItem
    anchors.fill: parent


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
            width: contentItem.width/2.5
            height: (index === 1)? contentItem.height : contentItem.height/2
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
                    enabled: !mainRect.presmode
                    onClicked: {
                        gridView.currentIndex = index
                        delegateItem.selected = !delegateItem.selected
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


    Item
    {
        id: contentItem
        x: templateItem.parent.contentX
        y: templateItem.parent.contentY
        width: templateItem.parent.contentWidth
        height: templateItem.parent.contentHeight+10
        z: parent.z + 1

        GridView{
            id: gridView
            objectName: "blocksView"
            anchors
            {
                fill:  parent
                leftMargin: (parent.width - cellWidth*2)/2
                rightMargin: (parent.width - cellWidth*2)/2
            }
            model: 3
            delegate: gridDelegate
            boundsBehavior: GridView.StopAtBounds
            cellWidth: contentItem.width/2.5
            cellHeight: contentItem.height/2
            interactive: false
            //            highlight: highlightBar
            //            highlightFollowsCurrentItem: false

        }
    }

}
