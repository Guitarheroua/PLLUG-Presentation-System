import QtQuick 2.0

Rectangle
{
    id: titleRect
    width: parent.contentWidth
    height: textEdit.height
    anchors
    {
        horizontalCenter: parent.horizontalCenter
        top: parent.top
        topMargin: parent.topTitleMargin
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
        font.pointSize: parent.titleFontSize
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

