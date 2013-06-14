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
            id: listView
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
                source: model.modelData
                width: 150
                height: 150
                Drag.keys: "key"
                Drag.active: mouseArea.drag.active
                Drag.proposedAction: Qt.CopyAction
                Drag.supportedActions: Qt.CopyAction

                MouseArea
                {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    drag.axis: Drag.XAndYAxis
                    drag.target: parent
                    onReleased:
                    {
                        console.log(parent.Drag.drop())
                        console.log(parent.x,parent.y)

                    }
                    onPressAndHold:
                    {
                        console.log("AAA")
                        im1.Drag.start(Qt.CopyAction)
                    }
                    onPressed:
                    {
                        console.log("#####")

                    }
                    onEntered:
                    {
                        cursorShape = Qt.OpenHandCursor
                        console.log("ENTER")
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
        DropArea
        {
            id: dropArea
            anchors.fill: parent
            keys: "key"

            onDropped:
            {
                console.log("dropped")
                console.log(dropArea)
                listView.itemAt(10,10).source = ""
            }
            onEntered:
            {
                console.log("!!!!")
            }
            onExited:
            {
                console.log("~~~~")
            }
            onPositionChanged: {
                console.log("pos")
//                console.log(drag.x,drag.y,listView.childAt(drag.x,drag.y),drag.source)
            }
        }
    }

}
