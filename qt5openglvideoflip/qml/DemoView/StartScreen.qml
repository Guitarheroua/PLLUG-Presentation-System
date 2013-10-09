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
//    Rectangle
//    {
//        id: openButton

//    }
    Rectangle
    {
        id: createButton
        width: createButtonText.width + 10
        height: 50
        radius: 10
        anchors.centerIn: parent
        Text
        {
            id: createButtonText
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
    Behavior on y { SmoothedAnimation { velocity: 600 } }

}
