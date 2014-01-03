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
    Image
    {
        anchors.fill: parent
        source: "qrc:///images/presentation.png"
    }

    Column
    {
        spacing: 25
        anchors
        {
            right: parent.right
            bottom: parent.bottom

            rightMargin: 100
            bottomMargin : 90
        }

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
                    helper.setCreatePresentationMode();
                    presentationLoader.setSource("TestPresentation.qml")
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
    Behavior on x { SmoothedAnimation { velocity: 2000 } }


    FileDialog{
        id: fileDialog
        title: "Please choose a file"
        selectMultiple: false
        onAccepted: {
             helper.openPresentation(fileDialog.fileUrl)
             startScreen.state = "closed"
             console.log("==========", presentationLoader.item.currentSlide, presentationLoader.item.slides[presentationLoader.item.currentSlide].title)
        }

    }

}
