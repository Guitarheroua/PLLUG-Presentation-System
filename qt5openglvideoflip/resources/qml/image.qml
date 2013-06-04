import QtQuick 2.0

Rectangle
{
    id: item
    property string type : "image"
    property string source
    property string aspect
    property int fontSize
    property string fontFamily
    property string textAlign

    property int mainWidth
    property int mainHeight
    property int mainX
    property int mainY

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

    onTextAlignChanged:
    {
        console.log(item.textAlign)
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

    MouseArea
    {
        anchors.fill: parent
        hoverEnabled: true
        onEntered:
        {
            titleRect.opacity = 0.7
        }
        onExited:
        {
            titleRect.opacity = 0.1
        }
    }



    Image
    {
        id: image
        anchors.fill : parent
        source: item.source
    }

    Rectangle
    {
        id: titleRect
        objectName: "Caption"
        width: parent.width
        height:  titleText.height + 15
        opacity: 0.0
        z: 1
        Text
        {
            id: titleText
            anchors
            {
                fill: parent
            }
            width: parent.width
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


