import QtQuick 2.0

//    Item
//    {
//        visible: itemProperties
//        anchors
//        {
//            fill: parent
//            topMargin: 20
//            leftMargin: 20
//        }
//        z: parent.z + 1

//        Column{
//            spacing : 10
//            Row{
//                spacing: 20
//                Rectangle
//                {
//                    id: widthRect
//                    width: 50
//                    height: widthLabel.height+10
//                    Text
//                    {
//                        id: widthLabel
//                        text: "Width"
//                        anchors.centerIn: parent
//                        font.pointSize: 9
//                    }

//                }
//                Rectangle
//                {
//                    width: 50
//                    height: widthRect.height
//                    z: optionsPanelRect.z +1
//                    TextInput
//                    {
//                        id: widthTextInput
//                        anchors.centerIn: parent
//                        font.pointSize: 10
//                        validator: IntValidator{
//                            bottom: 50;
//                            top: /*(itemPropertiesRect.visible) ? itemPropertiesRect.width : 0*/600
//                        }
//                        focus: true
//                        onTextChanged: {
//                            if (optionsPanelRect.selectedItem != undefined && optionsPanelRect.visible && text != "")
//                            {
//                                console.log("width", text)
//                                optionsPanelRect.selectedItem.width = parseInt(text)
//                            }
//                        }
//                        KeyNavigation.up: yTextInput
//                        KeyNavigation.down: heightTextInput
//                        KeyNavigation.tab: heightTextInput
//                        KeyNavigation.backtab: yTextInput
//                    }
//                }

//            }
//            Row{
//                spacing: 20
//                Rectangle
//                {
//                    id: heightRect
//                    width: heightLabel.width+10
//                    height: heightLabel.height+10
//                    Text
//                    {
//                        id: heightLabel
//                        anchors.centerIn: parent
//                        text: "Height"
//                        verticalAlignment: Text.AlignVCenter
//                        horizontalAlignment: Text.AlignHCenter
//                        font.pointSize: 10
//                    }

//                }
//                Rectangle
//                {
//                    width: 50
//                    height: heightRect.height
//                    z: optionsPanelRect.z +1
//                    property bool needToUpdate: true
//                    TextInput
//                    {
//                        id: heightTextInput
//                        anchors.centerIn:  parent
//                        font.pointSize: 10
//                        focus: true
//                        z: optionsPanelRect.z +1
//                        validator: IntValidator{
//                            bottom: 50;
//                            top: /*(itemPropertiesRect.visible) ? itemPropertiesRect.height : 0*/600
//                        }
//                        onTextChanged: {
//                            if (optionsPanelRect.selectedItem != undefined && optionsPanelRect.visible && text != "")
//                            {
//                                optionsPanelRect.selectedItem.height = parseInt(text)
//                            }
//                        }
//                        KeyNavigation.up: widthTextInput
//                        KeyNavigation.down: xTextInput
//                        KeyNavigation.tab: xTextInput
//                        KeyNavigation.backtab: widthTextInput
//                    }
//                }

//            }
//            Row{
//                spacing: 20
//                Rectangle
//                {
//                    id: xRect
//                    width: 50
//                    height: xLabel.height+10
//                    Text
//                    {
//                        id: xLabel
//                        anchors.centerIn: parent
//                        text: "X"
//                        verticalAlignment: Text.AlignVCenter
//                        horizontalAlignment: Text.AlignHCenter
//                        font.pointSize: 10
//                    }

//                }
//                Rectangle
//                {
//                    width: 50
//                    height: xRect.height
//                    z: optionsPanelRect.z +1
//                    TextInput
//                    {
//                        id: xTextInput
//                        anchors.centerIn:  parent
//                        font.pointSize: 10
//                        focus: true
//                        z: optionsPanelRect.z +1
//                        validator: IntValidator{
//                            bottom: 50;
//                            top: /*(itemPropertiesRect.visible) ? (itemPropertiesRect.width - itemPropertiesRect.currentItem.width) : 0*/600
//                        }
//                        onTextChanged: {
//                            if (optionsPanelRect.selectedItem != undefined && optionsPanelRect.visible && text != "")
//                            {
//                                optionsPanelRect.selectedItem.x = parseInt(text)
//                            }
//                        }
//                        KeyNavigation.up: heightTextInput
//                        KeyNavigation.down: yTextInput
//                        KeyNavigation.tab: yTextInput
//                        KeyNavigation.backtab: heightTextInput
//                    }
//                }

