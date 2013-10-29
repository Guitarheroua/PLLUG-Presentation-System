import QtQuick 2.0

//Item {
//    id: textMenuItem
//    width: parent.width
//    height: 200

    Item{
        id: rect
        width: parent.width
        height: delegateItemText.height+lineRect.height
//        color: "transparent"
        property var selectedItem
        property int subItemHeight: 25
        Text {
            id: delegateItemText
            text: "Font"
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
                rect.height = (subItemsRect.visible) ? rect.height + 25*3 + 10 : delegateItemText.height+lineRect.height
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
                ColorMenuItem
                {
                    width: rect.width
                    height: rect.subItemHeight
                    selectedItemColor: (selectedItem != null && selectedItem.textItem) ? selectedItem.textItem.color : "black"
                    onHeightChanged:
                    {
                        subItemsRect.height = (height === rect.subItemHeight) ? subItemsRect.height : subItemsRect.height + (height - subItemHeight)
                    }
                    onSelectedColorChanged:
                    {
                        selectedItem.textItem.color = selectedColor
                    }
                }
                OptionsMenuItem
                {
                    propertyName: "Size"
                    propertyValue: (selectedItem != null && selectedItem.textItem) ? selectedItem.textItem.font.pointSize : 0
                    width: rect.width
                    height: rect.subItemHeight
                    onPropertyValueChanged:
                    {
                        selectedItem.textItem.font.pointSize = parseFloat(propertyValue)
                    }
                }
                OptionsMenuItem
                {
                    propertyName: "Bold"
                    propertyValue: (selectedItem != null && selectedItem.textItem) ? selectedItem.textItem.font.bold : 0
                    width: rect.width
                    height: rect.subItemHeight
                }
            }


        }

    }


//}
