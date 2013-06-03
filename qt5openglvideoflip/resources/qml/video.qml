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
    property string textAlign

    property int mainWidth
    property int mainHeight
    property int mainX
    property int mainY

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

    Rectangle
    {
        id: titleRect
        objectName: "Caption"
        width: parent.width
        height: titleText.height + 15
        opacity: 0.5
        z: 1
        Text
        {
            id: titleText
            objectName: "CaptionText"
            anchors
            {
                fill: parent
            }
            font.pixelSize: item.fontSize
            font.family: item.fontFamily
            verticalAlignment: Text.AlignVCenter
        }
    }



    MouseArea
    {
        anchors.fill: parent
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
    }

    MediaPlayer
    {
        id: mediaPlayer
        source: item.source
//        autoPlay:  true
        autoLoad: true
        volume: 0.0
//        property bool repeat: false
//        loops: Animation.Infinite

//        function playVideo()
//        {
//            console.log(mediaPlayer.source)
//            mediaPlayer.play()
//        }

        onPositionChanged:
        {
//            console.log( mediaPlayer.position,mediaPlayer.duration)
            if (( mediaPlayer.position < mediaPlayer.duration) && ( mediaPlayer.position > mediaPlayer.duration - 4900 ) )
            {
                console.log("!!!!!!!!!!!!")
//                mediaPlayer.seek(mediaPlayer.duration-10000)
//                console.log(mediaPlayer.position)
//                mediaPlayer.play()
                mediaPlayer.pause()
            }
        }
        onStatusChanged:
        {
            if (mediaPlayer.status === MediaPlayer.Loaded)
            {
                mediaPlayer.play()
                mediaPlayer.seek(1)
                mediaPlayer.pause()
//                mediaPlayer.autoLoad = false
            }
//            if (mediaPlayer.status === MediaPlayer.EndOfMedia)
//            {
////                console.log("*********")
////                mediaPlayer.repeat = true
////                mediaPlayer.stop()

////                console.log(mediaPlayer.source)
////                playVideo()
//            }

        }
//        onStopped:
//        {
//            console.log("SSSS")
//            mediaPlayer.autoPlay = false
//            mediaPlayer.play()
//            mediaPlayer.seek(1000)

//        }
//        onErrorChanged:
//        {
//            console("ERR - ", mediaPlayer.error)
//        }
//        onAvailabilityChanged:
//        {
//            console.log("@@@@", mediaPlayer.availability)
//        }

    }

    VideoOutput
    {
        id: videoOutput
        source: mediaPlayer
        anchors.fill: parent
//        onVisibleChanged:
//        {
//             console.log("VVVV", videoOutput.visible)
//        }
    }

}

