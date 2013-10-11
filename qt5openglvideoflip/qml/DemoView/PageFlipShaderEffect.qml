import QtQuick 2.0
import Qt.labs.presentation 1.0

ShaderEffect
{
    id: effect
    anchors.fill: parent
    anchors.centerIn: parent
    property int currentSlide

    property variant source: ShaderEffectSource{
        id: sourceItem1
        sourceItem: (effect.currentSlide < effect.parent.slides.length) ? effect.parent.slides[effect.currentSlide] : null
        hideSource: true
    }
    property variant source1: ShaderEffectSource{
        id: sourceItem2
        sourceItem: (effect.currentSlide+1 < effect.parent.slides.length) ? effect.parent.slides[effect.currentSlide+1] : null
        hideSource: true
    }

    property real screenWidth : screenPixelWidth
    property real screenHeight : screenPixelHeight
    property real angle : 90.0
    property bool backAnim : false

    property alias running : anim.running
    property real defaultAnimationDuration : 1000
    property real minAnimationDuration : 200

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
                    effect.currentSlide++;
                }
                else
                {
                    effect.parent.slides[effect.currentSlide].visible = false
                    effect.currentSlide--;
                }
            }
        }

    }

    function goToNextSlide()
    {
        effect.backAnim = false
        if ( effect.parent.slides[effect.currentSlide+1] )
        {
            effect.parent.slides[effect.currentSlide].visible = true
            effect.parent.slides[effect.currentSlide+1].visible = true
            sourceItem1.sourceItem = effect.parent.slides[effect.currentSlide]
            sourceItem2.sourceItem = effect.parent.slides[effect.currentSlide+1]
            anim.start()
        }
    }

    function goToPreviousSlide()
    {
        effect.backAnim = true
        if ( effect.currentSlide > 0)
        {
            effect.parent.slides[effect.currentSlide-1].visible = true
            effect.parent.slides[effect.currentSlide].visible = true
            sourceItem1.sourceItem = effect.parent.slides[effect.currentSlide-1]
            sourceItem2.sourceItem = effect.parent.slides[effect.currentSlide]
            anim.start()
        }
    }
    function goToSlide(index)
    {
        //        anim.duration = minAnimationDuration
        //        if (index < currentSlide)
        //        {
        //            while (currentSlide != index)
        //            {
        //                while(!anim.running)
        //                    goToPreviousSlide()
        //            }

        //        }
        //        else
        //        {
        //            while (currentSlide != index)
        //            {
        //                console.log("`````")
        //                while(!anim.running)
        //                {
        //                    console.log("******")
        //                    goToNextSlide()
        //                }
        //            }
        //        }
        //        anim.duration = defaultAnimationDuration
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
