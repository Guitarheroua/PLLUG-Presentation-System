import QtQuick 2.0

Rectangle {
    id: panel
    width: 100
    height: parent.height
    color: "grey"

    ListModel
    {
        ListElement
        {
            name: "Background "
        }

    }

    Component
    {
        id: sectionHeading
        Rectangle {
            width: panel.width
            height: childrenRect.height
            color: "lightsteelblue"

            Text {
                text: section
                font.bold: true
                font.pixelSize: 20
            }
        }
    }

    ListView
    {
        anchors.fill: parent

    }
}
