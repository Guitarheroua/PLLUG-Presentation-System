import QtQuick 2.0
import "../components/ColorPicker"

Item
{
    id: colorMenuItem
    height: (colorPicker.visible) ? mainHeight + colorPicker.height : mainHeight
    property alias selectedColor/*: propertyValueRect.color*/: colorPicker.colorValue
    property color selectedItemColor
    onSelectedColorChanged:
    {
        console.log("***********",selectedColor)
    }
//    onSelectedItemColorChanged:
//    {
//        console.log(helper.getSaturation(selectedItemColor))
//    }

    property color unselectedItemColor: "grey"
    property bool selected: false
    property real mainHeight

    Rectangle
    {
        id: menuItemRect
        color: unselectedItemColor
        anchors.top: parent.top
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
                    MouseArea
                    {
                        anchors.fill: parent
                        onClicked:
                        {
                            colorPicker.visible = true
                            colorPicker.givenColor = colorMenuItem.selectedItemColor
//                            colorPicker.hue = helper.hue(selectedItemColor)
//                            colorPicker.saturation = helper.saturation(selectedItemColor)
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
                colorMenuItem.selectedColor = (colorMenuItem.selected ) ? Qt.darker(colorMenuItem.color, 1.5) : colorMenuItem.unselectedItemColor

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
            parent.height = mainHeight + colorPicker.height
        }
        onColorValueChanged:
        {
            colorMenuItem.selectedColor = colorValue
            console.log(helper.saturation(colorValue))
            console.log(helper.brightness(colorValue))
        }

        z: parent.z +1
    }
}
