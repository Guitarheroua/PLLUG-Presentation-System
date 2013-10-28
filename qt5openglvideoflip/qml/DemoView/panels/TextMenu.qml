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
                    selectedItemColor: "darkred"
                    onHeightChanged:
                    {
                        subItemsRect.height = (height === rect.subItemHeight) ? subItemsRect.height : subItemsRect.height + (height - subItemHeight)
                    }
                }
                OptionsMenuItem
                {
                    propertyName: "Size"
                    propertyValue: "12"
                    width: rect.width
                    height: rect.subItemHeight
                }
                OptionsMenuItem
                {
                    propertyName: "Bold"
                    propertyValue: "false"
                    width: rect.width
                    height: rect.subItemHeight
                }
            }


        }

    }


//}
