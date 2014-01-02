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

//    Rectangle
//    {
//        width: 50
//        height: 50
//        z: 10
//        color: "red"
//        opacity: 0.5
//        MouseArea
//        {
//            anchors.fill: parent
//            onClicked:
//            {
//                helper.setEnableEdit(false)
//                console.log(helper.enableEdit())
//            }
//        }
//    }

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
