import QtQuick 2.0

Item{
    id: rect
    width: parent.width
    height: delegateItemText.height+lineRect.height
    //        color: "transparent"
    property var selectedItem
    property int subItemHeight: 35
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
            Row
            {
                spacing: 4.5
                ColorMenuItem
                {
                    width: rect.subItemHeight
                    height: rect.subItemHeight
                    selectedItemColor: (selectedItem != null && selectedItem.textItem) ? selectedItem.textItem.color : "black"
                    onHeightChanged:
                    {
                        subItemsRect.height = (height === rect.subItemHeight) ? subItemsRect.height : subItemsRect.height + (height - subItemHeight)
                    }
                    onSelectedColorChanged:
                    {
                        console.log(selectedItem.textItem.cursorPosition)
                        if (selectedItem != null && selectedItem.textItem)
                        {
                            if (selectedItem.textItem.selectedText === "")
                            {
                                selectedItem.textItem.color = selectedColor
                            }
                            else
                            {
                                var cursorPos = selectedItem.textItem.cursorPosition
                                var selectedTextLength = selectedItem.textItem.selectedText.length

                            }

                        }
                    }
                }
                OptionsMenuItem
                {
                    propertyName: ""
                    propertyValue: (selectedItem != null && selectedItem.textItem) ? selectedItem.textItem.font.pointSize : 0
                    width: rect.subItemHeight
                    height: rect.subItemHeight
                    onPropertyValueChanged:
                    {
                        if (selectedItem != null && selectedItem.textItem)
                        {
                            selectedItem.textItem.font.pointSize = parseFloat(propertyValue)
                        }
                    }
                }
                ToolbarItem
                {
                    id: fontSizeLessItem
                    imageSource: "qrc:///icons/text/size-less.png"
                    width: rect.subItemHeight
                    height: rect.subItemHeight
                    selected: false
                    onSelectedChanged:
                    {
                        if (selectedItem != null && selectedItem.textItem)
                            selectedItem.textItem.font.pointSize -= 1
                    }
                }
                ToolbarItem
                {
                    id: fontSizeMoreItem
                    imageSource: "qrc:///icons/text/size-more.png"
                    width: rect.subItemHeight
                    height: rect.subItemHeight
                    selected: false
                    onSelectedChanged:
                    {
                        if (selectedItem != null && selectedItem.textItem)
                            selectedItem.textItem.font.pointSize += 1
                    }
                }

                ToolbarItem
                {
                    id: boldItem
                    imageSource: "qrc:///icons/text/bold.png"
                    width: rect.subItemHeight
                    height: rect.subItemHeight
                    selected: (selectedItem != null && selectedItem.textItem) ? selectedItem.textItem.font.bold : false
                    onSelectedChanged:
                    {
                        if (selectedItem != null && selectedItem.textItem)
                            selectedItem.textItem.font.bold = selected
                    }
                }
                ToolbarItem
                {
                    id: italicItem
                    imageSource: "qrc:///icons/text/italic.png"
                    width: rect.subItemHeight
                    height: rect.subItemHeight
                    selected: (selectedItem != null && selectedItem.textItem) ? selectedItem.textItem.font.italic : false
                    onSelectedChanged:
                    {
                        if (selectedItem != null && selectedItem.textItem)
                            selectedItem.textItem.font.italic = selected
                    }
                }
                ToolbarItem
                {
                    id: underlineItem
                    imageSource: "qrc:///icons/text/underline.png"
                    width: rect.subItemHeight
                    height: rect.subItemHeight
                    selected: (selectedItem != null && selectedItem.textItem) ? selectedItem.textItem.font.underline : false
                    onSelectedChanged:
                    {
                        if (selectedItem != null && selectedItem.textItem)
                            selectedItem.textItem.font.underline = selected
                    }
                }
                ToolbarItem
                {
                    id: strikeoutItem
                    imageSource: "qrc:///icons/text/strikeout.png"
                    width: rect.subItemHeight
                    height: rect.subItemHeight
                    selected: (selectedItem != null && selectedItem.textItem) ? selectedItem.textItem.font.strikeout : false
                    onSelectedChanged:
                    {
                        if (selectedItem != null && selectedItem.textItem)
                            selectedItem.textItem.font.strikeout = selected
                    }
                }
            }
        }


    }

}


//}
