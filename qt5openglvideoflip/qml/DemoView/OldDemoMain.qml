import QtQuick 2.4
import QtWebKit 3.0
import QtMultimedia 5.0

Rectangle
{
    id: mainRect
    objectName: "mainRect"
    color: "lightblue"
    width: 1280
    height: 720

//    StartScreen
//    {
//        id: startScreen
//    }

    MouseArea
    {
        id: mainRectMouseArea
        anchors.fill: parent
        acceptedButtons: Qt.AllButtons

        onClicked:
        {
            if ( mouse.button === Qt.RightButton )
            {
                if (mouseX > mainRect.width/2)
                {
                    effect.backAnim = false
                    anim.from = 90.0
                    anim.to = 270.0
                    if ( mainRect.children[effect.currentPage+1] )
                    {
                        mainRect.children[effect.currentPage].visible = true
                        mainRect.children[effect.currentPage+1].visible = true
                        sourceItem1.sourceItem = mainRect.children[effect.currentPage]
                        sourceItem2.sourceItem = mainRect.children[effect.currentPage+1]
                        anim.running = true
                    }
                }
                else
                {
                    effect.backAnim = true
                    anim.from = 270.0
                    anim.to = 90.0
                    if ( effect.currentPage > 2)
                    {
                        mainRect.children[effect.currentPage-1].visible = true
                        mainRect.children[effect.currentPage].visible = true
                        sourceItem1.sourceItem = mainRect.children[effect.currentPage-1]
                        sourceItem2.sourceItem = mainRect.children[effect.currentPage]
                        anim.running = true
                    }
                }


            }
            if ( mouse.button === Qt.LeftButton )
            {
                if ( mainRect.children[effect.currentPage].children[0].childAt(mouseX, mouseY).type === "video")
                {
                    mainRect.children[effect.currentPage].children[0].childAt(mouseX, mouseY).click(mouseX, mouseY)
                }

            }

        }


    }

    ShaderEffect
    {
        id: effect
        width: mainRect.width
        height: mainRect.height
        anchors.centerIn: parent
        property int currentPage: 2

        property variant source: ShaderEffectSource{
            id: sourceItem1
            sourceItem: (effect.currentPage < mainRect.children.length) ? mainRect.children[effect.currentPage] : null
            hideSource: true
        }
        property variant source1: ShaderEffectSource{
            id: sourceItem2
            sourceItem: (effect.currentPage+1 < mainRect.children.length) ? mainRect.children[effect.currentPage+1] : null
            hideSource: true
        }

        property real screenWidth : screenPixelWidth
        property real screenHeight : screenPixelHeight
        property real angle : 90.0
        property bool backAnim : false


        PropertyAnimation on angle
        {
            id: anim
            from: 90.0
            to: 270.0
            //            loops: Animation.Infinite
            running: false
            duration: 1000
            onRunningChanged:
            {
                if (!anim.running)
                {
                    if (! effect.backAnim )
                    {
                        mainRect.children[effect.currentPage].visible = false
                        effect.currentPage++;
                    }
                    else
                    {
                        mainRect.children[effect.currentPage].visible = false
                        effect.currentPage--;
                    }
                }
            }

        }
        vertexShader: vshader
        fragmentShader: fshader
    }
}
