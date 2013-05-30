import QtQuick 2.0
import QtWebKit 3.0
import QtMultimedia 5.0
//import CustomComponents 1.0

Rectangle
{
    id: mainRect
    objectName: "mainRect"
    width: 800
    height: 800
    color: "gray"
    MouseArea
    {
        id: mainRectMouseArea
        anchors.fill: parent
        acceptedButtons: Qt.AllButtons
        onPressed:
        {


        }

        onClicked:
        {
            if ( mouse.button === Qt.RightButton )
            {
                anim.running = true
                mainRect.children[effect.currentPage].visible = true
                mainRect.children[effect.currentPage+1].visible = true
                sourceItem1.sourceItem = mainRect.children[effect.currentPage]
                sourceItem2.sourceItem = mainRect.children[effect.currentPage+1]
            }
            if ( mouse.button === Qt.LeftButton )
            {
                if ( mainRect.children[effect.currentPage].children[0].childAt(mouseX, mouseY).type === "video")
                {
                    mainRect.children[effect.currentPage].children[0].childAt(mouseX, mouseY).click(mouseX, mouseY)
                }

            }

        }

        onDoubleClicked:
        {
            if ( mainRect.children[effect.currentPage].children[0].childAt(mouseX, mouseY) )
            {
                var item = mainRect.children[effect.currentPage].children[0].childAt(mouseX,mouseY);
                if (item.width === mainRect.width  && item.height === mainRect.height)
                {
                    item.x = item.mainX
                    item.y = item.mainY
                    item.z = 0
                    item.width = item.mainWidth
                    item.height = item.mainHeight
                }

                else
                {
                    item.x = 0
                    item.y = 0
                    item.z = 10
                    item.width = mainRect.width
                    item.height = mainRect.height

                }
            }

        }
    }
    onChildrenChanged:
    {
    }

    //ListView
    //{
    //    anchors.fill: parent
    //    model: pagesModel
    //}

    ShaderEffect
    {
        id: effect
        width: mainRect.width
        height: mainRect.height
        anchors.centerIn: parent
        property int currentPage: 2
        property variant source: ShaderEffectSource{
            id: sourceItem1
            sourceItem: mainRect.children[effect.currentPage]
            hideSource: true
        }
        property variant source1: ShaderEffectSource{
            id: sourceItem2
            sourceItem: mainRect.children[effect.currentPage+1]
            hideSource: true
        }

        property real angle : 90.0

        PropertyAnimation on angle
        {
            id: anim
            from: 90.0
            to: 270.0
            //            loops: Animation.Infinite
            running: false
            duration: 3000
            onRunningChanged:
            {
                if (!anim.running)
                {
                    mainRect.children[effect.currentPage].visible = false
                    effect.currentPage++;
                }
            }

        }
        vertexShader: vshader
        fragmentShader: fshader
    }
}
