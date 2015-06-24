import QtQuick 2.4

Item {
    id: codeItem
    property string code
    visible: (code != "")

    onCodeChanged: {
        listModel.clear()
        var codeLines = slide.code.split("\n")
        for (var i=0; i<codeLines.length; ++i) {
            listModel.append({
                                 line: i,
                                 code: codeLines[i]
                             })
        }
    }
    Rectangle {
        id: codeItemBackground
        anchors.fill: parent
        radius: height / 10
        gradient: Gradient {
            GradientStop { position: 0; color: Qt.rgba(0.8, 0.8, 0.8, 0.5); }
            GradientStop { position: 1; color: Qt.rgba(0.2, 0.2, 0.2, 0.5); }
        }
        border.color: codeItem.parent.textColor
        border.width: height / 250
        antialiasing: true
    }


    onVisibleChanged: {
        listView.focus = codeItem.parent.visible
        listView.currentIndex = -1
    }

    ListModel {
        id: listModel
    }

    ListView {
        id: listView

        anchors.fill: parent;
        anchors.margins: codeItemBackground.radius / 2
        clip: true

        model: listModel
        focus: true

        MouseArea {
            anchors.fill: parent
            onClicked: {
                listView.focus = true
                listView.currentIndex = listView.indexAt(mouse.x, mouse.y + listView.contentY)
            }

        }

        delegate: Item {

            id: itemDelegate

            height: lineLabel.height
            width: parent.width

            Rectangle {
                id: lineLabelBackground
                width: lineLabel.height * 3
                height: lineLabel.height
                color: codeItem.parent.textColor
                opacity: 0.1
            }

            Text {
                id: lineLabel
                anchors.right: lineLabelBackground.right
                text: (line+1) + ":"
                color: codeItem.parent.textColor
                font.family: codeItem.parent.codeFontFamily
                font.pixelSize: codeItem.parent.codeFontSize
                font.bold: itemDelegate.ListView.isCurrentItem
                opacity: itemDelegate.ListView.isCurrentItem ? 1 : 0.9

            }

            Rectangle {
                id: lineContentBackground
                anchors.fill: lineContent
                anchors.leftMargin: -height / 2
                color: codeItem.parent.textColor
                opacity: 0.2
                visible: itemDelegate.ListView.isCurrentItem
            }

            Text {
                id: lineContent
                anchors.left: lineLabelBackground.right
                anchors.leftMargin: lineContent.height
                anchors.right: parent.right
                color: codeItem.parent.textColor
                text: code;
                font.family: codeItem.parent.codeFontFamily
                font.pixelSize: codeItem.parent.codeFontSize
                font.bold: itemDelegate.ListView.isCurrentItem
                opacity: itemDelegate.ListView.isCurrentItem ? 1 : 0.9
            }
        }
    }
}

