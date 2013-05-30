import QtQuick 2.0

Rectangle
{
    id: item
    property string type : "image"
    property string source
    property string aspect
    property int fontSize
    property string fontFamily

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

    Image
    {
        id: image
        anchors.fill : parent
        source: item.source
        Component.onCompleted:
        {
            console.log(item.aspect)

        }

    }
    Rectangle
    {
        id: titleRect
        objectName: "Caption"
        width: parent.width
        height:  titleText.height + 10
        opacity: 0.5
        z: 1
        Text {
            id: titleText
            objectName: "CaptionText"
            font.pixelSize: item.fontSize
            font.family: item.fontFamily

        }
    }

}


