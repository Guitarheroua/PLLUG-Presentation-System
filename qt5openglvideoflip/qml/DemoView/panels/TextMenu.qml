import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Item {
    id: rect
    width: parent.width
    height: delegateItemText.height+lineRect.height
    //        color: "transparent"
    property var selectedItem
    property int subItemHeight: 35
    onSelectedItemChanged:{
        fontFamiliesCombobox.currentIndex = (selectedItem !== undefined && selectedItem.textItem)
                ? helper.fontIndex(selectedItem.fontFamily) : 0
    }

    Text {
        id: delegateItemText
        text: "Font"
        color: "white"
        font {
            pointSize: 14
            bold: false
        }
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            subItemsRect.visible = !subItemsRect.visible
            rect.height = (subItemsRect.visible) ? rect.height + 25*3 + 10
                                                 : delegateItemText.height+lineRect.height
        }
    }

    Rectangle {
        id: lineRect
        anchors {
            top: delegateItemText.bottom
            left: parent.left
        }
        width: parent.width
        height: 3
        color: "steelblue"
    }
    Item {
        id: subItemsRect
        anchors {
            top: lineRect.bottom
            left: parent.left
        }
        visible: false
        Column {
            id: propertiesColumn
            anchors.fill: parent
            spacing: 2
            Row {
                spacing: 4.5
                ColorMenuItem {
                    id: colorMenuItem
                    width: rect.subItemHeight
                    height: rect.subItemHeight
                    selectedItemColor: (selectedItem !== null && selectedItem.textItem)
                                       ? selectedItem.fontColor : "black"
                    onHeightChanged: {
                        subItemsRect.height = (height === rect.subItemHeight) ? subItemsRect.height : subItemsRect.height + (height - subItemHeight)
                    }
                    onSelectedColorChanged: {
                        if (selectedItem !== undefined && selectedItem.textItem)
                        {
                            //                            if (selectedItem.textItem.selectedText === "")
                                selectedItem.fontColor = selectedColor
                            //                            else
                            //                            {
                            //                                var cursorPos = selectedItem.textItem.cursorPosition
                            //                                var selectedTextLength = selectedItem.textItem.selectedText.length

                            //                            }

                        }
                    }
                }
                ComboBox {
                    id: fontFamiliesCombobox
                    width: rect.subItemHeight*3 + 2*4.5
                    height: rect.subItemHeight
                    model: helper.fonts()

                    style: ComboBoxStyle {
                    background: Rectangle {
                        id: rectCategory
                        width: fontFamiliesCombobox.width
                        height: fontFamiliesCombobox.height
                        color: "gray"
                        Rectangle {
                            anchors {
                                fill: parent
                                margins: 5
                            }
                            color: "lightgray"
                        }
                    }

                    label: Item {
                        anchors.fill: parent
                        Text {
                            anchors {
                                fill: parent
                                margins: 5
                                verticalCenter: parent.verticalCenter
                            }
                            font.pointSize: 10
                            color: "black"
                            text: control.currentText
                            elide: Text.ElideRight
                        }
                    }
                }
                onCurrentTextChanged: {
                    if (selectedItem !== undefined && selectedItem.textItem)
                        selectedItem.fontFamily = currentText

                }
            }
            OptionsMenuItem {
                id: sizeMenuItem
                propertyName: ""
                propertyValue: (selectedItem !== null && selectedItem.textItem)
                               ? selectedItem.fontSize : 0
                width: rect.subItemHeight
                onPropertyValueChanged: {
                    if (selectedItem !== null && selectedItem.textItem) {
                        selectedItem.fontSize = parseFloat(propertyValue)
                    }
                }
            }
            ToolbarItem {
                id: fontSizeLessItem
                selectingItem: false
                imageSource: "qrc:///icons/text/size-less.png"
                width: rect.subItemHeight
                selected: false
                onSelectedChanged: {
                    if (selectedItem !== null && selectedItem.textItem)
                        selectedItem.fontSize -= 1
                }
            }
            ToolbarItem {
                id: fontSizeMoreItem
                selectingItem: false
                imageSource: "qrc:///icons/text/size-more.png"
                width: rect.subItemHeight
                selected: false
                onSelectedChanged: {
                    if (selectedItem !== null && selectedItem.textItem)
                        selectedItem.fontSize += 1
                }
            }

            ToolbarItem {
                id: boldItem
                imageSource: "qrc:///icons/text/bold.png"
                width: rect.subItemHeight
                selected: (selectedItem !== null && selectedItem.textItem)
                          ? selectedItem.fontBold : false
                onSelectedChanged: {
                    if (selectedItem !== null && selectedItem.textItem)
                        selectedItem.fontBold = selected
                }
            }

        }
        Row {
            spacing: 4.5
            ToolbarItem {
                id: italicItem
                imageSource: "qrc:///icons/text/italic.png"
                width: rect.subItemHeight
                height: rect.subItemHeight
                selected: (selectedItem !== null && selectedItem.textItem)
                          ? selectedItem.fontItalic : false
                onSelectedChanged: {
                    if (selectedItem !== null && selectedItem.textItem)
                        selectedItem.fontItalic = selected
                }
            }
            ToolbarItem {
                id: underlineItem
                imageSource: "qrc:///icons/text/underline.png"
                width: rect.subItemHeight
                selected: (selectedItem !== null && selectedItem.textItem)
                          ? selectedItem.fontUnderline : false
                onSelectedChanged: {
                    if (selectedItem !== null && selectedItem.textItem)
                        selectedItem.fontUnderline = selected
                }
            }
            ToolbarItem {
                id: strikeoutItem
                imageSource: "qrc:///icons/text/strikeout.png"
                width: rect.subItemHeight
                selected: (selectedItem !== null && selectedItem.textItem)
                          ? selectedItem.fontStrikeout : false
                onSelectedChanged: {
                    if (selectedItem !== null && selectedItem.textItem)
                        selectedItem.fontStrikeout = selected
                }
            }
            ToolbarItem {
                id: bulletsItem
                imageSource: "qrc:///icons/text/bullets.png"
                width: rect.subItemHeight
                selected: (selectedItem !== null && selectedItem.textItem) ?
                              selectedItem.bullets : false
                onSelectedChanged: {
                    if (selectedItem !== null && selectedItem.textItem) {
                        selectedItem.bullets = selected
                    }
                }
            }
        }
    }


}
}

