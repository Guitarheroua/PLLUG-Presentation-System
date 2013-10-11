import QtQuick 2.0

Rectangle {
    id: mainRect
    width: parent.width
    height: 110
    color: "gray"

    property variant slides: []

    signal slideSelected(var index)

    onSlidesChanged:
    {
        updateModel()
    }

    function updateModel()
    {
        console.log("update model")
        for (var i=0; i< slides.length; ++i)
        {
            slidesModel.append({"index":i, "title":slides[i].title})
        }
    }

    function selectSlide(index)
    {
        slidesListView.currentIndex = index
    }

    ListModel
    {
        id: slidesModel

    }

    Component
    {
        id: delegate
        Rectangle{
            width: 150
            height: listViewItem.height
            color: "white"
            Text{
                id: text
                anchors.centerIn: parent
                text: slides[model.index].title
            }
            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    slidesListView.currentIndex = index
                    slideSelected(model.index)
                    mainRect.state = "closed"
                }
            }


        }
    }

    Component {
        id: highlightBar
        Rectangle {
            width: slidesListView.currentItem.width + 10;
            height: slidesListView.currentItem.height + 10
            color: "#FFFF88"
            x: slidesListView.currentItem.x - 5
            y: slidesListView.currentItem.y - 5
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
            id: slidesListView
            anchors.fill: parent
            focus: true
            model: slidesModel
            delegate: delegate
            highlight: highlightBar
            highlightFollowsCurrentItem: false
            spacing: 10
            orientation: ListView.Horizontal
        }
    }

    MouseArea
    {
        id: mouseArea
        anchors.fill: parent
        drag.axis: Drag.YAxis
        drag.target: mainRect
        drag.minimumY: parent.parent.height - mainRect.height
        drag.maximumY: parent.parent.height - 10
        onClicked: {
            mainRect.state = (optionsSlideRect.state === "closed") ? "opened" : "closed"
        }

    }

    states:[
        State {
            name: "opened"
            PropertyChanges { target: mainRect; y: mouseArea.drag.minimumY}
        },
        State {
            name: "closed"
            PropertyChanges { target: mainRect; y: mouseArea.drag.maximumY }
        }]

    Behavior on y { SmoothedAnimation { velocity: 400 } }

    state: "closed"
}
