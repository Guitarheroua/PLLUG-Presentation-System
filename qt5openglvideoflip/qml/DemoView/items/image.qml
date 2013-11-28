import QtQuick 2.0

Rectangle
{
    id: item
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

    onAspectChanged:
    {
        if ( item.aspect === "crop")
        {
            image.fillMode = Image.PreserveAspectCrop
        }
        else if ( item.aspect === "fit")
        {
            image.fillMode = Image.PreserveAspectFit
        }
        else if ( item.aspect === "stretch")
        {
            image.fillMode = Image.Stretch
        }
    }

    onCaptionAlignChanged:
    {
        if ( item.captionAlign === "top" )
        {
            titleRect.anchors.top = titleRect.parent.top
        }
        else if ( item.captionAlign === "bottom" )
        {
            titleRect.anchors.bottom = titleRect.parent.bottom
        }
    }

    onTextAlignChanged:
    {
        if ( item.textAlign === "center")
        {
            titleText.horizontalAlignment = Text.AlignHCenter
        }
        else  if ( item.textAlign === "left")
        {
            titleText.horizontalAlignment = Text.AlignLeft
        }
        else  if ( item.textAlign === "right")
        {
            titleText.horizontalAlignment = Text.AlignRight
        }
    }

    onParentChanged:
    {
        widthCoeff = width/parent.width
        heightCoeff = height/parent.height
        xCoeff = x/parent.width
        yCoeff = y/parent.height
        console.log("PARENT CHANGED", widthCoeff, heightCoeff, xCoeff, yCoeff)
    }

    onHeightChanged:
    {
        heightCoeff = height/parent.height
        console.log("heightcoef", heightCoeff, height, parent.height)
    }
    onWidthChanged:
    {
        widthCoeff = width/parent.width
    }
    onXChanged:
    {
        xCoeff = x/parent.width
    }
    onYChanged:
    {
        yCoeff = y/parent.height
    }

    states:[
        State {
            name: "full"
            PropertyChanges {
                target: item
                width: (item.parent) ? item.parent.width : 0
                height: (item.parent) ? item.parent.height : 0
                x: 0
                y: 0
                z: 2

            }
        },
        State {
            name: "native"
            PropertyChanges {
                target: item
                width: (item.parent) ? widthCoeff*item.parent.width : 0
                height: (item.parent) ? heightCoeff*item.parent.height : 0
                x: (item.parent) ? xCoeff*item.parent.width : 0
                y: (item.parent) ? yCoeff*item.parent.height : 0
                z: 1

            }
        }
    ]
    //    state: "native"

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

    Image
    {
        id: image
        anchors.fill : parent
        source: item.source
        antialiasing: true

    }

    Rectangle
    {
        id: titleRect
        objectName: "Caption"
        width: parent.width
        height:  titleText.height + 5
        opacity: 0.0
        z: 1
        Text
        {
            id: titleText
            //            width: parent.width
            objectName: "CaptionText"
            font.pixelSize: item.fontSize
            font.family: item.fontFamily
            verticalAlignment: Text.AlignVCenter
        }
        Behavior on opacity
        {
            PropertyAnimation{}
        }
    }

}


