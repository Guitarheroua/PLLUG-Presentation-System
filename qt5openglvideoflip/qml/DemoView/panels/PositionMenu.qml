import QtQuick 2.0

Item{
    id: positionRect
    width: parent.width
    height: delegateItemText.height+lineRect.height
    //        color: "transparent"
    property var selectedItem
    property int subItemHeight: 25
    Text {
        id: delegateItemText
        text: "Position"
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
            positionRect.height = (subItemsRect.visible) ? positionRect.height + 25*4 + 10 : delegateItemText.height+lineRect.height
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
                propertyName: "X"
                propertyValue: (positionRect.selectedItem)? positionRect.selectedItem.x : 0
                width: positionRect.width
                height: positionRect.subItemHeight
                onPropertyValueChanged:
                {
                    if (positionRect.selectedItem)
                    {
                        var value = parseInt(propertyValue)
                        selectedItem.x = (!isNaN(value)) ? value : selectedItem.x
                    }
                }
            }
            OptionsMenuItem
            {
                propertyName: "Y"
                propertyValue: (positionRect.selectedItem)? positionRect.selectedItem.y : 0
                width: positionRect.width
                height: positionRect.subItemHeight
                onPropertyValueChanged:
                {
                    if (positionRect.selectedItem)
                    {
                        var value = parseInt(propertyValue)
                        selectedItem.y = (!isNaN(value)) ? value : selectedItem.y
                    }
                }
            }
            OptionsMenuItem
            {
                propertyName: "Z"
                propertyValue: (positionRect.selectedItem)? positionRect.selectedItem.z : 0
                width: positionRect.width
                height: positionRect.subItemHeight
                onPropertyValueChanged:
                {
                    if (positionRect.selectedItem)
                    {
                        var value = parseInt(propertyValue)
                        selectedItem.z = (!isNaN(value)) ? value : selectedItem.z
                    }
                }
            }
            OptionsMenuItem
            {
                propertyName: "Angle"
                propertyValue: (positionRect.selectedItem)? positionRect.selectedItem.rotation : 0
                width: positionRect.width
                height: positionRect.subItemHeight
                onPropertyValueChanged:
                {
                    if (positionRect.selectedItem)
                    {
                        var value = parseInt(propertyValue)
                        selectedItem.rotation = (!isNaN(value)) ? value : selectedItem.rotation
                    }
                }
            }

        }


    }

}
