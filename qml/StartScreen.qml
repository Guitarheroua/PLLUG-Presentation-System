import QtQuick 2.4
import QtQuick.Dialogs 1.2
import PPS.ContentBlock 1.0

Rectangle {

    property var contentBlocksList: []

    Rectangle{
        color: "green"
        height: Math.round(parent.height / 3)
        width: parent.width
        anchors{
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        ListView{
            id: listViewId
            anchors{
                leftMargin: 10
                rightMargin: 10
                topMargin: 10
                fill: parent
            }
            model: slideModel
            orientation: ListView.Horizontal

            delegate: Rectangle {
                color: index % 2 == 0 ? "pink" : "lightblue"
                width: 100
                height: 100
                anchors{
                    leftMargin: 10
                    rightMargin: 10
                    topMargin: 10
                }
            }

        }
    }

    Repeater{
        id: canvasId
        anchors.fill: parent
        model: slideModel
        delegate: Rectangle{
            width: 100
            height: 100
            color: "red"
            x: model.x
            y: model.y
            z: model.z
        }
    }
    //    Column {
    //        spacing: 25
    //        anchors {
    //            right: parent.right
    //            bottom: parent.bottom
    //            rightMargin: 100
    //            bottomMargin : 90
    //        }

    //        StartScreenButton {
    //            id: openButton
    //            text: "Open presentation"
    //            onPressed: {
    //                fileDialog.nameFilters = ["Presentation (*.json)"]
    //                fileDialog.open()
    //            }
    //        }
    //        StartScreenButton {
    //            text: "Create new presentation"
    //            onPressed: {
    //                helper.setCreatePresentationMode();
    //                presentationLoader.setSource("TestPresentation.qml")
    //                startScreen.state = "closed"
    //            }
    //        }
    //    }

    //    states:
    //        [
    //        State {
    //            name: "opened"
    //            PropertyChanges {
    //                target: startScreen
    //                x: 0
    //            }
    //        },
    //        State {
    //            name: "closed"
    //            PropertyChanges {
    //                target: startScreen
    //                x: -startScreen.width

    //            }
    //        }
    //    ]
    //    state: "opened"
    //    Behavior on y { SmoothedAnimation { velocity: 2000 } }


    //    FileDialog{
    //        id: fileDialog
    //        title: "Please choose a file"
    //        selectMultiple: false
    //        onAccepted: {
    //            helper.openPresentation(fileDialog.fileUrl)
    //            startScreen.state = "closed"
    //        }
    //    }
}
