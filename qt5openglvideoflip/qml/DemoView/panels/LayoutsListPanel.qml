import QtQuick 2.0

Rectangle {
    id: layoutsPanelRect
    width: 120
    height: parent.height
    color: "#9AC0CD"
    opacity: 0.7

    property int layoutHeight : 100

    signal layoutSelected(var source)

    function selectLayout(index)
    {
        var position = index*(layoutHeight + layoutsListView.spacing)
        if ( position > layoutsListView.height/2 - layoutHeight/2)
            layoutsListView.contentY = position - (layoutsListView.height/2 - layoutHeight/2)
        layoutsListView.currentIndex = index
    }

    Component
    {
        id: delegate
        Rectangle{
            width: listViewItem.width
            height: layoutHeight
            color: "white"
            Text{
                id: text
                anchors.centerIn: parent
                text: (model.index === 0) ? "Empty template": "Layout " + (model.index)
            }

            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {
                    selectLayout(model.index)
                    var source = (model.index === 0) ? "" : "layouts/Layout"+ (model.index)+".qml"
                    layoutSelected(source)
                }
            }


        }
    }


    Component {
        id: highlightBar
        Rectangle {
            width: layoutsListView.currentItem.width + 10;
            height: layoutsListView.currentItem.height + 10
            color: "#FFFF88"
            x: layoutsListView.currentItem.x - 5
            y: layoutsListView.currentItem.y - 5
//            Behavior on y { SpringAnimation { spring: 2; damping: 0.1 } }

        }
    }


    Item
    {
        id: listViewItem
        anchors
        {
            fill: parent
            topMargin: 10
            leftMargin: 15
        }
        z: parent.z+1

        ListView
        {
            id: layoutsListView
            anchors.fill: parent
            focus: true
            model: 8
            delegate: delegate
            highlight: highlightBar
            highlightFollowsCurrentItem: false
            highlightRangeMode: ListView.NoHighlightRange
            spacing: 10
            orientation: ListView.Vertical
            boundsBehavior: ListView.StopAtBounds

            Behavior on contentY { SmoothedAnimation { velocity: 400 } }

//            onCurrentIndexChanged: {
//                var position = currentIndex*(currentItem.width + spacing)
//                if ( position > width/2 - currentItem.width/2)
//                    contentX = position - (width/2 - currentItem.width/2)
//            }

        }
    }
    MouseArea
    {
        id: layoutsPanelMouseArea
        anchors.fill: parent
        drag.axis: Drag.XAxis
        drag.target: layoutsPanelRect
        drag.minimumX: presentation.width - layoutsPanelRect.width
        drag.maximumX: presentation.width - 10
        onClicked: {
            layoutsPanelRect.state = (layoutsPanelRect.state === "closed") ? "opened" : "closed"
            slidesListPanel.state = "closed"
        }

    }

    states:[
        State {
            name: "opened"
            PropertyChanges { target: layoutsPanelRect; x: layoutsPanelMouseArea.drag.minimumX}
            PropertyChanges { target: slidesListPanel; state: "closed"}
            PropertyChanges { target: optionsPanel; state: "closed"}
        },
        State {
            name: "closed"
            PropertyChanges { target: layoutsPanelRect; x: layoutsPanelMouseArea.drag.maximumX }
        }]

    Behavior on x { SmoothedAnimation { velocity: 400 } }

    state: "closed"

}
