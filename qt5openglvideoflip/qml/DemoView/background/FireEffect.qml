import QtQuick 2.0

ShaderEffect
{
    id: effect
    anchors.fill: parent
    anchors.centerIn: parent

    vertexShader: helper.readShader("fire.vsh")
    fragmentShader: helper.readShader("fire.fsh")

    property real resolutionX : screenPixelWidth
    property real resolutionY : screenPixelHeight
    property real time

    function currentTime() {
        var d = new Date();
        return d.getMinutes()*60000+ d.getSeconds()*1000 + d.getMilliseconds();
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
