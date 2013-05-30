import QtQuick 2.0
import QtMultimedia 5.0

Item
{
    id: item
    property string type : "video"
    property string source

    property int mainWidth
    property int mainHeight
    property int mainX
    property int mainY



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
//                    mediaPlayer.seek(10000)
                    mediaPlayer.play();
                }
            }
        }
    }

    onVisibleChanged:
    {
        if (item.visible)
        {
            mediaPlayer.play()
        }
    }

    MediaPlayer
    {
        id: mediaPlayer
        //        autoPlay: true
        source: item.source
        autoLoad: true
        volume: 0.0
    }

    VideoOutput
    {
        id: videoOutput
        source: mediaPlayer
        anchors.fill: parent
        fillMode: VideoOutput.Stretch
    }
}

