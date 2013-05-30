import QtQuick 2.0
import QtWebKit 3.0

Item
{
    id: item
    property string type : "web"
    property string source
    property int fontSize
    property string fontFamily

    property int mainWidth
    property int mainHeight
    property int mainX
    property int mainY

    Rectangle
    {
        id: titleRect
        objectName: "Caption"
        width: parent.width
        height: titleText.height + 10
        opacity: 0.5
        clip: true
        z: 1
        Text {
            id: titleText
            objectName: "CaptionText"
            font.pixelSize: item.fontSize
            font.family: item.fontFamily
        }
    }

    WebView
    {
        id: webView
        anchors.fill: parent
        url: source
        Component.onCompleted: {
             console.log("completed")
            }
    }

}
