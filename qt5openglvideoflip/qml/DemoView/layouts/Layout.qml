import QtQuick 2.0
import "../"
import "../items/"

Item
{
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

    Component
    {
        id: gridDelegate
        Rectangle{
            id: delegateItem
            property bool selected
            property int itemIndex: index
            width: gridView.cellWidth
            height:  itemHeight()
            objectName: "delegate"
            function itemHeight()
            {
                if (gridView.currentItem.children[1].contentItem && gridView.currentItem.children[1].contentItem.type === "text")
                {
                    console.log(gridView.currentItem.children[1].contentItem.textItem.height, gridView.cellHeight)
                    if ( gridView.currentItem.children[1].contentItem.textItem.height > gridView.cellHeight)
                    {
                        return gridView.currentItem.children[1].contentItem.textItem.height*1.3
                    }
                }
                return gridView.cellHeight
            }

            Rectangle {
                id: highlightRect
                //                width: block.width + 10;
                //                height: block.height + 10
                anchors.fill: parent
                color: "lightsteelblue"
                visible: (gridView.currentIndex === index && selected)
                onVisibleChanged:
                {
                    if (!visible && templateItem.parent)
                        templateItem.parent.editSelectedItemProperties = false
                }

                //            Behavior on y { SpringAnimation { spring: 2; damping: 0.1 } }
            }

            Block
            {
                id: block
                width: parent.width-10
                height: parent.height-10
                anchors.centerIn: parent
                enableEdit: (templateItem.parent) ? templateItem.parent.enableEdit : false
                MouseArea{
                    anchors.fill: parent
                    enabled: block.enableEdit
                    onClicked: {
                        gridView.currentIndex = index
                        delegateItem.selected = !delegateItem.selected
                        templateItem.parent.selectedItem = gridView.currentItem.children[1].contentItem
                    }
                    onPressAndHold:
                    {
                        gridView.currentIndex = index
                        delegateItem.selected = true
                        templateItem.parent.selectedItem = gridView.currentItem.children[1].contentItem
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
        id: layoutContentItem
        x: (templateItem.parent) ? templateItem.parent.contentX : 0
        y: (templateItem.parent) ? templateItem.parent.contentY : 0
        width: (templateItem.parent) ? templateItem.parent.contentWidth : 0
        height: (templateItem.parent) ? templateItem.parent.contentHeight+10 : 0
        z: parent.z + 1

        GridView{
            id: gridView
            objectName: "blocksView"
            function getItem(i)
            {
                    positionViewAtIndex(i, GridView.Visible)
                    return getDelegateInstanceAt(i);
            }

            anchors
            {
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

            function getDelegateInstanceAt(index) {
                        for(var i = 0; i < contentItem.children.length; ++i) {
                            var item = contentItem.children[i];
                            // We have to check for the specific objectName we gave our
                            // delegates above, since we also get some items that are not
                            // our delegates here.
                            if (item.objectName === "delegate" && item.itemIndex === index)
                                return item;
                        }
                        return undefined;
                    }

        }
    }

}



