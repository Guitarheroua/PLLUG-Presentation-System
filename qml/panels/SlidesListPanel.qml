import QtQuick 2.4

Rectangle {
    id: mainRect
    width: parent.width
    height: parent.height/6
    color: "black"
    opacity: 0.7
    property variant slides: []
    signal slideSelected(var index)

    function updateModel() {
        slidesModel.clear()
        for (var i=0; i< slides.length; ++i) {
            slidesModel.append({"index":i, "title":slides[i].title})
        }
    }
    function selectSlide(index) {
        var position = index*(slidesListView.itemWidth + 10)
        slidesListView.currentIndex = index
        if ( position > (slidesListView.width - addItem.width)/2 - slidesListView.itemWidth/2)
            slidesListView.contentX = position - ((slidesListView.width - addItem.width)/2 - slidesListView.itemWidth/2)
    }
    onSlidesChanged: {
        updateModel()
    }

    ListModel {
        id: slidesModel
    }

    Component {
        id: listViewDelegate

        Row {
            height: listViewItem.height
            width: delegateRect.width + addSlideDivider.width

            Item {
                id: delegateRect
                width: slidesListView.itemWidth + 10
                height: listViewItem.height

                Rectangle {

                    id: hightlightRect
                    width: parent.width
                    height: parent.height
                    color: "steelblue"
                    visible: slidesListView.currentIndex === index
                    //Behavior on y { SpringAnimation { spring: 2; damping: 0.1 } }

                }
                Rectangle {
                    width: parent.width -10
                    height: parent.height - 10
                    anchors.centerIn: parent
                    color: "white"
                    clip: true
                    z: parent.z+1
                    //opacity: (slidesListView.currentIndex === model.index) ? 1.0 : 0.8
                    Text {
                        id: text
                        anchors.centerIn: parent
                        text: (slides[model.index] !== undefined)? slides[model.index].title : ""
                    }
                    Rectangle {
                        id: slideNumberRect
                        color: "steelblue"
                        width: slideNumberText.width + 8
                        height: slideNumberText.height + 5
                        anchors {
                            top: parent.top
                            right: parent.right
                        }
                        Text {
                            id: slideNumberText
                            anchors.centerIn: parent
                            text: model.index + 1
                            color: "white"
                            font.pointSize: 9

                        }
                        z: parent.z + 1
                        //                    MouseArea  {
                        //                        anchors.fill: parent
                        //                        hoverEnabled: true
                        //                                            onEntered:
                        //                                            {
                        //                                                slideNumberRect.opacity = 0.7
                        //                                            }
                        //                                            onExited:
                        //                                            {
                        //                                                slideNumberRect.opacity = 1.0
                        //                                            }
                        //                    }
                        //                    Behavior on opacity { SmoothedAnimation{ velocity : 200}}
                    }
                }
                states:[
                    State{
                        when: delegateMouseArea.drag.active
                        name: "dragging"
                    },
                    State {
                        when: !delegateMouseArea.drag.active
                        name: "default"
                    }
                ]
                onStateChanged: {
                    if (state === "dragging") {
                        slidesListView.draggedIndex = index
                        slidesListView.draggedItemX = parent.x
                    }
                }

                state: "default"

                onYChanged: {
                    if (slidesListView.draggedIndex === model.index ) {
                        deleteImage.opacity = y/(parent.height+5)
                    }
                }
                PropertyAnimation {
                    id: downAnimation
                    target: delegateRect
                    property: "y"
                    to: delegateRect.height+5
                    duration: 700 //1000

                }
                PropertyAnimation {
                    id: upAnimation
                    target: delegateRect
                    property: "y"
                    to: 0
                    duration: 700 //1000
                    onRunningChanged: {
                        slidesListView.draggedIndex = (!running)? -1 : slidesListView.draggedIndex
                    }

                }

                MouseArea {
                    id: delegateMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    drag.axis: Drag.YAxis
                    //              drag.maximumY:  listViewItem.height
                    drag.minimumY: 0
                    drag.target: ( (slidesListView.draggedIndex === -1) ||
                                  (slidesListView.draggedIndex === model.index)) ? parent : null

                    onClicked: {
                        slideSelected(model.index)
                    }
                    onPressed: {
                        //   var lx = mapToItem(slidesListView,mouseX,mouseY).x
                        //   var ly = mapToItem(slidesListView,mouseX,mouseY).y
                        //   drag.target = slidesListView.itemAt(lx,ly)
                    }

                    onReleased: {
                        if (parent.y > parent.height/2 )  {
                            downAnimation.from = parent.y
                            downAnimation.start()
                            //   y = parent.height+5
                            //   presentation.removeSlideAt(model.index)
                        }
                        else {
                            upAnimation.from = parent.y
                            upAnimation.to = 0
                            upAnimation.start()
                        }

                        //                    var ax = mapToItem(slidesListView,mouseX,mouseY).x
                        //                    var ay = mapToItem(slidesListView,mouseX,mouseY).y
                        //                    slidesModel.move(slidesListView.draggedIndex, slidesListView.indexAt(ax,listViewItem.y),1)
                    }
                    onPressAndHold: {
                        optionsPanel.state = (optionsPanel.state != "SlideProperties") ? "SlideProperties" : "Closed"
                    }
                }
                //            Behavior on y { SpringAnimation { spring: 2; damping: 0.1 } }
            }
            Item {
                id: addSlideDivider

                width: 15
                height: listViewItem.height

                Rectangle {
                    id: divider

                    width: 3
                    height: listViewItem.height
                    color: "steelblue"
                    anchors.centerIn: parent
                    visible: false

                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    onEntered: {
                        divider.visible = true
                    }
                    onExited: {
                        divider.visible = false
                    }
                    onDoubleClicked: {
                        slideSelected(model.index)
                        presentation.addNewSlide()
                    }
                }
            }
        }
    }

    //NOTE: where it is used?
    Component {
        id: highlightBar
        Item {
            Rectangle {
                width: slidesListView.currentItem.width + 10;
                height: slidesListView.currentItem.height + 10
                color: "steelblue"
                x: slidesListView.currentItem.x - 5
                y: slidesListView.currentItem.y - 5
            }
        }
    }


    Rectangle {
        id: addItem
        anchors {
            top: parent.top
            left: parent.left
            bottom: parent.bottom
            topMargin: 15
            leftMargin: 10
            bottomMargin: 2
        }
        width: 50
        z: listViewItem.z+1
        opacity: parent.opacity
        color: "steelblue"
        clip: true
        Text {
            text: qsTr("Add")
            anchors.centerIn: parent
            color: "white"
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                presentation.addNewSlide()
            }
        }

    }

    Item {
        id: arrowItem
        anchors {
            top: parent.top
            topMargin: 3
            horizontalCenter: parent.horizontalCenter
        }

        Column {
            spacing: 2
            Repeater {
                model: 2
                Rectangle {
                    width: 30
                    height: 3
                    color: "steelblue"
                    radius: 3
                }
            }
        }
    }

    Item {
        id: listViewItem
        anchors  {
            top: parent.top
            left: addItem.right
            bottom: parent.bottom
            right: parent.right
            topMargin: 12
            leftMargin: 10
            bottomMargin: 5
        }
        z: parent.z+1

        Item {
            id: deleteImageItem
            anchors.fill: parent
            anchors.topMargin: 5
            z: deleteImage.z
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    var lx = mapToItem(slidesListView,mouseX,mouseY).x
                    var ly = mapToItem(slidesListView,mouseX,mouseY).y
                    slidesListView.itemAt(lx,ly+100).y = 0
                    deleteImage.opacity = 0.0
                    slidesListView.draggedIndex = -1

                }
            }
            Image {
                id: deleteImage
                source: "qrc:///icons/delete.png"
                x: (slidesListView.draggedItemX + slidesListView.itemWidth) - width
                opacity: 0.0
                z : (opacity === 1.0) ? listViewItem.z+2 : 0
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        presentation.removeSlideAt(slidesListView.draggedIndex)
                        //console.log(slidesListView.draggedItemX)
                        deleteImage.opacity = 0.0
                        slidesListView.draggedIndex = -1
                    }
                }
                Behavior on opacity { SmoothedAnimation{ velocity : 200}}
            }
        }

        //NOTE: ?
        Timer {
            id: deletingTimer
            interval: 50 //5000
        }

        ListView {
            id: slidesListView
            anchors {
                fill: parent
            }
            property int draggedIndex: -1
            property int draggedItemX: -1
            property int itemWidth: parent.width/8

            focus: true
            model: slidesModel
            delegate: listViewDelegate
            //            highlight: highlightBar
            //            highlightFollowsCurrentItem: false
            spacing: 1
            snapMode: ListView.SnapToItem
            orientation: ListView.Horizontal
            boundsBehavior: ListView.StopAtBounds
            clip: true

            Behavior on contentX { SmoothedAnimation { velocity: 400 } }

            //                        onCurrentIndexChanged: {
            //                            var position = currentIndex*(currentItem.width + spacing)
            //                            if ( position > width/2 - currentItem.width/2)
            //                                contentX = position - (width/2 - currentItem.width/2)
            //                        }
        }
    }

    MouseArea  {
        id: mouseArea
        anchors.fill: parent
        //        drag.axis: Drag.YAxis
        //        drag.target: mainRect
        //        drag.minimumY: parent.parent.height - mainRect.height
        //        drag.maximumY: parent.parent.height - 12
        //        onClicked: {
        //            mainRect.state = (mainRect.state === "closed") ? "opened" : "closed"
        //        }
        //        onReleased: {
        //            if ( mainRect.y >= (drag.maximumY - mainRect.height/2 + 20) ) {
        //                mainRect.y = drag.maximumY
        //                mainRect.state = "closed"
        //            }
        //            else {
        //                mainRect.y = drag.minimumY
        //                mainRect.state = "opened"
        //            }
        //        }
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


    //Behavior on y { SmoothedAnimation { velocity: 200 } }

    state: "closed"
}
