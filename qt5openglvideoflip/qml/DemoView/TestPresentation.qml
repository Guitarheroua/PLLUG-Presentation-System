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
            console.log("$$$$$$$$")
        }
    }


    Loader {
        id : backgroundLoader
        anchors.fill: parent
    }

    //    BackgroundSwirls {}

    textColor: "black"

    Slide {
        centeredText: "Animated Background"
        fontScale: 2
        visible: false
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

    PageFlipShaderEffect
    {
        id: effect
        currentPage: 0

        vertexShader: vshader
        fragmentShader: fshader

    }

    Rectangle{
        id: optionsSlide
        width: 210
        height: presentation.height
        color: "green"
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
            anchors
            {
                top : parent.top
                left : parent.left
                topMargin: 20
                leftMargin : 20
            }
            width: text1.width
            height: text1.height
            z: parent.z + 2
            color: "red"
            Text{
                id: text1
                text: "Add background swirl"
            }
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    console.log("###")
                    backgroundLoader.setSource("BackgroundSwirls.qml")
                }
            }

        }

        MouseArea
        {
            id: mouseArea
            anchors.fill: parent
            drag.axis: Drag.XAxis
            drag.target: optionsSlide
            drag.minimumX: presentation.width - optionsSlide.width
            drag.maximumX: presentation.width - 10

        }
        states:[
            State {
                name: "opened"
                PropertyChanges { target: optionsSlide; x: presentation.width - optionsSlide.width}
            },
            State {
                name: "closed"
                PropertyChanges { target: optionsSlide; x: presentation.width - 10 }
            }]
        Behavior on x { SmoothedAnimation { velocity: 400 } }


    }


}
