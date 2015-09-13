import QtQuick 2.3

Item
{
    id: idResizeMainItem
    x: -500
    y: -500
    z: -1



    property int pointWidth: 10
    property int pointHeight: 10
    property string dotColor: "black"
    property int clickedXInHandle: 0
    property int clickedYInHandle: 0
    property Item target: null



    Rectangle{
        id: dragHandleRect
        anchors.centerIn: parent
        color: "lightsteelblue"
        width: parent.width + pointWidth
        height: parent.height + pointHeight
        MouseArea {
            id: dragHandle
            drag.target: target
            drag.axis: Drag.XAndYAxis
            anchors.fill: parent
            drag.threshold: 0
            cursorShape: Qt.SizeAllCursor
        }
    }
    Item{
        id: rotateItem
        height: pointHeight * 4
        anchors.bottom: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        Rectangle{
            id: rotateRect
            property int angle: 0
            color: "transparent"
            Image{
                anchors.fill: parent
                source: "qrc:/icons/resources/icons/rotateIcon.png"

            }

            width: 20
            height: 20
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter

            MouseArea{
                anchors.fill: parent;
                onPositionChanged:  {
                    hiddenRotateCenter.x = idResizeMainItem.x
                    hiddenRotateCenter.y = idResizeMainItem.y
                    hiddenRotateCenter.width = idResizeMainItem.width
                    hiddenRotateCenter.height = idResizeMainItem.height
                    var point =  mapToItem (hiddenRotateCenter, mouse.x, mouse.y);
                    var diffX = (point.x - hiddenRotateCenter.width / 2);
                    var diffY = -(point.y - hiddenRotateCenter.height / 2);
                    var rad = Math.atan (diffY / diffX);
                    var deg = Math.abs(rad * 180 / Math.PI);

                    if (diffX > 0 && diffY > 0) {
                        rotateRect.angle = 90 - deg;
                    }
                    else if (diffX > 0 && diffY < 0) {
                        rotateRect.angle = 90 + deg;

                    }
                    else if (diffX < 0 && diffY > 0) {
                        rotateRect.angle = 270 + deg;

                    }
                    else if (diffX < 0 && diffY < 0) {
                        rotateRect.angle = 270 - deg;

                    }
                    target.rotation = rotateRect.angle;
                    idResizeMainItem.rotation = rotateRect.angle;

                }
            }
        }
    }
    MouseArea {
        id: topHandle
        width: pointWidth
        height: pointHeight
        x: parent.width / 2 - pointWidth / 2
        anchors.bottom: parent.top
        drag.target: topHandle
        drag.axis: Drag.YAxis
        cursorShape: Qt.SizeVerCursor
        onPressed:
        {
            positionAnchorHook.anchors.bottom = target.bottom
            target.anchors.bottom = positionAnchorHook.bottom

            clickedYInHandle = pointHeight - mouseY

        }

        onReleased:
        {
            target.anchors.bottom = undefined
            positionAnchorHook.anchors.bottom = undefined
        }

        onPositionChanged:
        {
            var mouseToPlaceholder = mapToItem(positionAnchorHook, mouseX, mouseY)
            var newHeight = -mouseToPlaceholder.y - clickedYInHandle

            if(newHeight >= pointHeight * 2)
                target.height = newHeight
        }

        ResizeDot{

        }
    }
    MouseArea {
        id: botHandle
        width: pointWidth
        height: pointHeight
        x: parent.width / 2 - pointWidth/ 2
        anchors.top: parent.bottom
        drag.target: botHandle
        drag.axis: Drag.YAxis
        cursorShape: Qt.SizeVerCursor
        onPressed:
        {
            positionAnchorHook.anchors.top = target.top

            target.anchors.top = positionAnchorHook.top

            clickedYInHandle = mouseY
        }

        onReleased:
        {
            target.anchors.top = undefined
            positionAnchorHook.anchors.top = undefined
        }

        onPositionChanged:
        {
            var mouseToPlaceholder = mapToItem(positionAnchorHook, mouseX, mouseY)
            var newHeight = mouseToPlaceholder.y - clickedYInHandle

            if(newHeight >= pointHeight * 2){
                target.height = newHeight

            }
        }

        ResizeDot{

        }
    }
    MouseArea {
        id: leftHandle
        width: pointWidth
        height: pointHeight
        y: parent.height / 2 - pointHeight / 2
        anchors.right: parent.left
        drag.target: leftHandle
        drag.axis: Drag.XAxis
        cursorShape: Qt.SizeHorCursor
        onPressed:
        {
            positionAnchorHook.anchors.right = target.right
            target.anchors.right = positionAnchorHook.right

            clickedXInHandle = pointWidth - mouseX
        }

        onReleased:
        {
            positionAnchorHook.anchors.right = undefined
            target.anchors.right = undefined
        }

        onPositionChanged:
        {
            var mouseToPlaceholder = mapToItem(positionAnchorHook, mouseX, mouseY)
            var newWidth = -mouseToPlaceholder.x - clickedXInHandle

            if(newWidth >= pointWidth * 2)
                target.width = newWidth
        }

        ResizeDot{

        }
    }
    MouseArea {
        id: rightHandle
        width: pointWidth
        height: pointHeight
        y: parent.height / 2 - pointHeight/ 2
        anchors.left: parent.right
        drag.target: rightHandle
        drag.axis: Drag.XAxis

        cursorShape: Qt.SizeHorCursor
        onPressed:
        {
            positionAnchorHook.anchors.left = target.left

            target.anchors.left = positionAnchorHook.left

            clickedXInHandle = mouseX
        }

        onReleased:
        {
            target.anchors.left = undefined
            positionAnchorHook.anchors.left = undefined
        }

        onPositionChanged:
        {
            var mouseToPlaceholder = mapToItem(positionAnchorHook, mouseX, mouseY)
            var newWidth = mouseToPlaceholder.x - clickedXInHandle

            if(newWidth >= pointWidth * 2)
                target.width = newWidth
        }

        ResizeDot{

        }
    }
    MouseArea {
        id: leftTopHandle
        width: pointWidth
        height: pointHeight
        anchors.right: parent.left
        anchors.bottom: parent.top
        drag.target: topHandle
        drag.axis: Drag.YAxis
        cursorShape: Qt.SizeFDiagCursor
        onPressed:
        {
            positionAnchorHook.anchors.bottom = target.bottom
            positionAnchorHook.anchors.right = target.right
            target.anchors.bottom = positionAnchorHook.bottom
            target.anchors.right = positionAnchorHook.right

            clickedXInHandle = pointWidth - mouseX
            clickedYInHandle = pointHeight - mouseY

        }

        onReleased:
        {
            target.anchors.bottom = undefined
            target.anchors.right = undefined
            positionAnchorHook.anchors.bottom = undefined
            positionAnchorHook.anchors.right = undefined
        }

        onPositionChanged:
        {
            var mouseToPlaceholder = mapToItem(positionAnchorHook, mouseX, mouseY)
            var newHeight = -mouseToPlaceholder.y - clickedYInHandle
            var newWidth = -mouseToPlaceholder.x - clickedXInHandle

            if(newHeight >= pointHeight * 2)
            {
                target.height = newHeight
            }
            if(newWidth >= pointWidth * 2)
            {
                target.width = newWidth
            }
        }

        ResizeDot{

        }
    }
    MouseArea {
        id: rightTopHandle
        width: pointWidth
        height: pointHeight
        anchors.left: parent.right
        anchors.bottom: parent.top
        drag.target: topHandle
        drag.axis: Drag.YAxis
        cursorShape: Qt.SizeBDiagCursor

        onPressed:
        {
            positionAnchorHook.anchors.bottom = target.bottom
            positionAnchorHook.anchors.left = target.left
            target.anchors.bottom = positionAnchorHook.bottom
            target.anchors.left = positionAnchorHook.left

            clickedXInHandle = mouseX
            clickedYInHandle = pointHeight - mouseY

        }

        onReleased:
        {
            target.anchors.bottom = undefined
            target.anchors.left = undefined
            positionAnchorHook.anchors.bottom = undefined
            positionAnchorHook.anchors.left = undefined
        }

        onPositionChanged:
        {
            var mouseToPlaceholder = mapToItem(positionAnchorHook, mouseX, mouseY)
            var newHeight = -mouseToPlaceholder.y - clickedYInHandle
            var newWidth = mouseToPlaceholder.x - clickedXInHandle

            if(newHeight >= pointHeight * 2)
            {
                target.height = newHeight
            }
            if(newWidth >= pointWidth * 2)
            {
                target.width = newWidth
            }
        }
        ResizeDot{

        }
    }
    MouseArea {
        id: leftBotHandle
        width: pointWidth
        height: pointHeight
        anchors.right: parent.left
        anchors.top: parent.bottom
        drag.target: topHandle
        drag.axis: Drag.YAxis
        cursorShape: Qt.SizeBDiagCursor

        onPressed:
        {
            positionAnchorHook.anchors.top = target.top
            positionAnchorHook.anchors.right = target.right
            target.anchors.top = positionAnchorHook.top
            target.anchors.right = positionAnchorHook.right

            clickedXInHandle = pointWidth - mouseX
            clickedYInHandle = mouseY

        }

        onReleased:
        {
            target.anchors.top = undefined
            target.anchors.right = undefined
            positionAnchorHook.anchors.top = undefined
            positionAnchorHook.anchors.right = undefined
        }

        onPositionChanged:
        {
            var mouseToPlaceholder = mapToItem(positionAnchorHook, mouseX, mouseY)
            var newHeight = mouseToPlaceholder.y - clickedYInHandle
            var newWidth = -mouseToPlaceholder.x - clickedXInHandle

            if(newHeight >= pointHeight * 2)
            {
                target.height = newHeight
            }
            if(newWidth >= pointWidth * 2)
            {
                target.width = newWidth
            }
        }
        ResizeDot{

        }

    }
    MouseArea {
        id: rightBotHandle
        width: pointWidth
        height: pointHeight
        anchors.left: parent.right
        anchors.top: parent.bottom
        drag.target: topHandle
        drag.axis: Drag.YAxis
        cursorShape: Qt.SizeFDiagCursor

        onPressed:
        {
            positionAnchorHook.anchors.top = target.top
            positionAnchorHook.anchors.left = target.left
            target.anchors.top = positionAnchorHook.top
            target.anchors.left = positionAnchorHook.left

            clickedXInHandle = mouseX
            clickedYInHandle = mouseY

        }

        onReleased:
        {
            target.anchors.top = undefined
            target.anchors.left = undefined
            positionAnchorHook.anchors.top = undefined
            positionAnchorHook.anchors.left = undefined
        }

        onPositionChanged:
        {
            var mouseToPlaceholder = mapToItem(positionAnchorHook, mouseX, mouseY)
            var newHeight = mouseToPlaceholder.y - clickedYInHandle
            var newWidth = mouseToPlaceholder.x - clickedXInHandle

            if(newHeight >= pointHeight * 2)
            {
                target.height = newHeight
            }
            if(newWidth >= pointWidth * 2)
            {
                target.width = newWidth
            }
        }

        ResizeDot{

        }
    }


}