//            }

//            Row{
//                spacing: 20
//                Rectangle
//                {
//                    id: yRect
//                    width: 50
//                    height: yLabel.height+10
//                    Text
//                    {
//                        id: yLabel
//                        anchors.centerIn:  parent
//                        text: "Y"
//                        verticalAlignment: Text.AlignVCenter
//                        horizontalAlignment: Text.AlignHCenter
//                        font.pointSize: 10
//                    }

//                }
//                Rectangle
//                {
//                    width: 50
//                    height: yRect.height
//                    z: optionsPanelRect.z +1
//                    TextInput
//                    {
//                        id: yTextInput
//                        anchors.centerIn:  parent
//                        font.pointSize: 10
//                        focus: true
//                        z: optionsPanelRect.z +1
//                        validator: IntValidator{
//                            bottom: 50
//                            top: /*(itemPropertiesRect.visible) ? (itemPropertiesRect.height - itemPropertiesRect.currentItem.height) : 0*/600
//                        }
//                        onTextChanged: {
//                            if (optionsPanelRect.selectedItem != undefined && optionsPanelRect.visible && text != "")
//                            {
//                                optionsPanelRect.selectedItem.y = parseInt(text)
//                            }
//                        }
//                        KeyNavigation.up: xTextInput
//                        KeyNavigation.down: zTextInput
//                        KeyNavigation.tab: zTextInput
//                        KeyNavigation.backtab: xTextInput
//                    }
//                }

//            }
//            Row{
//                spacing: 20
//                Rectangle
//                {
//                    id: zRect
//                    width: 50
//                    height: yLabel.height+10
//                    Text
//                    {
//                        id: zLabel
//                        anchors.centerIn:  parent
//                        text: "Z"
//                        verticalAlignment: Text.AlignVCenter
//                        horizontalAlignment: Text.AlignHCenter
//                        font.pointSize: 10
//                    }

//                }
//                Rectangle
//                {
//                    width: 50
//                    height: zRect.height
//                    z: optionsPanelRect.z +1
//                    TextInput
//                    {
//                        id: zTextInput
//                        anchors.centerIn:  parent
//                        font.pointSize: 10
//                        focus: true
//                        z: optionsPanelRect.z +1
//                        validator: IntValidator{
//                            bottom: 50
//                            top: /*(itemPropertiesRect.visible) ? (itemPropertiesRect.height - itemPropertiesRect.currentItem.height) : 0*/600
//                        }
//                        onTextChanged: {
//                            if (optionsPanelRect.selectedItem != undefined && optionsPanelRect.visible && text != "")
//                            {
//                                optionsPanelRect.selectedItem.z = parseInt(text)
//                            }
//                        }
//                        KeyNavigation.up: yTextInput
//                        KeyNavigation.down: widthTextInput
//                        KeyNavigation.tab: widthTextInput
//                        KeyNavigation.backtab: yTextInput
//                    }
//                }
//            }
//        }
//    }

Item{
    id: positionRect
    width: parent.width
    height: delegateItemText.height+lineRect.height
//        color: "transparent"
    property var selectedItem
    property int subItemHeight: 25
    Text {
        id: delegateItemText
        text: "Position"
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
            positionRect.height = (subItemsRect.visible) ? positionRect.height + 25*3 + 10 : delegateItemText.height+lineRect.height
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
            id: propertiesColumn
            anchors.fill: parent
            spacing: 2
            OptionsMenuItem
            {
                propertyName: "X"
                propertyValue: (positionRect.selectedItem)? positionRect.selectedItem.x : 0
                width: positionRect.width
                height: positionRect.subItemHeight
                onPropertyValueChanged:
                {
                    selectedItem.x = parseInt(propertyValue)
                }
            }
            OptionsMenuItem
            {
                propertyName: "Y"
                propertyValue: (positionRect.selectedItem)? positionRect.selectedItem.y : 0
                width: positionRect.width
                height: positionRect.subItemHeight
                onPropertyValueChanged:
                {
                    selectedItem.y = parseInt(propertyValue)
                }
            }
            OptionsMenuItem
            {
                propertyName: "Z"
                propertyValue: (positionRect.selectedItem)? positionRect.selectedItem.z : 0
                width: positionRect.width
                height: positionRect.subItemHeight
                onPropertyValueChanged:
                {
                    selectedItem.z = parseInt(propertyValue)
                }
            }

        }


    }

}
