import QtQuick 2.4
import QtWebKit 3.0

Rectangle {
    id: item
    width: 800
    height: 800
    WebView {
        id: webView
        objectName: "webView"
        anchors.fill: parent
        boundsBehavior: Flickable.StopAtBounds
        url: "http://www.youtube.com"
        //            preferredHeight: flickable.height
        //            preferredWidth: flickable.width
    }
}
