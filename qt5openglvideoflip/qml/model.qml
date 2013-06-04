import QtQuick 2.0
import QtMultimedia 5.0

VisualItemModel
{
    id: model
    Item {
        id: video
        width: 500
        height: 500
        MediaPlayer
        {
            id: mediaPlayer
            autoPlay: true
            source: "Wildlife.wmv"
        }

        VideoOutput
        {
            id: videoOutput
            anchors.fill: parent
            source: mediaPlayer
        }
    }
    Image
    {
        source: "cat.jpg"
        width: 200
        height: /*534*/200
    }
}
