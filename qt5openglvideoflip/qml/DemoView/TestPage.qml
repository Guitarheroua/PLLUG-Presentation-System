import QtQuick 2.0
import QtQuick.Controls 1.0
import Qt.labs.presentation 1.0

Rectangle {
    id: mainRect
    width: 600
    height: 600
    color: "gray"

    Block{
        id: block1
        width: 200
        height: 150
        x: 5
        y: 5

    }
    Block{
        width: 300
        height: 150
        x: 250
        y: 20

    }
    Block{
        width: 150
        height: 250
        x: 50
        y: 250
    }
    Block{
        width: 250
        height: 300
        x: 300
        y: 250
    }


    Rectangle{
        id: optionsSlide
        width: 210
        height: mainRect.height
        color: "green"
        x: 590
        z: 1

        TextField
        {
            property alias itemWidth: block1.width
            text: itemWidth
            readOnly: false
            width: 50
            z:2
            anchors
            {
                left: parent.left
                leftMargin : 10
            }
            onTextChanged: {
                block1.width = text
            }
        }

        MouseArea
        {
            id: mouseArea
            anchors.fill: parent
            drag.axis: Drag.XAxis
            drag.target: optionsSlide
            drag.minimumX: 390
            drag.maximumX: 590
        }
        states:[
            State {
                name: "opened"
                PropertyChanges { target: optionsSlide; x: 390}
            },
            State {
                name: "closed"
                PropertyChanges { target: optionsSlide; x: 590 }
            }]
        Behavior on x { SmoothedAnimation { velocity: 400 } }


    }

}
