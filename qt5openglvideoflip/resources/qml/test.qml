import QtQuick 2.0
import QtMultimedia 5.0

Rectangle {
    width: 600
    height: 800
    color: "red"
    ListModel
    {
        id: model1
        ListElement
        {
            type: "video"
            source: "Wildlife.wmv"
            width: 400
            height: 200
            x: 10
            y: 10
        }

        ListElement
        {
            type: "image"
            source: "flower1.jpg"
            width: 600
            height: 200
        }
        ListElement
        {
            type: "web"
            source: "http://goggle.com"
            width: 700
            height: 200
            x: 10
            y: 100
        }
        ListElement
        {
            type: "video"
            source: "Wildlife.wmv"
            width: 100
            height: 200
        }
    }

    VisualDataModel
    {
        id: visualModel
        model: model1
        delegate:Rectangle
        {
        id: rect
        height: model.height
        width: model.width
        Loader
        {
            id: loaderr
            anchors.fill: parent
        }
        Component.onCompleted:
        {
            loaderr.setSource(model.type +".qml", {"source": "qrc:/"+ model.type + "/" +model.source});
        }
    }
}
GridView
{
    anchors.fill: parent
    model: visualModel
    cellHeight: 300
    cellWidth: 500
}

//    ListModel{
//        id: screensModel

//        ListElement {
//            name: "page1"
//            color: "black"
//        }
//        ListElement {
//            name: "page2"
//            color: "green"
//        }
//        ListElement {
//            name: "page3"
//            color: "blue"
//        }
//    }

//    ListView{
//        anchors.fill: parent
//        orientation: ListView.Horizontal
//        model: screensModel
//        delegate: Rectangle{
//            width: 800
//            height: 600
//            color: color
//            Text {
//                id: t
//                text: name
//                anchors.centerIn: parent
//            }
//            WebView {
//                id: webview
//                url: "http://youtube.com"
//                width: parent.width
//                height: parent.height
////                experimental.preferences.navigatorQtObjectEnabled: true
////                experimental.preferences.pluginsEnabled: true
////                onNavigationRequested: {
////                    // detect URL scheme prefix, most likely an external link
////                    var schemaRE = /^\w+:/;
////                    if (schemaRE.test(request.url)) {
////                        request.action = WebView.AcceptRequest;
////                    } else {
////                        request.action = WebView.IgnoreRequest;
////                        // delegate request.url here
////                    }
//                }

//        }
//    }
}
