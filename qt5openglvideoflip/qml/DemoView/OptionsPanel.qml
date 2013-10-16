import QtQuick 2.0
import QtQuick.Controls 1.0

Rectangle{
    id: optionsSlideRect
    width: 210
    height: parent.height
    color: "gray"
    opacity: 0.7
    x: parent.width - 10
    z: parent.z + 2

    //        TextField
    //        {
    //            property alias itemWidth: block1.width
    //            text: itemWidth
    //            width: 50
    //            z:2
    //            anchors
    //            {
    //                left: parent.left
    //                leftMargin : 10
    //            }
    //            onTextChanged: {
    //                block1.width = text
    //            }
    //        }


    Rectangle
    {
        id: rect1
        anchors
        {
            top : parent.top
            left : parent.left
            topMargin: 20
            leftMargin : 20
        }
        width: text1.width+ 10
        height: text1.height
        z: parent.z + 2
        radius: 4
        Text{
            id: text1
            anchors.centerIn: parent
            text: "Add background swirl"
            font.pointSize: 12
        }
        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {
                backgroundLoader.setSource("BackgroundSwirls.qml")
                optionsSlideRect.state = "closed"
            }
        }

    }
    Rectangle
    {
        id: addSlideRect
        anchors
        {
            top : rect1.bottom
            left : parent.left
            topMargin: 20
            leftMargin : 20
        }
        width: text2.width + 10
        height: text2.height
        z: parent.z + 2
        radius: 4
        Text{
            id: text2
            anchors.centerIn: parent
            text: "Add new slide"
            font.pointSize: 12
        }
        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {
                optionsSlideRect.parent.addNewSlide("")
                optionsSlideRect.state = "closed"
            }
        }

    }

    Rectangle
    {
        id: removeSlideRect
        anchors
        {
            top : addSlideRect.bottom
            left : parent.left
            topMargin: 20
            leftMargin : 20
        }
        width: text3.width+ 10
        height: text3.height
        z: parent.z + 2
        radius: 4
        Text{
            id: text3
            anchors.centerIn: parent
            text: "Remove slide"
            font.pointSize: 12
        }
        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {
                presentation.removeSlideAt(presentation.currentSlide)
                optionsSlideRect.state = "closed"
            }
        }

    }

    Rectangle
    {
        id: goToSlideRect
        anchors
        {
            top : removeSlideRect.bottom
            left : parent.left
            topMargin: 20
            leftMargin : 20
        }
        width: text4.width+ 10
        height: text4.height
        z: parent.z + 2
        radius: 4
        Text{
            id: text4
            anchors.centerIn: parent
            text: "Go to slide: "
            font.pointSize: 12
        }
        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {
                var index = parseInt(goToSlideIndexTextField.text)
                if ( !isNaN(index))
                {
                    presentation.goToSlide(index-1)
                    optionsSlideRect.state = "closed"
                }

            }
        }

    }
    TextField
    {
        id: goToSlideIndexTextField
        text: "0"
        width: 50
        z: parent.z + 2
        anchors
        {
            top:removeSlideRect.bottom
            topMargin: 20
            left: goToSlideRect.right
            leftMargin : 10
        }
    }

    MouseArea
    {
        id: optionsSlideMouseArea
        anchors.fill: parent
        drag.axis: Drag.XAxis
        drag.target: optionsSlideRect
        drag.minimumX: presentation.width - optionsSlideRect.width
        drag.maximumX: presentation.width - 10
        onClicked: {
            optionsSlideRect.state = (optionsSlideRect.state === "closed") ? "opened" : "closed"
        }

    }

    states:[
        State {
            name: "opened"
            PropertyChanges { target: optionsSlideRect; x: optionsSlideMouseArea.drag.minimumX}
        },
        State {
            name: "closed"
            PropertyChanges { target: optionsSlideRect; x: optionsSlideMouseArea.drag.maximumX }
        }]
    //        onStateChanged:
    //        {
    //            console.log(optionsSlideRect.state)
    //        }

    Behavior on x { SmoothedAnimation { velocity: 400 } }

    state: "closed"

}
