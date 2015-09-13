import QtQuick 2.5
import QtQuick.Dialogs 1.2
//import PPS.ContentBlock 1.0

Rectangle {
    //    Rectangle{
    //        color: "green"
    //        height: Math.round(parent.height / 3)
    //        width: parent.width
    //        anchors{
    //            left: parent.left
    //            right: parent.right
    //            bottom: parent.bottom
    //        }
    //        ListView{
    //            id: listViewId
    //            anchors{
    //                leftMargin: 10
    //                rightMargin: 10
    //                topMargin: 10
    //                fill: parent
    //            }
    //            model: slideModel
    //            orientation: ListView.Horizontal

    //            delegate: Rectangle {
    //                color: index % 2 == 0 ? "pink" : "lightblue"
    //                width: 100
    //                height: 100
    //                anchors{
    //                    leftMargin: 10
    //                    rightMargin: 10
    //                    topMargin: 10
    //                }
    //            }
    //            Component.onCompleted: {
    //                canvasId.model.append(contentBlockId);
    //                canvasId.model.append(contentBlockId);
    //            }
    //        }
    //    }

    //    Repeater{
    //        id: canvasId
    //        model: slideModel.getModelFromChild(0)
    //        anchors.fill: parent
    //        delegate: Component {
    //            Rectangle{
    //                width: model.width
    //                height: model.height
    //                color: index % 2 == 0 ? "red" : "brown"
    //            }
    //        }
    //    }


    //    ContentBlock {
    //        id: contentBlockId
    //        width: 130
    //        height: 120
    //        x: 50
    //        y: 40
    //        z: 20
    //        contentBlockType: ContentBlock.None
    //    }

    Column {
        spacing: 25
        anchors {
            right: parent.right
            bottom: parent.bottom
            rightMargin: 100
            bottomMargin : 90
        }

        StartScreenButton {
            id: openButton
            text: "Open presentation"
            onPressed: {
                fileDialog.nameFilters = ["Presentation (*.json)"]
                fileDialog.open()
            }
        }

        StartScreenButton {
            text: "Create new presentation"
            onPressed: {
                helper.setCreatePresentationMode();
                presentationLoader.setSource("TestPresentation.qml")
                startScreen.state = "closed"
            }
        }
    }

    FileDialog{
        id: fileDialog
        title: "Please choose a file"
        selectMultiple: false
        onAccepted: {
            helper.openPresentation(fileDialog.fileUrl)
            startScreen.state = "closed"
        }
    }

    states:
        [
        State {
            name: "opened"
            PropertyChanges {
                target: startScreen
                x: 0
            }
        },
        State {
            name: "closed"
            PropertyChanges {
                target: startScreen
                x: -startScreen.width
            }
        }
    ]
    state: "opened"
    Behavior on y { SmoothedAnimation { velocity: 2000 } }
}
