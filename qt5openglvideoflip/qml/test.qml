import QtQuick 2.0
import QtMultimedia 5.0

Rectangle
{
    id: maiRect
    width: 800
    height: 800
    color: "red"
    Rectangle
    {
        anchors
        {
            top: parent.top
            bottom: rect.top
        }
        width: parent.width
        z: 1
        ListView {
            anchors.fill: parent
            model: itemModel
            orientation: ListView.Horizontal
            spacing : 5
        }

    }
    VisualDataModel {
            id: itemModel
            model: filesModel
            delegate: Image {
                id: im1
                source: model.modelData
                width: 150
                height: 150

                MouseArea
                {
                    anchors.fill: parent
//                    drag.axis: Drag.XAndYAxis
                    drag.target: im1
                    onReleased:
                    {
                        console.log(filesModel.length)

                    }
                }
            }

        }


    Rectangle
    {
        id: rect
        color: "lightblue"
        width: maiRect.width
        height: 600
        anchors.bottom: parent.bottom
        border
        {
            color: "green"
            width: 1
        }
//        DropArea
//        {
//            anchors.fill: parent
//            onDropped:
//            {
//                console.log("dropped")
//            }
//            onEntered:
//            {
//                console.log("!!!!")
//            }
//            onExited:
//            {
//                console.log("~~~~")
//            }
//            onPositionChanged: {
//                console.log("pos")
//            }
//        }
    }

}
