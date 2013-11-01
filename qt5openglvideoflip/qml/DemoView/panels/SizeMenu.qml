import QtQuick 2.0

Item{
    id: sizeRect
    width: parent.width
    height: delegateItemText.height+lineRect.height
    //        color: "transparent"
    property var selectedItem
    property int subItemHeight: 25
    Text {
        id: delegateItemText
        text: "Size"
        color: "white"
        font
        {
            pointSize: 14
            bold: false
        }
    }
    MouseArea{
        anchors.fill: parent
        onClicked: {
            subItemsRect.visible = !subItemsRect.visible
            sizeRect.height = (subItemsRect.visible) ? sizeRect.height + 25*2 + 10 : delegateItemText.height+lineRect.height
        }
    }

    Rectangle
    {
        id: lineRect
        anchors
        {
            top: delegateItemText.bottom
            left: parent.left
        }
        width: parent.width
        height: 3
        color: "steelblue"
    }
    Item{
        id: subItemsRect
        anchors
        {
            top: lineRect.bottom
            left: parent.left
        }
        visible: false
        Column{
            id: propertiesColumn
            anchors.fill: parent
            spacing: 2
            OptionsMenuItem
            {
                propertyName: "Width"
                propertyValue: (sizeRect.selectedItem)? sizeRect.selectedItem.width : 0
                width: sizeRect.width
                height: sizeRect.subItemHeight
                onPropertyValueChanged:
                {
                    if (sizeRect.selectedItem)
                    {
                        var value = parseInt(propertyValue)
                        selectedItem.width = (!isNaN(value)) ? value : selectedItem.width
                    }
                }
            }
            OptionsMenuItem
            {
                propertyName: "Height"
                propertyValue: (sizeRect.selectedItem)? sizeRect.selectedItem.height : 0
                width: sizeRect.width
                height: sizeRect.subItemHeight
                onPropertyValueChanged:
                {
                    if (sizeRect.selectedItem)
                    {
                        var value = parseInt(propertyValue)
                        selectedItem.height = (!isNaN(value)) ? value : selectedItem.height
                    }
                }
            }


        }


    }

}
