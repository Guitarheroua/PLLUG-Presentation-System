import QtQuick 2.0
import Qt.labs.presentation 1.0

ShaderEffect
{
    id: effect
    anchors.fill: parent
    anchors.centerIn: parent

    vertexShader: helper.readShader("underwater.vsh")
    fragmentShader: helper.readShader("underwater.fsh")

    property real resolutionX : screenPixelWidth
    property real resolutionY : screenPixelHeight
    property real time

    function currentTime() {
        var d = new Date();
        return d.getHours()*60000*60+ d.getMinutes()*60000+ d.getSeconds()*1000 + d.getMilliseconds();
    }
    Timer{
        interval: 10
        running: true
        repeat: true
        onTriggered: {
            time = currentTime() / 1000
        }
    }

}
