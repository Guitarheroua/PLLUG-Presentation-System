import QtQuick 2.0
import Qt.labs.presentation 1.0

ShaderEffect
{
    id: effect
    anchors.fill: parent
    anchors.centerIn: parent
    property int currentPage

    property variant source: ShaderEffectSource{
        id: sourceItem1
        sourceItem: (effect.currentPage < effect.parent.slides.length) ? effect.parent.slides[effect.currentPage] : null
        hideSource: true
    }
    property variant source1: ShaderEffectSource{
        id: sourceItem2
        sourceItem: (effect.currentPage+1 < effect.parent.slides.length) ? effect.parent.slides[effect.currentPage+1] : null
        hideSource: true
    }

    property real screenWidth : screenPixelWidth
    property real screenHeight : screenPixelHeight
    property real angle : 90.0
    property bool backAnim : false

    PropertyAnimation on angle
    {
        id: anim
        from: (backAnim) ? 270.0 : 90.0
        to: (backAnim) ? 90.0 : 270.0
        //            loops: Animation.Infinite
        running: false
        duration: 1000
        onRunningChanged:
        {
            if (!anim.running)
            {
                if (!effect.backAnim )
                {
                    effect.parent.slides[effect.currentPage].visible = false
                    effect.currentPage++;
                }
                else
                {
                    effect.parent.slides[effect.currentPage].visible = false
                    effect.currentPage--;
                }
            }
        }

    }

    MouseArea{
        anchors.fill:parent
        acceptedButtons: Qt.RightButton
        onClicked:
        {
            if ( mouse.button === Qt.RightButton )
            {
                if (mouseX > effect.parent.width/2)
                {
                    effect.backAnim = false
                    if ( effect.parent.slides[effect.currentPage+1] )
                    {
                        effect.parent.slides[effect.currentPage].visible = true
                        effect.parent.slides[effect.currentPage+1].visible = true
                        sourceItem1.sourceItem = effect.parent.slides[effect.currentPage]
                        sourceItem2.sourceItem = effect.parent.slides[effect.currentPage+1]
                        anim.running = true
                    }
                }
                else
                {
                    effect.backAnim = true
                    if ( effect.currentPage > 0)
                    {
                        effect.parent.slides[effect.currentPage-1].visible = true
                        effect.parent.slides[effect.currentPage].visible = true
                        sourceItem1.sourceItem = effect.parent.slides[effect.currentPage-1]
                        sourceItem2.sourceItem = effect.parent.slides[effect.currentPage]
                        anim.running = true
                    }
                }

            }

        }
    }
}
