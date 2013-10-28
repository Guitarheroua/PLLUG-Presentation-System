import QtQuick 2.0
import "../components/ColorPicker"

Rectangle
{
    id: colorMenuItem
    height: (colorPicker.visible) ? mainHeight + colorPicker.height : mainHeight
    property color selectedColor:  colorPicker.colorValue
    property color selectedItemColor
    onSelectedColorChanged:
    {
//        console.log("***********",selectedColor)
    }
    onSelectedItemColorChanged:
    {
//        console.log(helper.getSaturation(selectedItemColor))
    }

    property color unselectedItemColor: "grey"
    property bool selected: false
    property real mainHeight

    color: (!colorMenuItem.selected) ? colorMenuItem.unselectedItemColor : Qt.darker(colorMenuItem.unselectedItemColor, 1.5)

    Rectangle
    {
        id: menuItemRect
        z : parent.z + 1
        color: "transparent"
        anchors.top: parent.top
        height: 25
        width: parent.width
        Row
        {
            spacing: 10
            anchors.fill: parent
            Item
            {
                width: colorMenuItem.width/2
                height: parent.height
                Text
                {
                    id: propertyNameText
                    anchors
                    {
                        fill: parent
                        margins: 5
                    }
                    text: "Color"
                    font.pointSize: 10
                    color: "white"
                }
            }
            Item
            {
                width: colorMenuItem.width/2
                height: parent.height
                Rectangle
                {
                    id: colorRect
                    height: parent.height-4
                    width: 50
                    x: 10
                    y: 2
                    color: colorMenuItem.selectedItemColor
                    border.width: 1
                    border.color: "black"
                    MouseArea
                    {
                        anchors.fill: parent
                        onClicked:
                        {
                            colorMenuItem.selected = !colorMenuItem.selected
                            colorPicker.visible = !colorPicker.visible
                            colorPicker.givenColor = colorMenuItem.selectedItemColor
                        }
                    }
                }
            }
        }
        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {
                colorMenuItem.selected = !colorMenuItem.selected
                colorPicker.visible = !colorPicker.visible
                colorPicker.givenColor = colorMenuItem.selectedItemColor
                //            optionsPanelRect.state = "Closed"
            }

        }
    }

    Component.onCompleted:
    {
        mainHeight = height
        menuItemRect.height = mainHeight

    }

    ColorPicker
    {
        id: colorPicker
        anchors.top: menuItemRect.bottom
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        visible: false
        onVisibleChanged:
        {
            parent.height = (visible) ? mainHeight + colorPicker.height : mainHeight
        }
        onColorValueChanged:
        {
            colorMenuItem.selectedColor = colorValue
        }

        z: parent.z + 1
    }
}
