import QtQuick 2.0
import QtWebKit 3.0

Item
{
    id: item
    property string source

    property int mainWidth
    property int mainHeight
    property int mainX
    property int mainY
    WebView
    {
        id: webView
        anchors.fill : parent
        url: source
        Component.onCompleted: {
             console.log("completed")
            }
    }

}
