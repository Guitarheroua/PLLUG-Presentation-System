import QtQuick 2.0
import QtWebKit 3.0

Rectangle
{
    id: item
    property string type : "web"
    property string source
    property int fontSize
    property string fontFamily
    property string textAlign

    property int mainWidth
    property int mainHeight
    property int mainX
    property int mainY

    onTextAlignChanged:
    {
        console.log(item.textAlign)
        if ( item.textAlign === "center")
        {
            titleText.horizontalAlignment = Text.AlignHCenter
        }
        else  if ( item.textAlign === "left")
        {
            titleText.horizontalAlignment = Text.AlignLeft
        }
        else  if ( item.textAlign === "right")
        {
            titleText.horizontalAlignment = Text.AlignRight
        }
    }

    Rectangle
    {
        id: titleRect
        objectName: "Caption"
        width: parent.width
        height: titleText.height + 15
        opacity: 0.5
        clip: true
        z: 1
        Text
        {
            id: titleText
            anchors
            {
                fill: parent
            }

            objectName: "CaptionText"
            font.pixelSize: item.fontSize
            font.family: item.fontFamily
            verticalAlignment: Text.AlignVCenter
        }

    }
    Rectangle
    {
        id: content
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.width
        WebView
        {
            id: webView
            anchors.fill: parent
            boundsBehavior: Flickable.StopAtBounds
            url: source
            Component.onCompleted:
            {
                console.log("completed")
            }
//            preferredHeight: flickable.height
//            preferredWidth: flickable.width
        }
    }

}
