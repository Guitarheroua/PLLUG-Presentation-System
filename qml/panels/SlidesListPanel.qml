import QtQuick 2.4
import QtQuick.Controls 1.4
import QtQml.Models 2.1

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
    }

    onSlidesChanged: {
        updateModel()
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

    ListModel {
        id: slidesModel
    }

    Component {
        id: listViewDelegate

        Item {
            id: aaa

            property int visualIndex: DelegateModel.itemsIndex

            height: listViewItem.height
            width: delegateRect.width + addSlideDivider.width

            DropArea {
                anchors {
                    fill: parent
                    leftMargin: 10
                    rightMargin: 25
                }

                onEntered: {
                    visualModel.items.move(drag.source.visualIndex, aaa.visualIndex)
                }
            }

            Row {
                id: delegateRow
                height: listViewItem.height
                width: delegateRect.width + addSlideDivider.width

                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }

                transitions: Transition {
                    AnchorAnimation { easing.type: Easing.OutQuad }
                }

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
                        drag.target: delegateRow
                        drag.axis: Drag.XAxis

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

                        drag.onActiveChanged: {
                            if (delegateMouseArea.drag.active) {
                                slidesListView.draggedItemIndex = index;
                            }
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

                Drag.active: delegateMouseArea.drag.active
                Drag.source: aaa//delegateRow
                Drag.hotSpot.x: (delegateRect.width + addSlideDivider.width) / 2
                Drag.hotSpot.y: delegateRect.height / 2

                states: [
                    State {
                        when: delegateRow.Drag.active
                        AnchorChanges {
                            target: delegateRow;
                            anchors.horizontalCenter: undefined;
                            anchors.verticalCenter: undefined;
                        }
                    }
                ]
            }
        }
    }

    DelegateModel {
        id: visualModel

        model: slidesModel
        delegate: listViewDelegate
    }

    Item {
        id: listViewItem

        anchors  {
            top: parent.top
            left: parent.left
            bottom: parent.bottom
            right: parent.right
            topMargin: 12
            leftMargin: 10
            bottomMargin: 5
        }
        z: parent.z+1

        ListView {
            id: slidesListView

            property int itemWidth: parent.width/8
            property int draggedItemIndex: -1

            interactive: false

            //drag and drop contatiner
            Item {
                id: dndContainer
                anchors.fill: parent
            }

            displaced: Transition {
                NumberAnimation { properties: "x,y"; easing.type: Easing.OutQuad }
            }

            anchors.fill: parent
            focus: true

            model: visualModel

            spacing: 1
            snapMode: ListView.SnapToItem
            orientation: ListView.Horizontal
            boundsBehavior: ListView.StopAtBounds
            clip: true
        }
    }
}


