import QtQuick 2.0
import QtQuick.Controls 1.0

Rectangle{
    id: optionsPanelRect
    width: 210
    height: parent.height
    color: "black"
    opacity: 0.7
    z: parent.z + 2
    property var currentItem : presentation.slides[currentSlide].selectedItem
    property bool itemEditing: presentation.slides[presentation.currentSlide].editSelectedItemProperties
    property bool slideProperties: false
    property bool itemProperties: false
    onItemEditingChanged:
    {
        if(!itemEditing && state === "ItemProperties")
            state = "Closed"
    }

    ListModel
    {
        id: slideOptionsModel

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
                                            presentation.addBackground(model.source)
                                        }
                                        else
                                        {
                                            presentation.removeBackground(model.source)
                                        }
                                    }
                                    else if (slideOptionsModel.get(rect.ind).name === "Transitions")
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

    Item{
        id: listViewItem
        visible: slideProperties
        anchors
        {
            fill: parent
            margins: 5
        }
        z: parent.z+1
        ListView{
            id: optionsListView
            anchors.fill: parent
            model: slideOptionsModel
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


    //    ListModel
    //    {
    //        id: itemPropertiesModel

    //        ListElement {
    //            name: "Size"
    //            contents: [
    //                ListElement {
    //                    name: "Width"
    //                    value: (optionsPanelRect.currentItem) ? optionsPanelRect.currentItem.width : 0
    //                },
    //                ListElement {
    //                    name: "Height"
    //                    value: (optionsPanelRect.currentItem) ? optionsPanelRect.currentItem.height : 0
    //                }
    //            ]
    //        }
    //        ListElement {
    //            name: "Position"
    //            contents: [
    //                ListElement {
    //                    name: "X"
    //                    value: (optionsPanelRect.currentItem) ? optionsPanelRect.currentItem.x : 0
    //                },
    //                ListElement {
    //                    name: "Y"
    //                    value: (optionsPanelRect.currentItem) ? optionsPanelRect.currentItem.y : 0
    //                },
    //                ListElement {
    //                    name: "Z"
    //                    value: (optionsPanelRect.currentItem) ? optionsPanelRect.currentItem.z : 0
    //                }

    //            ]
    //        }
    //    }

    Item
    {
        visible: itemProperties
        anchors
        {
            fill: parent
            topMargin: 20
            leftMargin: 20
        }
        z: parent.z + 1

        Column{
            spacing : 10
            Row{
                spacing: 20
                Rectangle
                {
                    id: widthRect
                    width: 50
                    height: widthLabel.height+10
                    Text
                    {
                        id: widthLabel
                        text: "Width"
                        anchors.centerIn: parent
                        font.pointSize: 9
                    }

                }
                Rectangle
                {
                    width: 50
                    height: widthRect.height
                    z: optionsPanelRect.z +1
                    TextInput
                    {
                        id: widthTextInput
                        anchors.centerIn: parent
                        text: (optionsPanelRect.currentItem) ? optionsPanelRect.currentItem.width : 0
                        font.pointSize: 10
                        validator: IntValidator{
                            bottom: 50;
                            top: /*(itemPropertiesRect.visible) ? itemPropertiesRect.width : 0*/600
                        }
                        focus: true
                        onTextChanged: {
                            if (optionsPanelRect.currentItem != undefined && optionsPanelRect.visible && text != "")
                            {
                                console.log("width", text)
                                optionsPanelRect.currentItem.width =  parseInt(text)
                            }
                        }
                        KeyNavigation.up: yTextInput
                        KeyNavigation.down: heightTextInput
                        KeyNavigation.tab: heightTextInput
                        KeyNavigation.backtab: yTextInput
                    }
                }

            }
            Row{
                spacing: 20
                Rectangle
                {
                    id: heightRect
                    width: heightLabel.width+10
                    height: heightLabel.height+10
                    Text
                    {
                        id: heightLabel
                        anchors.centerIn: parent
                        text: "Height"
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.pointSize: 10
                    }

                }
                Rectangle
                {
                    width: 50
                    height: heightRect.height
                    z: optionsPanelRect.z +1
                    TextInput
                    {
                        id: heightTextInput
                        anchors.centerIn:  parent
                        text: (optionsPanelRect.currentItem) ? optionsPanelRect.currentItem.height : 0
                        font.pointSize: 10
                        focus: true
                        z: optionsPanelRect.z +1
                        validator: IntValidator{
                            bottom: 50;
                            top: /*(itemPropertiesRect.visible) ? itemPropertiesRect.height : 0*/600
                        }
                        onTextChanged: {
                            if (optionsPanelRect.currentItem != undefined && optionsPanelRect.visible && text != "")
                            {
                                optionsPanelRect.currentItem.height = parseInt(text)
                            }
                        }
                        KeyNavigation.up: widthTextInput
                        KeyNavigation.down: xTextInput
                        KeyNavigation.tab: xTextInput
                        KeyNavigation.backtab: widthTextInput
                    }
                }

            }
            Row{
                spacing: 20
                Rectangle
                {
                    id: xRect
                    width: 50
                    height: xLabel.height+10
                    Text
                    {
                        id: xLabel
                        anchors.centerIn: parent
                        text: "X"
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.pointSize: 10
                    }

                }
                Rectangle
                {
                    width: 50
                    height: xRect.height
                    z: optionsPanelRect.z +1
                    TextInput
                    {
                        id: xTextInput
                        anchors.centerIn:  parent
                        text: (optionsPanelRect.currentItem) ? optionsPanelRect.currentItem.x : 0
                        font.pointSize: 10
                        focus: true
                        z: optionsPanelRect.z +1
                        validator: IntValidator{
                            bottom: 50;
                            top: /*(itemPropertiesRect.visible) ? (itemPropertiesRect.width - itemPropertiesRect.currentItem.width) : 0*/600
                        }
                        onTextChanged: {
                            if (optionsPanelRect.currentItem != undefined && optionsPanelRect.visible && text != "")
                            {
                                optionsPanelRect.currentItem.x = parseInt(text)
                            }
                        }
                        KeyNavigation.up: heightTextInput
                        KeyNavigation.down: yTextInput
                        KeyNavigation.tab: yTextInput
                        KeyNavigation.backtab: heightTextInput
                    }
                }

            }

            Row{
                spacing: 20
                Rectangle
                {
                    id: yRect
                    width: 50
                    height: yLabel.height+10
                    Text
                    {
                        id: yLabel
                        anchors.centerIn:  parent
                        text: "Y"
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.pointSize: 10
                    }

                }
                Rectangle
                {
                    width: 50
                    height: yRect.height
                    z: optionsPanelRect.z +1
                    TextInput
                    {
                        id: yTextInput
                        anchors.centerIn:  parent
                        text: (optionsPanelRect.currentItem) ? optionsPanelRect.currentItem.y : 0
                        font.pointSize: 10
                        focus: true
                        z: optionsPanelRect.z +1
                        validator: IntValidator{
                            bottom: 50
                            top: /*(itemPropertiesRect.visible) ? (itemPropertiesRect.height - itemPropertiesRect.currentItem.height) : 0*/600
                        }
                        onTextChanged: {
                            if (optionsPanelRect.currentItem != undefined && optionsPanelRect.visible && text != "")
                            {
                                optionsPanelRect.currentItem.y = parseInt(text)
                            }
                        }
                        KeyNavigation.up: xTextInput
                        KeyNavigation.down: zTextInput
                        KeyNavigation.tab: zTextInput
                        KeyNavigation.backtab: xTextInput
                    }
                }

            }
            Row{
                spacing: 20
                Rectangle
                {
                    id: zRect
                    width: 50
                    height: yLabel.height+10
                    Text
                    {
                        id: zLabel
                        anchors.centerIn:  parent
                        text: "Z"
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.pointSize: 10
                    }

                }
                Rectangle
                {
                    width: 50
                    height: zRect.height
                    z: optionsPanelRect.z +1
                    TextInput
                    {
                        id: zTextInput
                        anchors.centerIn:  parent
                        text: (optionsPanelRect.currentItem) ? optionsPanelRect.currentItem.z : 0
                        font.pointSize: 10
                        focus: true
                        z: optionsPanelRect.z +1
                        validator: IntValidator{
                            bottom: 50
                            top: /*(itemPropertiesRect.visible) ? (itemPropertiesRect.height - itemPropertiesRect.currentItem.height) : 0*/600
                        }
                        onTextChanged: {
                            if (optionsPanelRect.currentItem != undefined && optionsPanelRect.visible && text != "")
                            {
                                optionsPanelRect.currentItem.z = parseInt(text)
                            }
                        }
                        KeyNavigation.up: yTextInput
                        KeyNavigation.down: widthTextInput
                        KeyNavigation.tab: widthTextInput
                        KeyNavigation.backtab: yTextInput
                    }
                }

            }
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
