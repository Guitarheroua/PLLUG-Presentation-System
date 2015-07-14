import QtQuick 2.4
import "../components/ColorPicker"

Rectangle {
    id: colorMenuItem
    height: (colorPicker.visible) ? mainHeight + colorPicker.height : mainHeight
    property alias selectedColor:  colorPicker.colorValue
    property color selectedItemColor
    property color unselectedItemColor: "grey"
    property bool selected: false
    property real mainHeight

    color: (!colorMenuItem.selected) ? colorMenuItem.unselectedItemColor
                                     : Qt.darker(colorMenuItem.unselectedItemColor, 1.5)

    Rectangle {
        id: menuItemRect
        z : parent.z + 1
        color: "transparent"
        height: parent.width
        width: parent.width
        Rectangle {
            id: colorRect
            anchors.fill: parent
            anchors.margins: 4
            color: colorMenuItem.selectedItemColor
            border.width: 1
            border.color: "lightgray"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    colorMenuItem.selected = !colorMenuItem.selected
                    colorPicker.visible = !colorPicker.visible
                    colorPicker.givenColor = colorMenuItem.selectedItemColor
                }
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked:
            {
                colorMenuItem.selected = !colorMenuItem.selected
                colorPicker.visible = !colorPicker.visible
                colorPicker.givenColor = colorMenuItem.selectedItemColor
                //            optionsPanelRect.state = "Closed"
            }
            drag.target: rect
            drag.axis: Drag.XAndYAxis
        }
    }

    Component.onCompleted: {
        mainHeight = height
        colorMenuItem.height = mainHeight

    }

    ColorPicker {
        id: colorPicker
        anchors.top: menuItemRect.bottom
        anchors.topMargin: 4
        anchors.left: parent.left
        //anchors.leftMargin: 1
        visible: false
        onVisibleChanged: {
            parent.height = (visible) ? mainHeight /*+ colorPicker.height*/ : mainHeight
        }
        onColorValueChanged: {
            colorMenuItem.selectedColor = colorValue
        }

        z: parent.z + 1
    }

}
