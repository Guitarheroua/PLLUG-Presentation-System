import QtQuick 2.4

Rectangle {
    id: mainRect
    width: parent.width
    height: parent.height/6
    color: "black"
    opacity: 0.7

    property variant slides: []
    property int time: 2000

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

                    onVisibleChanged: {
                        console.log(slidesListView.currentIndex, " ", index)
                    }

                }
                Rectangle {
                    width: parent.width - 10
                    height: parent.height - 10
                    anchors.centerIn: parent
                    color: "white"
                    clip: true
                    z: parent.z+1
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
                    }
                    Image {
                        id: deleteImage
                        source: "qrc:///icons/delete.png"
                        visible: false
                        height: slideNumberText.width + 8
                        width: slideNumberText.width + 8
                        anchors {
                            top: parent.top
                            left: parent.left
                        }

                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                presentation.removeSlideAt(slidesListView.draggedIndex)
                                deleteImage.opacity = 0.0
                                slidesListView.draggedIndex = -1

                            }
                        }
                    }
                }

                MouseArea {
                    id: delegateMouseArea
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: {
                        slideSelected(model.index)
                    }

                    onPressAndHold: {
                        focus = true
                    }

                    onExited: {
                        focus = false
                    }

                    onFocusChanged: {
                        deleteImage.visible = focus
                    }
                }
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

        ListView {
            id: slidesListView
            anchors.fill: parent

            property int draggedIndex: -1
            property int draggedItemX: -1
            property int itemWidth: parent.width/8

            focus: true
            model: slidesModel
            delegate: listViewDelegate
            spacing: 1
            snapMode: ListView.SnapToItem
            orientation: ListView.Horizontal
            boundsBehavior: ListView.StopAtBounds
            clip: true
        }
    }
}

