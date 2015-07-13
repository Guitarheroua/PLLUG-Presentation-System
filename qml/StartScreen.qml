import QtQuick 2.4
import QtQuick.Dialogs 1.2

Rectangle {
    id: startScreen
    //    anchors.fill : parent
    width: parent.width
    height: parent.height
    color: "lightsteelblue"
    z: 1

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


    FileDialog{
        id: fileDialog
        title: "Please choose a file"
        selectMultiple: false
        onAccepted: {
            helper.openPresentation(fileDialog.fileUrl)
            startScreen.state = "closed"
        }

    }

}
