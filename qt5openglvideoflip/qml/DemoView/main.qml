import QtQuick 2.0
import QtWebKit 3.0
import QtMultimedia 5.0

Rectangle
{
    id: mainRect
    objectName: "mainRect"
//    color: "lightblue"
    width: 1280
    height: 720
    Loader
    {
        id: presentationLoader
        anchors.fill: parent
        source: "TestPresentation.qml"
    }

    StartScreen
    {
        id: startScreen
    }

    states:
        [
        State{
            id: editState
        },
        State{
            id: showState
        }

    ]



}
