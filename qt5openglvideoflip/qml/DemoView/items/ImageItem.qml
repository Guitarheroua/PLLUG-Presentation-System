import QtQuick 2.4

Rectangle {
    id: imageItemRoot
    property string type : "image"
    property string source
    property string aspect
    property int fontSize
    property string fontFamily
    property string captionAlign
    property string textAlign

    property real widthCoeff :  1
    property real heightCoeff : 1

    property real xCoeff :  0
    property real yCoeff :  0

    onAspectChanged: {
        if ( imageItemRoot.aspect === "crop") {
            image.fillMode = Image.PreserveAspectCrop
        }
        else if ( imageItemRoot.aspect === "fit") {
            image.fillMode = Image.PreserveAspectFit
        }
        else if ( imageItemRoot.aspect === "stretch") {
            image.fillMode = Image.Stretch
        }
    }

    onCaptionAlignChanged: {
        if ( imageItemRoot.captionAlign === "top" ) {
            titleRect.anchors.top = titleRect.parent.top
        }
        else if ( imageItemRoot.captionAlign === "bottom" ) {
            titleRect.anchors.bottom = titleRect.parent.bottom
        }
    }

    onTextAlignChanged: {
        if ( imageItemRoot.textAlign === "center") {
            titleText.horizontalAlignment = Text.AlignHCenter
        }
        else  if ( imageItemRoot.textAlign === "left") {
            titleText.horizontalAlignment = Text.AlignLeft
        }
        else  if ( imageItemRoot.textAlign === "right") {
            titleText.horizontalAlignment = Text.AlignRight
        }
    }

    onParentChanged: {
        widthCoeff = width/parent.width
        heightCoeff = height/parent.height
        xCoeff = x/parent.width
        yCoeff = y/parent.height
    }

    onHeightChanged: {
        heightCoeff = height/parent.height
    }
    onWidthChanged: {
        widthCoeff = width/parent.width
    }
    onXChanged: {
        xCoeff = x/parent.width
    }
    onYChanged: {
        yCoeff = y/parent.height
    }

    states:[
        State {
            name: "full"
            PropertyChanges {
                target: imageItemRoot
                width: (imageItemRoot.parent) ? imageItemRoot.parent.width : 0
                height: (imageItemRoot.parent) ? imageItemRoot.parent.height : 0
                x: 0
                y: 0
                z: 2

            }
        },
        State {
            name: "native"
            PropertyChanges {
                target: imageItemRoot
                width: (imageItemRoot.parent) ? widthCoeff*imageItemRoot.parent.width : 0
                height: (imageItemRoot.parent) ? heightCoeff*imageItemRoot.parent.height : 0
                x: (imageItemRoot.parent) ? xCoeff*imageItemRoot.parent.width : 0
                y: (imageItemRoot.parent) ? yCoeff*imageItemRoot.parent.height : 0
                z: 1

            }
        }
    ]
    // maybe will be useful someday:)
    //    MouseArea
    //    {
    //        anchors.fill: parent
    //        hoverEnabled: true
    //        onEntered:
    //        {
    //            if ( item.state != "full")
    //            {
    //                titleRect.opacity = 0.7
    //            }
    //        }
    //        onExited:
    //        {
    //            titleRect.opacity = 0.0
    //        }
    //        onDoubleClicked:
    //        {
    //            if ( item.state === "native")
    //            {
    //                item.state = "full"
    //                titleRect.opacity = 0.0
    //            }
    //            else
    //            {
    //                item.state = "native"
    //            }
    //        }
    //    }

    Image {
        id: image
        anchors.fill : parent
        source: imageItemRoot.source
        antialiasing: true

    }

    Rectangle {
        id: titleRect
        objectName: "Caption"
        width: parent.width
        height: titleText.height + 5
        opacity: 0.0
        z: 1
        Text  {
            id: titleText
            //            width: parent.width
            objectName: "CaptionText"
            font.pixelSize: imageItemRoot.fontSize
            font.family: imageItemRoot.fontFamily
            verticalAlignment: Text.AlignVCenter
        }
        Behavior on opacity {
            PropertyAnimation{}
        }
    }

}


