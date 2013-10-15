import QtQuick 2.0
import "templates"

Rectangle {
    id: templatesPanelRect
    width: 110
    height: parent.height
    color: "gray"
    property int templateHeight : 100

    signal templateSelected(var source)

    function selectTemplate(index)
    {
        var position = index*(templateHeight + templatesListView.spacing)
        if ( position > templatesListView.height/2 - templateHeight/2)
            templatesListView.contentY = position - (templatesListView.height/2 - templateHeight/2)
        templatesListView.currentIndex = index
    }

    Component
    {
        id: delegate
        Rectangle{
            width: listViewItem.width
            height: templateHeight
            color: "white"
            Text{
                id: text
                anchors.centerIn: parent
                text: "Template " + (model.index + 1)
            }

            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {
                    selectTemplate(model.index)
                    templateSelected("templates/Template"+ (model.index+1)+".qml")
                }
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
        id: templatesPanelMouseArea
        anchors.fill: parent
        drag.axis: Drag.XAxis
        drag.target: templatesPanelRect
        drag.minimumX: presentation.width - templatesPanelRect.width
        drag.maximumX: presentation.width - 10
        onClicked: {
            templatesPanelRect.state = (templatesPanelRect.state === "closed") ? "opened" : "closed"
        }

    }

    states:[
        State {
            name: "opened"
            PropertyChanges { target: templatesPanelRect; x: templatesPanelMouseArea.drag.minimumX}
        },
        State {
            name: "closed"
            PropertyChanges { target: templatesPanelRect; x: templatesPanelMouseArea.drag.maximumX }
        }]

    Behavior on x { SmoothedAnimation { velocity: 400 } }

    state: "closed"

}
