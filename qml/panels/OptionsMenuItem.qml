import QtQuick 2.4

Rectangle {
    id: menuItemRect
    color: "grey"
    property alias propertyName: propertyNameText.text
    property alias propertyValue: propertyValueText.text
    Row {
        spacing: (propertyName != "") ? 10 : 0
        anchors.fill: parent
        Item {
            width: menuItemRect.width/2
            height: menuItemRect.height
            visible: propertyName !== ""
            Text {
                id: propertyNameText
                anchors {
                    fill: parent
                    margins: 5
                }
                font.pointSize: 10
                color: "black"
            }
        }
        Item {
            width: (propertyName != "") ? menuItemRect.width/2 : menuItemRect.width
            height: menuItemRect.height
            Rectangle {
                anchors {
                    fill: parent
                    margins: 4
                }
                color: (propertyName === "") ? "lightgray" : "transparent"
                TextEdit {
                    id: propertyValueText
                    focus: true
                    anchors {
                        centerIn : parent
                    }
                    font.pointSize: 10
                    color: (propertyName != "") ? "white" : "black"
                }
            }
        }
    }
}
