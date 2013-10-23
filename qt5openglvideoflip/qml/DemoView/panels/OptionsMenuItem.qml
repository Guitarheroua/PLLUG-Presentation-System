import QtQuick 2.0

Rectangle
{
    id: menuItemRect
    color: "grey"
    property alias propertyName: propertyNameText.text
    property alias propertyValue: propertyValueText.text
    property color unselectedItemColor: "grey"
    property bool selected: false
    Row
    {
        spacing: 10
        anchors.fill: parent
        Item
        {
            width: menuItemRect.width/2
            height: menuItemRect.height
            Text
            {
                id: propertyNameText
                anchors
                {
                    fill: parent
                    margins: 5
                }
                font.pointSize: 10
                color: "white"
            }
        }
        Item
        {
            width: menuItemRect.width/2
            height: menuItemRect.height
            TextEdit
            {
                id: propertyValueText
                focus: true
                anchors
                {
                    fill: parent
                    margins: 5
                }
                font.pointSize: 10
                color: "white"
            }
        }
    }
    MouseArea
    {
        anchors.fill: parent
        onClicked:
        {
            menuItemRect.selected = !menuItemRect.selected
            menuItemRect.color = (menuItemRect.selected ) ? Qt.darker(menuItemRect.color, 1.5) : unselectedItemColor
            //            if (slideOptionsModel.get(rect.ind).name === "Background")
            //            {
            //                if(menuItemRect.selected)
            //                {
            //                    presentation.addBackground(model.value)
            //                }
            //                else
            //                {
            //                    presentation.removeBackground(model.value)
            //                }
            //            }

            //            optionsPanelRect.state = "Closed"
        }
        //                                onPressed:
        //                                {
        //                                    rect1.color = Qt.darker(rect1.color, 0.25);
        //                                }
        //                                onReleased:
        //                                {
        //                                    rect1.color = Qt.lighter(rect1.color, 0.25);
        //                                }
    }
}
