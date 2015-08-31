import QtQuick 2.4
import QtQuick.Dialogs 1.2

Rectangle {
    Repeater {
        model: slideModel

        delegate: Rectangle {
            color: model.sourses["color"]
            x: model.x
            y: model.y
            z: model.z
            height: model.height
            width: model.width
            Component.onCompleted: {
                slideModel.addBlock(150,150,100,100,500,Text)
            }
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
