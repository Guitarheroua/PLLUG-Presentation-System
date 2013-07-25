import QtQuick 2.0
import QtMultimedia 5.0

Rectangle
{
    id: item
    property string type : "video"
    property string source
    property string aspect
    property int fontSize
    property string fontFamily
    property string captionAlign
    property string textAlign

    property real widthCoeff
    property real heightCoeff

    property real xCoeff
    property real yCoeff
    property int titleY

    onAspectChanged:
    {
        if ( item.aspect === "crop")
        {
            videoOutput.fillMode = VideoOutput.PreserveAspectCrop
        }
        else if ( item.aspect === "fit")
        {
            videoOutput.fillMode = VideoOutput.PreserveAspectFit
        }
        else if ( item.aspect === "stretch")
        {
            videoOutput.fillMode = VideoOutput.Stretch
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

    states:[
        State {
            name: "full"
            PropertyChanges {
                target: item
                width: item.parent.width
                height: item.parent.height
                x: 0
                y: 0
                z: 2

            }
        },
        State {
            name: "native"

            PropertyChanges {
                target: item
                width: widthCoeff*item.parent.width
                height: heightCoeff*item.parent.height
                x: xCoeff*item.parent.width
                y: yCoeff*item.parent.height
                z: 1

            }
        }
    ]
    state: "native"

    Rectangle
    {
        id: titleRect
        objectName: "Caption"
        width: parent.width
        height: titleText.height + 5
        opacity: 0.0
        z: 1
        Text
        {
            id: titleText
            objectName: "CaptionText"
            width: parent.width
            font.pixelSize: item.fontSize
            font.family: item.fontFamily
            verticalAlignment: Text.AlignVCenter
        }
        Behavior on opacity
        {
            PropertyAnimation{}
        }
    }

    Image
    {
        id: replayImage
        source: "qrc:/icons/replay.png"
        width: 50
        height: 50
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        visible: false
        z : 1
        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {
                console.log("replay")
                mediaPlayer.play()
                mouseArea.prevPos = 0
            }
        }
    }



    MouseArea
    {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        property real prevPos: 0
        property real coeff: mediaPlayer.duration/videoOutput.width
        property real adds
        onClicked:
        {
            console.log("_____clicked")
            if (mediaPlayer.playbackState == MediaPlayer.PlayingState)
            {
                console.log("_____played")
                mediaPlayer.pause();
            }
            else
            {
                if (mediaPlayer.playbackState == MediaPlayer.PausedState )
                {
                    console.log("_____paused")
                    mediaPlayer.play();
                }
            }
        }
        onDoubleClicked:
        {
            if ( item.state === "native")
            {
                item.state = "full"
                titleRect.opacity = 0.0
            }
            else
            {
                item.state = "native"
            }
        }


        onEntered:
        {
            if ( item.state != "full")
            {
                titleRect.opacity = 0.7
            }
        }
        onExited:
        {
            titleRect.opacity = 0.0
        }

        onPressAndHold:
        {
            mediaPlayer.seeking = true
            mediaPlayer.play()
        }

        onReleased:
        {
            if ( mediaPlayer.seeking)
            {
                mediaPlayer.seeking = false
            }

        }

        onMouseXChanged:
        {
            if ( mediaPlayer.seeking  && (mouseX >= 0))
            {
                adds = (mouseX - prevPos) *coeff
//                console.log(mouseX, mediaPlayer.position, adds)
                if ( (mediaPlayer.position + adds  < mediaPlayer.duration) && (mediaPlayer.position + adds  > 0))
                {
//                    console.log("seek")
                    mediaPlayer.seek(mediaPlayer.position + adds )
                }
                else
                {
                    if (mediaPlayer.position + adds  >= mediaPlayer.duration )
                        mediaPlayer.seek(mediaPlayer.duration)
                    if (mediaPlayer.position + adds  <= 0 )
                        mediaPlayer.seek(0)
                }

                prevPos = mouseX
            }
        }

    }



    MediaPlayer
    {
        id: mediaPlayer
        source: item.source
//        autoPlay:  true
        autoLoad: true
        volume: 0.0
//        playbackRate: 4.0

        property bool seeking : false
//        loops: Animation.Infinite

        onPositionChanged:
        {
//            if (( mediaPlayer.position < mediaPlayer.duration) && ( mediaPlayer.position > mediaPlayer.duration - 500 ) )
//            {
//                console.log("!!!!!!!!!!!!")
////                mediaPlayer.pause()
//            }
        }
        onStatusChanged:
        {
            if (mediaPlayer.status === MediaPlayer.Loaded)
            {
                mediaPlayer.play()
                mediaPlayer.seek(1)
                mediaPlayer.pause()
            }
            if (mediaPlayer.status === MediaPlayer.EndOfMedia)
            {
//                item.color = "black"
                replayImage.visible = true
                mediaPlayer.seeking = false
            }

        }
        onPlaying:
        {
            replayImage.visible = false
        }


    }

    VideoOutput
    {
        id: videoOutput
        source: mediaPlayer
        anchors.fill: parent
    }

}

