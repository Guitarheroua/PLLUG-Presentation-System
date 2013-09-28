import QtQuick 2.0
import QtMultimedia 5.0

Rectangle
{
    id: item
    width: 800
    height: 800

    states:[
        State {
            name: "full"
            PropertyChanges {
                target: item
                width: item.parent.width
                height: item.parent.height
                x: 0
                y: 0
                z: 0

            }
        },
        State {
            name: "native"

            PropertyChanges {
                target: item
                width: 400
                height: 400
                x: 100
                y: 100
                z: 0

            }
        }
    ]
    state: "native"


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
            }
            else
            {
                item.state = "native"
            }
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
        source: "../../data/video/Video.mp4"
        autoPlay:  true
        autoLoad: true
        volume: 1.0
//        playbackRate: 4.0

        property bool seeking : false
////        loops: Animation.Infinite

        onPositionChanged:
        {
            if (( mediaPlayer.position < mediaPlayer.duration) && ( mediaPlayer.position > mediaPlayer.duration - 400 ) )
            {
                console.log("!!!!!!!!!!!!")
//                mediaPlayer.pause()
            }
        }
        onStatusChanged:
        {
            if (mediaPlayer.status === MediaPlayer.Loaded)
            {
                mediaPlayer.play()
                mediaPlayer.seek(1)
                mediaPlayer.pause()
                mediaPlayer.volume = 1.0
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

