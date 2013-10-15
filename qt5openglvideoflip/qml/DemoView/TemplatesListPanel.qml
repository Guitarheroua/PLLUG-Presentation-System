import QtQuick 2.0
import "templates"

Rectangle {
    id: mainRect
    width: 110
    height: parent.height
    color: "gray"

    Component
    {
        id: delegate
        Rectangle{
            width: listViewItem.width
            height: 150
            color: "white"
            Loader
            {
                source: "templates/Template"+ (model.index+1)+".qml"
            }

            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
//                onClicked: {
//                    slideSelected(model.index)
//                }
            }


        }
    }


    Component {
        id: highlightBar
        Rectangle {
            width: templatesListView.currentItem.width + 10;
            height: templatesListView.currentItem.height + 10
            color: "#FFFF88"
            x: templatesListView.currentItem.x - 5
            y: templatesListView.currentItem.y - 5
            Behavior on y { SpringAnimation { spring: 2; damping: 0.1 } }

        }
    }


    Item
    {
        id: listViewItem
        anchors
        {
            fill: parent
            topMargin: 10
            leftMargin: 10
        }
        z: parent.z+1

        ListView
        {
            id: templatesListView
            anchors.fill: parent
            focus: true
            model: 7
            delegate: delegate
            highlight: highlightBar
            highlightFollowsCurrentItem: false
            spacing: 10
            orientation: ListView.Vertical
            boundsBehavior: ListView.StopAtBounds
            Behavior on contentX { SmoothedAnimation { velocity: 400 } }

            onCurrentIndexChanged: {
                var position = currentIndex*(currentItem.width + spacing)
                if ( position > width/2 - currentItem.width/2)
                    contentX = position - (width/2 - currentItem.width/2)
            }
        }
    }

}
