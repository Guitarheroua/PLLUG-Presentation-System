import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import "../panels"

//Item {
Rectangle {
    id: rect
    width: Math.round(subItemHeight*17) //*13
    height: Math.round(subItemHeight*1.2)  //delegateItemText.height+lineRect.height
    color: "#3C3C3C"
    //opacity: 0.7
    property var selectedItem
    property int subItemHeight: 25
    onSelectedItemChanged:{
        fontFamiliesCombobox.currentIndex = (selectedItem !== undefined && selectedItem.textItem)
                ? helper.fontIndex(selectedItem.fontFamily) : 0
    }

    MouseArea{
        anchors.fill: rect
        drag.target: rect
        drag.axis: Drag.XAndYAxis
    }

    Row {
        anchors.centerIn: rect
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
                    selectedItem.fontColor = selectedColor
                }
                selectedItemColor = selectedColor
            }
        }
        ComboBox {
            id: fontFamiliesCombobox
            width: rect.subItemHeight*4.5// + 2*4.5
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
                            margins: 1 //5
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

        ComboBox{
            id: fontSizeComboBox
            width: rect.subItemHeight*2.5
            height: rect.subItemHeight
            model: [ " ", 10, 11, 12, 14, 16, 18, 20, 22, 24, 26, 28, 32, 36, 40, 48, 56, 64, 72, 80]

            style: ComboBoxStyle {
                background: Rectangle {
                    id: rectFontSize
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
                            margins: 1 //5
                            verticalCenter: parent.verticalCenter
                        }
                        font.pointSize: 10
                        color: "black"
                        text: control.currentText
                        elide: Text.ElideRight
                    }
                }
            }

            OptionsMenuItem {
                        id: sizeMenuItem
                        visible: true
                        propertyName: (selectedItem !== null && selectedItem.textItem)
                                      ? Math.round(selectedItem.fontSize) : ""
                        width: rect.subItemHeight
                        }

            onCurrentTextChanged: {
                if (selectedItem !== undefined && selectedItem.textItem)
                {
                    selectedItem.fontSize = currentText
                    sizeMenuItem.visible = false
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
                {
                    selectedItem.fontSize -= 1
                    fontSizeComboBox.currentIndex = 0
                    sizeMenuItem.visible = true
                }
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
                {
                    selectedItem.fontSize += 1
                    fontSizeComboBox.currentIndex = 0
                    sizeMenuItem.visible = true
                }
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

