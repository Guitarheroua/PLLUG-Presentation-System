import QtQuick 2.0
import QtQuick.Controls 1.0
import Qt.labs.presentation 1.0
import "../"

Item
{
    id: templateItem
    anchors.fill: parent
    Rectangle
    {
        id: titleRect
        width: templateItem.parent.contentWidth
        height: textEdit.height
        anchors
        {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: templateItem.parent.titleItem.anchors.topMargin
        }

//        border
//        {
//            color: "lightgrey"
//            width: 1
//        }

        TextInput
        {
            id: textEdit
            anchors
            {
                centerIn: parent
            }

            text: "Click to add text"
            font.pointSize: templateItem.parent.titleFontSize
//            BorderImage {
//                id: borderImage
//                source: "http://embed.polyvoreimg.com/cgi/img-thing/size/y/tid/33783871.jpg"
//                width: parent.width;
//                height: parent.height
//                border.left: 5; border.top: 5
//                border.right: 5; border.bottom: 5
//                z: -1
//            }
            horizontalAlignment: Text.Center
            MouseArea
            {
                anchors.fill: parent
                onClicked: {
                    textEdit.text = (textEdit.text === "Click to add text") ? "" : textEdit.text
                    textEdit.forceActiveFocus()
//                    borderImage.visible = false
                }
            }
        }
    }

    Rectangle
    {
        id: contentRect
        x: templateItem.parent.contentX
        y: templateItem.parent.contentY
        width: templateItem.parent.contentWidth
        height: templateItem.parent.contentHeight
        Row{
            anchors.centerIn:  parent
            spacing: 20

            Block{
                width: 400
                height: 520
            }
            Column{
                spacing: 20
                Repeater
                {
                    model: 2
                    Block{
                        width: 400
                        height: 250
                    }
                }
            }


        }
    }
}
