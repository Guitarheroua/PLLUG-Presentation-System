import QtQuick 2.0
import QtQuick.Controls 1.0
import Qt.labs.presentation 1.0

Presentation {
    id: presentation
    width: 1280
    height: 720
    MouseArea{
        anchors.fill:parent
        onClicked: {

        }
    }

    function addNewSlide()
    {
        var component = Qt.createComponent("EmptySlide.qml");
        var newSlide = component.createObject(presentation, {"title": "New Slide"});
        if (newSlide === null)
        {
            console.log("Error creating object");
        }
        presentation.newSlide(newSlide,presentation.currentSlide+1)
    }

    function removeSlideAt(index)
    {
        presentation.removeSlide(index)
    }

    Loader {
        id : backgroundLoader
        anchors.fill: parent
    }

    //    BackgroundSwirls {}

    textColor: "black"
    EmptySlide
    {
        title: "first slide"
        visible: false
        content: [
            "Gradient Rectangle",
            "Swirls using ShaderEffect",
            " Movement using a vertexShader",
            " Colorized using a gradient rect converted to a texture",
            " Controlled using QML properties and animations",
            "Snow"
        ]
    }

    Slide {
        centeredText: "Animated Background"
        fontScale: 2
        visible: false
        title: "anim slide"
        Block{
            id: block1
            width: 200
            height: 150
            x: 5
            y: 5
            z: presentation.z + 1

        }
    }

    Slide {
        title: "Composition"
        visible: false
        content: [
            "Gradient Rectangle",
            "Swirls using ShaderEffect",
            " Movement using a vertexShader",
            " Colorized using a gradient rect converted to a texture",
            " Controlled using QML properties and animations",
            "Snow",
            " Using 'QtQuick.Particles 2.0'",
            " Emitter",
            " ImageParticle"
        ]


    }
    Slide {
        title: "Slide"
        visible: false
        content: [
            "  Text1",
            "  Text2",
            "  Text3",

        ]
        fontScale: 1
        Clock{}
    }

    CodeSlide
    {
        title: "code slide"

        code: " RECT* rect = (RECT*) message->lParam;
        int fWidth = frameGeometry().width() - width();
        int fHeight = frameGeometry().height() - height();
        int nWidth = rect->right-rect->left - fWidth;
        int nHeight = rect->bottom-rect->top - fHeight;

        switch(message->wParam) {
        case WMSZ_BOTTOM:
        case WMSZ_TOP:
            rect->right = rect->left+(qreal)nHeight*mAspectRatio + fWidth;
            break;"
    }

    //    PageFlipShaderEffect
    //    {
    //        id: effect
    //        currentPage: 0
    //        onCurrentPageChanged:
    //        {
    //            presentation.currentSlide = currentPage
    //        }

    //        vertexShader: vshader
    //        fragmentShader: fshader

    //    }

    Rectangle{
        id: optionsSlide
        width: 210
        height: presentation.height
        color: "lightgreen"
        x: presentation.width - 10
        z: presentation.z + 2

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
                    optionsSlide.state = "closed"
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
                    presentation.addNewSlide()
                    optionsSlide.state = "closed"
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
                    optionsSlide.state = "closed"
                }
            }

        }

        MouseArea
        {
            id: optionsSlideMouseArea
            anchors.fill: parent
            drag.axis: Drag.XAxis
            drag.target: optionsSlide
            drag.minimumX: presentation.width - optionsSlide.width
            drag.maximumX: presentation.width - 10
            onClicked: {
                optionsSlide.state = (optionsSlide.state === "closed") ? "opened" : "closed"
            }

        }

        states:[
            State {
                name: "opened"
                PropertyChanges { target: optionsSlide; x: optionsSlideMouseArea.drag.minimumX}
            },
            State {
                name: "closed"
                PropertyChanges { target: optionsSlide; x: optionsSlideMouseArea.drag.maximumX }
            }]
        onStateChanged:
        {
            console.log(optionsSlide.state)
        }

        Behavior on x { SmoothedAnimation { velocity: 400 } }

        state: "closed"

    }


}
