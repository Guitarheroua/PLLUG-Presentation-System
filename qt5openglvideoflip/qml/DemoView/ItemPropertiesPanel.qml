import QtQuick 2.0

Rectangle
{
    id: itemPropertiesRect
    property var currentItem
    width: 200
    height: 200
    color: "#363636"
    visible: true
    Item
    {
        anchors
        {
            fill: parent
            topMargin: 10
            leftMargin: 10
        }

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
                    z: itemPropertiesRect.z +1
                    TextInput
                    {
                        id: widthTextInput
                        anchors.centerIn: parent
                        text: (itemPropertiesRect.currentItem) ? itemPropertiesRect.currentItem.width : 0
                        font.pointSize: 10
                        validator: IntValidator{
                            bottom: 50;
                            top: /*(itemPropertiesRect.visible) ? itemPropertiesRect.width : 0*/600
                        }
                        focus: true
                        onTextChanged: {
                            if (itemPropertiesRect.currentItem != undefined && itemPropertiesRect.visible && text != "")
                            {
                                console.log("width", text)
                                itemPropertiesRect.currentItem.width =  parseInt(text)
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
                    z: itemPropertiesRect.z +1
                    TextInput
                    {
                        id: heightTextInput
                        anchors.centerIn:  parent
                        text: (itemPropertiesRect.currentItem) ? itemPropertiesRect.currentItem.height : 0
                        font.pointSize: 10
                        focus: true
                        z: itemPropertiesRect.z +1
                        validator: IntValidator{
                            bottom: 50;
                            top: /*(itemPropertiesRect.visible) ? itemPropertiesRect.height : 0*/600
                        }
                        onTextChanged: {
                            if (itemPropertiesRect.currentItem != undefined && itemPropertiesRect.visible && text != "")
                            {
                                itemPropertiesRect.currentItem.height = parseInt(text)
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
                    z: itemPropertiesRect.z +1
                    TextInput
                    {
                        id: xTextInput
                        anchors.centerIn:  parent
                        text: (itemPropertiesRect.currentItem) ? itemPropertiesRect.currentItem.x : 0
                        font.pointSize: 10
                        focus: true
                        z: itemPropertiesRect.z +1
                        validator: IntValidator{
                            bottom: 50;
                            top: /*(itemPropertiesRect.visible) ? (itemPropertiesRect.width - itemPropertiesRect.currentItem.width) : 0*/600
                        }
                        onTextChanged: {
                            if (itemPropertiesRect.currentItem != undefined && itemPropertiesRect.visible && text != "")
                            {
                                itemPropertiesRect.currentItem.x = parseInt(text)
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
                    z: itemPropertiesRect.z +1
                    TextInput
                    {
                        id: yTextInput
                        anchors.centerIn:  parent
                        text: (itemPropertiesRect.currentItem) ? itemPropertiesRect.currentItem.y : 0
                        font.pointSize: 10
                        focus: true
                        z: itemPropertiesRect.z +1
                        validator: IntValidator{
                            bottom: 50
                            top: /*(itemPropertiesRect.visible) ? (itemPropertiesRect.height - itemPropertiesRect.currentItem.height) : 0*/600
                        }
                        onTextChanged: {
                            if (itemPropertiesRect.currentItem != undefined && itemPropertiesRect.visible && text != "")
                            {
                                itemPropertiesRect.currentItem.y = parseInt(text)
                            }
                        }
                        KeyNavigation.up: xTextInput
                        KeyNavigation.down: widthTextInput
                        KeyNavigation.tab: widthTextInput
                        KeyNavigation.backtab: xTextInput
                    }
                }

            }
        }
    }
    states:[
        State {
            name: "opened"
            PropertyChanges { target: itemPropertiesRect; x: 0}
        },
        State {
            name: "closed"
            PropertyChanges { target: itemPropertiesRect; x: -width }
        }]

    Behavior on x { SmoothedAnimation { velocity: 400 } }

    state: "closed"

}
