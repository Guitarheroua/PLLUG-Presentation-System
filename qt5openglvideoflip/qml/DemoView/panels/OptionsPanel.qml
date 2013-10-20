import QtQuick 2.0
import QtQuick.Controls 1.0

Rectangle{
    id: optionsPanelRect
    width: 210
    height: parent.height
    color: "black"
    opacity: 0.7
    z: parent.z + 2

    ListModel
    {
        id: optionsModel

        ListElement {
            name: "Background"
            contents: [
                ListElement {
                    name: "Swirls"
                    source: "background/BackgroundSwirls.qml"
                },
                ListElement {
                    name: "Fire"
                    source: "background/FireEffect.qml"
                },
                ListElement {
                    name: "Underwater"
                    source: "background/UnderwaterEffect.qml"
                }
            ]
        }
        ListElement {
            name: "Transitions"
            contents: [
                ListElement {
                    name: "Flipping page"
                    source: "PageFlipShaderEffect.qml"
                }

            ]
        }
    }

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
                color: "lightsteelblue"
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
                    rect.height = (subItemsRect.visible) ? rect.height + optionsModel.get(rect.ind).contents.count*subItemHeight + 10 : delegateItemText.height+lineRect.height
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
                height: 2
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
                        model: optionsModel.get(rect.ind).contents
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
                            }
                            MouseArea
                            {
                                anchors.fill: parent
                                onClicked:
                                {
                                    rect1.selected = !rect1.selected
                                    rect1.color = (rect1.selected ) ? Qt.darker(rect1.color, 1.5) : unselectedItemColor
                                    if (optionsModel.get(rect.ind).name === "Background")
                                    {
                                        if(rect1.selected)
                                        {
                                            presentation.addBackground(model.source)
                                        }
                                        else
                                        {
                                            presentation.removeBackground(model.source)
                                        }
                                    }
                                    else if (optionsModel.get(rect.ind).name === "Transitions")
                                    {
                                        if(rect1.selected)
                                        {
                                            presentation.addTransition(model.source)
                                        }
                                        else
                                        {
                                            presentation.removeTransition()
                                        }
                                    }

                                    optionsPanelRect.state = "closed"
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

    Item{
        id: listViewItem
        anchors
        {
            fill: parent
            margins: 5
        }
        z: parent.z+1
        ListView{
            id: optionsListView
            anchors.fill: parent
            model: optionsModel
            delegate: optionsListViewDelegate
            //            z: parent.z+1

        }

    }

    //        Rectangle
    //        {
    //            id: rect1
    //            anchors
    //            {
    //                top : parent.top
    //                left : parent.left
    //                topMargin: 20
    //                leftMargin : 20
    //            }
    //            width: text1.width+ 10
    //            height: text1.height
    //            z: parent.z + 2
    //            radius: 4
    //            Text{
    //                id: text1
    //                anchors.centerIn: parent
    //                text: "Add background swirl"
    //                font.pointSize: 12
    //            }
    //            MouseArea
    //            {
    //                anchors.fill: parent
    //                onClicked:
    //                {
    //                    //                backgroundLoader.setSource("../BackgroundSwirls.qml")
    //                    addBackground("../background/BackgroundSwirls.qml")
    //                    optionsPanelRect.state = "closed"
    //                }
    //            }

    //        }
    //    Rectangle
    //    {
    //        id: addSlideRect
    //        anchors
    //        {
    //            top : rect1.bottom
    //            left : parent.left
    //            topMargin: 20
    //            leftMargin : 20
    //        }
    //        width: text2.width + 10
    //        height: text2.height
    //        z: parent.z + 2
    //        radius: 4
    //        Text{
    //            id: text2
    //            anchors.centerIn: parent
    //            text: "Add new slide"
    //            font.pointSize: 12
    //        }
    //        MouseArea
    //        {
    //            anchors.fill: parent
    //            onClicked:
    //            {
    //                optionsSlideRect.parent.addNewSlide("")
    //                optionsSlideRect.state = "closed"
    //            }
    //        }

    //    }

    //    Rectangle
    //    {
    //        id: removeSlideRect
    //        anchors
    //        {
    //            top : addSlideRect.bottom
    //            left : parent.left
    //            topMargin: 20
    //            leftMargin : 20
    //        }
    //        width: text3.width+ 10
    //        height: text3.height
    //        z: parent.z + 2
    //        radius: 4
    //        Text{
    //            id: text3
    //            anchors.centerIn: parent
    //            text: "Remove slide"
    //            font.pointSize: 12
    //        }
    //        MouseArea
    //        {
    //            anchors.fill: parent
    //            onClicked:
    //            {
    //                presentation.removeSlideAt(presentation.currentSlide)
    //                optionsSlideRect.state = "closed"
    //            }
    //        }

    //    }

    //    Rectangle
    //    {
    //        id: goToSlideRect
    //        anchors
    //        {
    //            top : removeSlideRect.bottom
    //            left : parent.left
    //            topMargin: 20
    //            leftMargin : 20
    //        }
    //        width: text4.width+ 10
    //        height: text4.height
    //        z: parent.z + 2
    //        radius: 4
    //        Text{
    //            id: text4
    //            anchors.centerIn: parent
    //            text: "Go to slide: "
    //            font.pointSize: 12
    //        }
    //        MouseArea
    //        {
    //            anchors.fill: parent
    //            onClicked:
    //            {
    //                var index = parseInt(goToSlideIndexTextField.text)
    //                if ( !isNaN(index))
    //                {
    //                    presentation.goToSlide(index-1)
    //                    optionsSlideRect.state = "closed"
    //                }

    //            }
    //        }

    //    }
    //    TextField
    //    {
    //        id: goToSlideIndexTextField
    //        text: "0"
    //        width: 50
    //        z: parent.z + 2
    //        anchors
    //        {
    //            top:removeSlideRect.bottom
    //            topMargin: 20
    //            left: goToSlideRect.right
    //            leftMargin : 10
    //        }
    //    }

    MouseArea
    {
        id: optionsSlideMouseArea
        anchors.fill: parent
        drag.axis: Drag.XAxis
        drag.target: optionsPanelRect
        drag.minimumX: presentation.width - optionsPanelRect.width
        drag.maximumX: presentation.width
        onClicked: {
            optionsPanelRect.state = (optionsPanelRect.state === "closed") ? "opened" : "closed"
        }

    }

    states:[
        State {
            name: "opened"
            PropertyChanges { target: optionsPanelRect; x: optionsSlideMouseArea.drag.minimumX}
            PropertyChanges { target: layoutsListPanel; state: "closed"}
            PropertyChanges { target: slidesListPanel; state: "closed"}
        },
        State {
            name: "closed"
            PropertyChanges { target: optionsPanelRect; x: optionsSlideMouseArea.drag.maximumX }
        }]
    //        onStateChanged:
    //        {
    //            console.log(optionsSlideRect.state)
    //        }

    Behavior on x { SmoothedAnimation { velocity: 400 } }

    state: "closed"

}
