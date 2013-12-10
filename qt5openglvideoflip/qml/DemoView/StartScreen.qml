import QtQuick 2.0
import QtQuick.Dialogs 1.0

Rectangle
{
    id: startScreen
//    anchors.fill : parent
    width: parent.width
    height: parent.height
    color: "lightsteelblue"
    z: 1
    Column
    {
        spacing: 10
        anchors.centerIn: parent
        Rectangle
        {
            id: openButton
            width: 350
            height: 50
            radius: 10
            Text
            {
                anchors.centerIn: parent
                text: "Open presentation"
                font.pointSize: 20
                font.italic: true
            }
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    console.log("clicked")
                    fileDialog.nameFilters = ["Presentation (*.json)"];
                    fileDialog.open();

                }
            }

        }
        Rectangle
        {
            id: createButton
            width: 350
            height: 50
            radius: 10
            Text
            {
                anchors.centerIn: parent
                text: "Create new presentation"
                font.pointSize: 20
                font.italic: true
            }
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    console.log("clicked")
                    presentationLoader.setSource("TestPresentation.qml")
                    helper.setCreatePresentationMode();
                    startScreen.state = "closed"
                }
            }

        }
    }


    states:
        [
        State {
            name: "opened"
            PropertyChanges {
                target: startScreen
                y: 0

            }
        },
        State {
            name: "closed"
            PropertyChanges {
                target: startScreen
                y: -startScreen.height

            }
        }
    ]
    state: "opened"
    Behavior on y { SmoothedAnimation { velocity: 1000 } }


    FileDialog{
        id: fileDialog
        title: "Please choose a file"
        selectMultiple: false
        onAccepted: {
             helper.openPresentation(fileDialog.fileUrl)
             startScreen.state = "closed"
            console.log("==========")
        }

    }

}
