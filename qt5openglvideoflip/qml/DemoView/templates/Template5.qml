import QtQuick 2.0
import QtQuick.Controls 1.0
import Qt.labs.presentation 1.0
import "../"

Slide {
    id: mainRect
    Rectangle
    {
        id: titleRect
        width: contentWidth
        height: textEdit.height
        anchors
        {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: titleItem.anchors.topMargin
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
            font.pointSize: titleFontSize
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
        x: contentX
        y: contentY
        width: contentWidth
        height: contentHeight
        Row{
            anchors.centerIn:  parent
            spacing: 20

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
            Block{
                width: 400
                height: 520
            }

        }
    }
}
