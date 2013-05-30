import QtQuick 2.0
import QtMultimedia 5.0

Item
{
    id: item
    property string source

    property int mainWidth
    property int mainHeight
    property int mainX
    property int mainY
    onVisibleChanged:
    {
        if (item.visible)
        {
            mediaPlayer.play()
//            mediaPlayer.pause()
        }
    }

    MediaPlayer
    {
        id: mediaPlayer
//        autoPlay: true
        source: item.source
        autoLoad: true
//        onPlaybackStateChanged:
//        {
//            if (playbackState == MediaPlayer.PlayingState)
//            {
//                mediaPlayer.pause();
//            }
//        }
    }

    VideoOutput
    {
        id: videoOutput
        source: mediaPlayer
        anchors.fill: parent
        fillMode: VideoOutput.Stretch


    }
}

