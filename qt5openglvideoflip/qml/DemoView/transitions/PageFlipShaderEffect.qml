import QtQuick 2.0
import Qt.labs.presentation 1.0

ShaderEffect
{
    id: effect
    anchors.fill: parent
    anchors.centerIn: parent

    vertexShader: helper.readShader("flipPage.vsh")
    fragmentShader: helper.readShader("flipPage.fsh")
    property int currentSlide

    property variant source: ShaderEffectSource{
        id: sourceItem1
        sourceItem: ((effect.parent.slides != undefined) && effect.currentSlide < effect.parent.slides.length) ? effect.parent.slides[effect.currentSlide] : null
        hideSource: true
    }
    property variant source1: ShaderEffectSource{
        id: sourceItem2
        sourceItem: ((effect.parent.slides != undefined) && effect.currentSlide+1 < effect.parent.slides.length) ? effect.parent.slides[effect.currentSlide+1] : null
        hideSource: true
    }

    property real screenWidth : screenPixelWidth
    property real screenHeight : screenPixelHeight
    property real angle : 90.0
    property bool backAnim : false

    property alias running : anim.running
    property real defaultAnimationDuration : 1000
    property real minAnimationDuration : 200

    property int nextSlideIndex
    //    SequentialAnimation {
    //        id: anim
    //        property real duration: defaultAnimationDuration
    //             NumberAnimation { target: effect; property: "angle"; from:(backAnim) ? 270.0 : 90.0; to: (backAnim) ? 90.0 : 270.0; duration: anim.duration }
    //             NumberAnimation { target: effect; property: "angle"; from:(backAnim) ? 270.0 : 90.0; to: (backAnim) ? 90.0 : 270.0; duration: anim.duration }
    //             NumberAnimation { target: effect; property: "angle"; from:(backAnim) ? 270.0 : 90.0; to: (backAnim) ? 90.0 : 270.0; duration: anim.duration }
    //         }

    PropertyAnimation on angle
    {
        id: anim
        from: (backAnim) ? 270.0 : 90.0
        to: (backAnim) ? 90.0 : 270.0
        //            loops: Animation.Infinite
        running: false
        duration: defaultAnimationDuration
        onRunningChanged:
        {
            if (!anim.running)
            {
                if (!effect.backAnim )
                {
                    effect.parent.slides[effect.currentSlide].visible = false
                    effect.currentSlide = effect.nextSlideIndex;
                }
                else
                {
                    effect.parent.slides[effect.currentSlide].visible = false
                    effect.currentSlide = effect.nextSlideIndex;
                }
            }
        }

    }

    function goToNextSlide()
    {
        goToSlide(effect.currentSlide+1)
    }

    function goToPreviousSlide()
    {
        goToSlide(effect.currentSlide-1)
    }
    function goToSlide(index)
    {
        if (!anim.running)
        {
            effect.nextSlideIndex = index
            if (index < currentSlide)
            {
                effect.backAnim = true
                if ( effect.currentSlide > 0)
                {
                    effect.parent.slides[effect.nextSlideIndex].visible = true
                    sourceItem1.sourceItem = effect.parent.slides[effect.nextSlideIndex]
                    sourceItem2.sourceItem = effect.parent.slides[effect.currentSlide]
                    anim.start()
                }

            }
            else
            {
                effect.backAnim = false
                if ( effect.parent.slides[effect.nextSlideIndex] )
                {
                    effect.parent.slides[effect.nextSlideIndex].visible = true
                    sourceItem1.sourceItem = effect.parent.slides[effect.currentSlide]
                    sourceItem2.sourceItem = effect.parent.slides[effect.nextSlideIndex]
                    anim.start()
                }
            }
        }
    }

    //    MouseArea{
    //        anchors.fill:parent
    //        acceptedButtons: Qt.RightButton
    //        onClicked:
    //        {
    //            if ( mouse.button === Qt.RightButton )
    //            {
    //                if (mouseX > effect.parent.width/2)
    //                {
    //                    effect.goToNextSlide()
    //                }
    //                else
    //                {
    //                    effect.goToPreviousSlide()
    //                }

    //            }

    //        }
    //    }
}
