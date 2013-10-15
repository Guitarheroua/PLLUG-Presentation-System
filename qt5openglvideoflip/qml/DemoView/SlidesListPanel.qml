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
        slidesModel.clear()
        for (var i=0; i< slides.length; ++i)
        {
            slidesModel.append({"index":i, "title":slides[i].title})
        }
    }

    function selectSlide(index)
    {
        var position = index*(150 + slidesListView.spacing)
        if ( position > slidesListView.width/2 - 150/2)
            slidesListView.contentX = position - (slidesListView.width/2 - 150/2)
        slidesListView.currentIndex = index
    }

    ListModel
    {
        id: slidesModel

    }

    Component
    {
        id: listViewDelegate
        Rectangle{
            width: 150
            height: listViewItem.height
            color: "white"
            Text{
                id: text
                anchors.centerIn: parent
                text: (slides[model.index] != undefined)? slides[model.index].title : ""
            }
//            Image{
//                id: trashImage
//                anchors.top: parent.top
//                anchors.right: parent.right
//                source: "qrc:///icons/trash.png"
//                z: parent.z + 1
//                opacity: 0.0
//                MouseArea{
//                    anchors.fill: parent
//                    hoverEnabled: true
//                    onClicked: {
//                        presentation.removeSlideAt(model.index)
//                    }
//                    onEntered:
//                    {
//                        trashImage.opacity = 0.7
//                    }
//                    onExited:
//                    {
//                        trashImage.opacity = 0.0
//                    }
//                }
//                Behavior on opacity { SmoothedAnimation{ velocity : 200}}
//            }

            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
                drag.axis: Drag.YAxis
                drag.minimumY:  0
//                drag.maximumY:  listViewItem.height
                drag.minimumX: 0
                onClicked: {
                    slideSelected(model.index)
                }
                onPressed:
                {
                    var lx = mapToItem(slidesListView,mouseX,mouseY).x
                    var ly = mapToItem(slidesListView,mouseX,mouseY).y
                    drag.target = slidesListView.itemAt(lx,ly)
//                    slidesListView.draggedIndex = model.index
                }
                onReleased:
                {
//                    var ax = mapToItem(slidesListView,mouseX,mouseY).x
//                    var ay = mapToItem(slidesListView,mouseX,mouseY).y
//                    console.log(slidesListView.indexAt(ax,ay),ax,ay)
//                    slidesModel.move(slidesListView.draggedIndex, slidesListView.indexAt(ax,listViewItem.y),1)
                }
            }
//            Behavior on y { SpringAnimation { spring: 2; damping: 0.1 } }
            onYChanged:
            {
                if (y > (mainRect.height - 20))
                    presentation.removeSlideAt(model.index)
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
            bottomMargin: 10
        }
        z: parent.z+1

        ListView
        {
            id: slidesListView
            anchors.fill: parent
            focus: true
            model: slidesModel
            delegate: listViewDelegate
            highlight: highlightBar
            highlightFollowsCurrentItem: false
            spacing: 10
            orientation: ListView.Horizontal
            boundsBehavior: ListView.StopAtBounds
            Behavior on contentX { SmoothedAnimation { velocity: 400 } }

//            property int draggedIndex: -1

//            onCurrentIndexChanged: {
//                var position = currentIndex*(currentItem.width + spacing)
//                if ( position > width/2 - currentItem.width/2)
//                    contentX = position - (width/2 - currentItem.width/2)
//            }
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
            mainRect.state = (mainRect.state === "closed") ? "opened" : "closed"
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
