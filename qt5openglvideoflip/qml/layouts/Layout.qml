import QtQuick 2.4
import "../"
import "../items/"

Item {
    id: templateItem
    anchors.fill: parent
    property int itemWidth
    property int itemHeight
    property int itemsCount
    property int columnsCount

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

    Component {
        id: gridDelegate
        Item{
            id: delegateItem
            property bool selected
            property int itemIndex: index
            width: gridView.cellWidth
            height:  itemHeight()
            objectName: "delegate"
            function itemHeight() {
                if (gridView.currentItem.children[1].contentItem
                        && gridView.currentItem.children[1].contentItem.type === "text") {
                    if ( gridView.currentItem.children[1].contentItem.textItem.height >
                            gridView.cellHeight) {
                        return gridView.currentItem.children[1].contentItem.textItem.height*1.3
                    }
                }
                return gridView.cellHeight
            }

            Rectangle {
                id: highlightRect
                anchors.fill: parent
                color: "lightsteelblue"
                visible: (gridView.currentIndex === index && selected)
                onVisibleChanged: {
                    if (!visible && templateItem.parent)
                        templateItem.parent.editSelectedItemProperties = false
                }

                //            Behavior on y { SpringAnimation { spring: 2; damping: 0.1 } }
            }

            Block {
                id: block
                width: parent.width-10
                height: parent.height-10
                anchors.centerIn: parent
                MouseArea{
                    anchors.fill: parent
                    enabled: helper.enableEdit()
                    onClicked: {
                        gridView.currentIndex = index
                        delegateItem.selected = !delegateItem.selected
                        templateItem.parent.selectedItem = gridView.currentItem.children[1].contentItem
                    }
                    onPressAndHold: {
                        gridView.currentIndex = index
                        delegateItem.selected = true
                        templateItem.parent.selectedItem = gridView.currentItem.children[1].contentItem
                        templateItem.parent.editSelectedItemProperties = !templateItem.parent.editSelectedItemProperties
                    }
                }
            }
            Component.onCompleted: {
                selected = false
            }
            //            Behavior on x{SmoothedAnimation{velocity: 400}}
            //            Behavior on y{SmoothedAnimation{velocity: 400}}
            //            Behavior on width{SmoothedAnimation{velocity: 410}}
            //            Behavior on height{SmoothedAnimation{velocity: 260}}
        }
    }

    Item {
        id: layoutContentItem
        x: (templateItem.parent) ? templateItem.parent.contentX : 0
        y: (templateItem.parent) ? templateItem.parent.contentY : 0
        width: (templateItem.parent) ? templateItem.parent.contentWidth : 0
        height: (templateItem.parent) ? templateItem.parent.contentHeight+10 : 0
        z: parent.z + 1

        GridView {
            id: gridView
            objectName: "blocksView"
            anchors {
                fill:  parent
                leftMargin: (parent.width - cellWidth*columnsCount)/2
                rightMargin: (parent.width - cellWidth*columnsCount)/2
            }
            model: itemsCount
            delegate: gridDelegate
            boundsBehavior: GridView.StopAtBounds
            cellWidth: itemWidth
            cellHeight: itemHeight
            interactive: false
            //            highlight: highlightBar
            //            highlightFollowsCurrentItem: false
            function getItem(i) {
                positionViewAtIndex(i, GridView.Visible)
                return getDelegateInstanceAt(i)
            }
            function getDelegateInstanceAt(index) {
                for(var i = 0; i < contentItem.children.length; ++i) {
                    var item = contentItem.children[i]
                    if (item.objectName === "delegate" && item.itemIndex === index) {
                        return item
                    }
                }
                return undefined
            }

        }


    }

}



