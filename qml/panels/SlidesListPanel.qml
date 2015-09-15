import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQml.Models 2.2

Rectangle {
    id: mainRect
    width: parent.width
    height: parent.height/6
    opacity: 0.7
    color: "black"

    property var slides
    property var swapp

    signal slideSelected(var index)

    function selectSlide(index) {
        slidesListView.currentIndex = index;
        slideSelected(index);
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

    Component {
        id: listViewDelegate

        Item {
            id: delegateItem

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
                    visualModel.items.move(drag.source.visualIndex, delegateItem.visualIndex);
                    swapp = slides[drag.source.visualIndex];
                    slides[drag.source.visualIndex] = slides[delegateItem.visualIndex];
                    slides[delegateItem.visualIndex] = swapp;
                    selectSlide(delegateItem.visualIndex);
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
                        visible: slidesListView.currentIndex == index
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
                            text: model.additionalContent["text"]
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
                                    deleteImage.opacity = 0.0
                                    slidesListView.draggedIndex = -1
                                    slides.remove(slidesListView.currentIndex);
                                }
                            }
                        }
                    }

                    MouseArea {
                        id: delegateMouseArea

                        property int selectedSlideMemo: -1

                        anchors.fill: parent
                        hoverEnabled: true
                        drag.target: delegateRow
                        drag.axis: Drag.XAxis

                        onPressed: {
                            selectSlide(index);
                        }

                        onPressAndHold: {
                            focus = true
                        }

                        onExited: {
                            focus = false
                        }

                        onFocusChanged: {
                            deleteImage.visible = focus
                            slidesListView.draggedIndex = index
                        }

                        drag.onActiveChanged: {
                            if (delegateMouseArea.drag.active) {
                                slidesListView.draggedItemIndex = index;
                                slideSelected(model.index)
                                //  console.log(model.)
                            } else {
                                selectedSlideMemo = model.index
                                slideSelected(selectedSlideMemo)
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
                            selectSlide(index);
                            //presentation.addNewSlide()
                            slides.append();
                            slides.getChild(index + 1).setAdditionalContent("text", index + 1);
                        }
                    }
                }

                Drag.active: delegateMouseArea.drag.active
                Drag.source: delegateItem
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

        model: slides
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
            property int draggedIndex: -1

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

            onCurrentIndexChanged: {
                slideSelected(currentIndex);
            }
        }
    }
}


