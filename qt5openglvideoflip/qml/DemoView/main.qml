import QtQuick 2.0

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
        objectName: "PresentationLoader"
        anchors.fill: parent
        focus: true
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
