import QtQuick 2.4
import QtMultimedia 5.0

Rectangle {
    id: item
    width: 800
    height: 800
    color: "green"
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
                x: 0
                y: 0
                z: 0

            }
        }
    ]
    state: "native"
    Image {
        id: replayImage
        source: "qrc:/icons/replay.png"
        width: 50
        height: 50
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        visible: false
        z : 1
        MouseArea {
            anchors.fill: parent
            onClicked: {
                mediaPlayer.play()
                mouseArea.prevPos = 0
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        property real prevPos: 0
        property real coeff: mediaPlayer.duration/videoOutput.width
        property real adds
        onClicked: {
            if (mediaPlayer.playbackState == MediaPlayer.PlayingState) {
                mediaPlayer.pause()
            }
            else {
                if (mediaPlayer.playbackState == MediaPlayer.PausedState ) {
                    mediaPlayer.play();
                }
            }
        }
        onDoubleClicked: {
            if ( item.state === "native") {
                item.state = "full"
            }
            else {
                item.state = "native"
            }
        }
        onPressAndHold: {
            mediaPlayer.seeking = true
            mediaPlayer.play()
        }
        onReleased: {
            if ( mediaPlayer.seeking) {
                mediaPlayer.seek(mouseX*coeff)
                mediaPlayer.seeking = false
            }
        }
        onMouseXChanged: {
            if ( mediaPlayer.seeking  && (mouseX >= 0)) {
                adds = (mouseX /*- prevPos*/) *coeff
                if ( (/*mediaPlayer.position +*/ adds  < mediaPlayer.duration)
                        && (/*mediaPlayer.position +*/ adds  > 0)) {
                    mediaPlayer.seek(/*mediaPlayer.position +*/ adds )
                }
                else {
                    if (/*mediaPlayer.position + */adds  >= mediaPlayer.duration ) {
                        mediaPlayer.seek(mediaPlayer.duration)
                    }
                    if (mediaPlayer.position + adds  <= 0 ) {
                        mediaPlayer.seek(1)
                    }
                }
                prevPos = mouseX
            }
        }

    }

    MediaPlayer  {
        id: mediaPlayer
        source: "../../data/video/Video.mp4"
        autoLoad: true
        volume: 0.0
        property bool seeking : false

        onStatusChanged: {
            if (mediaPlayer.status === MediaPlayer.Loaded) {
                mediaPlayer.play()
                mediaPlayer.seek(1)
                mediaPlayer.pause()
                mediaPlayer.volume = 1.0
            }
            if (mediaPlayer.status === MediaPlayer.EndOfMedia) {
                replayImage.visible = true
                mediaPlayer.seeking = false
                mouseArea.prevPos = 0
            }
        }
        onPlaying: {
            replayImage.visible = false
        }
    }

    VideoOutput {
        id: videoOutput
        source: mediaPlayer
        anchors.fill: parent
    }

}

