import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Dialogs 1.0
import "../components/ColorPicker"

Rectangle{
    id: optionsPanelRect
    width: 320
    height: parent.height
    color: "black"
    opacity: 0.7
    z: parent.z + 2
    property var selectedItem : presentation.slides[currentSlide].selectedItem
    property bool itemEditing: presentation.slides[presentation.currentSlide].editSelectedItemProperties
    property bool slideProperties: false
    property bool itemProperties: false
    onItemEditingChanged:
    {
        if(!itemEditing && state === "ItemProperties")
            state = "Closed"
    }
    onSelectedItemChanged:
    {
        console.log("current item", selectedItem)
        //        widthTextInput.text = (selectedItem != null) ? Math.round(selectedItem.width) : 0
        //        heightTextInput.text = (selectedItem != null) ? Math.round(selectedItem.height) : 0
        //        xTextInput.text = (selectedItem != null) ? Math.round(selectedItem.x) : 0
        //        yTextInput.text = (selectedItem != null) ? Math.round(selectedItem.y) : 0
        //        zTextInput.text = (selectedItem != null) ? Math.round(selectedItem.z) : 0
    }

    ListModel
    {
        id: slideOptionsModel

        ListElement {
            name: "Background"
            contents: [
                ListElement {
                    name: "Swirls"
                    value: "background/BackgroundSwirls.qml"
                },
                ListElement {
                    name: "Fire"
                    value: "background/FireEffect.qml"
                },
                ListElement {
                    name: "Underwater"
                    value: "background/UnderwaterEffect.qml"
                }
            ]
        }
        ListElement {
            name: "Transitions"
            contents: [
                ListElement {
                    name: "Flipping page"
                    value: "PageFlipShaderEffect.qml"
                }

            ]
        }

    }

    //    Component.onCompleted:
    //    {
    //        console.log("\ncount", slideOptionsModel.count)
    //        for(var i=0; i<textPropertiesModel.count; ++i)
    //        {
    //            slideOptionsModel.append(textPropertiesModel.get(i))
    //            slideOptionsModel.get(slideOptionsModel.count-1).contents = textPropertiesModel.get(i).contents
    //        }
    //    }


    Component
    {
        id: optionsListViewDelegate
        Rectangle
        {
            id: rect
            width: listViewItem.width
            height: delegateItemText.height+lineRect.height
            color: "transparent"
            property int ind: model.index
            property int subItemHeight: 25
            Text {
                id: delegateItemText
                text: model.name
                //                color: "lightsteelblue"
                color: "white"
                font
                {
                    pointSize: 14
                    bold: false
                }
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    subItemsRect.visible = !subItemsRect.visible
                    rect.height = (subItemsRect.visible) ? rect.height + slideOptionsModel.get(rect.ind).contents.count*subItemHeight + 10 : delegateItemText.height+lineRect.height
                }
            }

            Rectangle
            {
                id: lineRect
                anchors
                {
                    top: delegateItemText.bottom
                    left: parent.left
                }
                width: parent.width
                height: 3
                color: "steelblue"
            }
            Item{
                id: subItemsRect
                anchors
                {
                    top: lineRect.bottom
                    left: parent.left
                }
                visible: false
                Column{
                    anchors.fill: parent
                    spacing: 2
                    Repeater
                    {
                        model: slideOptionsModel.get(rect.ind).contents
                        Rectangle
                        {
                            id: rect1
                            width: rect.width
                            height: subItemHeight
                            color: "grey"
                            property color unselectedItemColor: "grey"
                            property bool selected: false
                            Text
                            {
                                text: model.name
                                anchors.centerIn: parent
                                font.pointSize: 10
                                color: "white"
                            }
                            MouseArea
                            {
                                anchors.fill: parent
                                onClicked:
                                {
                                    rect1.selected = !rect1.selected
                                    rect1.color = (rect1.selected ) ? Qt.darker(rect1.color, 1.5) : unselectedItemColor
                                    if (slideOptionsModel.get(rect.ind).name === "Background")
                                    {
                                        if(rect1.selected)
                                        {
                                            presentation.addBackground(model.value)
                                        }
                                        else
                                        {
                                            presentation.removeBackground(model.value)
                                        }
                                    }
                                    else if (slideOptionsModel.get(rect.ind).name === "Transitions")
                                    {
                                        if(rect1.selected)
                                        {
                                            presentation.addTransition(model.value)
                                        }
                                        else
                                        {
                                            presentation.removeTransition()
                                        }
                                    }

                                    optionsPanelRect.state = "Closed"
                                }
                                //                                onPressed:
                                //                                {
                                //                                    rect1.color = Qt.darker(rect1.color, 0.25);
                                //                                }
                                //                                onReleased:
                                //                                {
                                //                                    rect1.color = Qt.lighter(rect1.color, 0.25);
                                //                                }
                            }
                        }
                    }
                }


            }

        }

    }

    Column{
        anchors.fill: parent
        anchors.leftMargin: 5
        z: parent.z+1
        Item{
            id: listViewItem
            visible: slideProperties

            //                    anchors
            //                    {
            //                        fill: parent
            //                        margins: 5
            ////                        bottomMargin: 400
            //                    }
            width: parent.width
            height: 150
            z: parent.z+1
            ListView{
                id: optionsListView
                anchors.fill: parent
                model: slideOptionsModel
                delegate: optionsListViewDelegate
                //            z: parent.z+1

            }

        }

        PositionMenu
        {
            visible: itemProperties
            selectedItem: optionsPanelRect.selectedItem
            z: parent.z+1
        }

        SizeMenu
        {
            visible: itemProperties
            selectedItem: optionsPanelRect.selectedItem
            z: parent.z+1
        }

        TextMenu
        {
            visible: ( itemProperties && optionsPanelRect.selectedItem && optionsPanelRect.selectedItem.textItem)
            selectedItem: optionsPanelRect.selectedItem
            z: parent.z+1
        }
    }


    MouseArea
    {
        id: optionsSlideMouseArea
        anchors.fill: parent
        drag.axis: Drag.XAxis
        drag.target: optionsPanelRect
        drag.minimumX: presentation.width - optionsPanelRect.width
        drag.maximumX: presentation.width
        onClicked: {
            console.log("options panel")
            optionsPanelRect.state = (optionsPanelRect.state != "Closed") ? "Closed" : optionsPanelRect.state
        }

    }

    states:[
        State {
            name: "ItemProperties"
            when: presentation.slides[presentation.currentSlide].editSelectedItemProperties
            PropertyChanges { target: optionsPanelRect; x: optionsSlideMouseArea.drag.minimumX}
        },
        State {
            name: "SlideProperties"
            PropertyChanges { target: optionsPanelRect; x: optionsSlideMouseArea.drag.minimumX}
        },
        State {
            name: "Closed"
            PropertyChanges { target: optionsPanelRect; x: optionsSlideMouseArea.drag.maximumX }
        }]

    onStateChanged :
    {
        if (state != "Closed")
        {
            itemProperties = (state === "ItemProperties")
            slideProperties = (state === "SlideProperties")
            slidesListPanel.state = "closed"
            layoutsListPanel.state = "closed"
        }

    }

    Behavior on x { SmoothedAnimation { velocity: 400 } }

    state: "Closed"


}
