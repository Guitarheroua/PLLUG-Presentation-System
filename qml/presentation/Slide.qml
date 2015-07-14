/****************************************************************************
**
** Copyright (C) 2012 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QML Presentation System.
**
** $QT_BEGIN_LICENSE:LGPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Digia.  For licensing terms and
** conditions see http://qt.digia.com/licensing.  For further information
** use the contact form at http://qt.digia.com/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Digia gives you certain additional
** rights.  These rights are described in the Digia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3.0 as published by the Free Software
** Foundation and appearing in the file LICENSE.GPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU General Public License version 3.0 requirements will be
** met: http://www.gnu.org/copyleft/gpl.html.
**
**
** $QT_END_LICENSE$
**
****************************************************************************/


import QtQuick 2.4
import "../items"

Item {
    /*
      Slides can only be instantiated as a direct child of a Presentation {} as they rely on
      several properties there.
     */

    id: slide

    property bool isSlide: true
    property bool enableEdit: helper.enableEdit()

    property string title : ""
    property variant content: []
    property string layout: ""
    property string centeredText
    property string writeInText;
    property string notes

    property variant transitions: []

    property string codeFontFamily: (parent)? parent.codeFontFamily : ""
    property string code
    property real codeFontSize: baseFontSize * 0.6

    property real fontSize: (parent) ? parent.height * 0.05 : 0
    property real fontScale: 1

    property real baseFontSize: fontSize * fontScale
    property real titleFontSize: fontSize * 1.12 * fontScale
    property real bulletSpacing: 1

    //    property real contentWidth: width

    property real topTitleMargin: (parent) ? parent.height * 0.04 : 0

    property real contentX: (parent) ? parent.width * 0.05 : 0
    property real contentY: (parent) ? parent.height * 0.2 : 0
    property real contentWidth:  (parent) ? parent.width * 0.9 : 0
    property real contentHeight: (parent) ? parent.height * 0.7 : 0


    property real masterWidth: (parent) ? parent.width : 0
    property real masterHeight: (parent) ? parent.height : 0

    property color titleColor: (parent) ? parent.titleColor : "black"
    property bool titleFontBold: true
    property string titleFontFamily:(parent) ? parent.fontFamily : ""
    property color textColor: (parent) ? parent.textColor : "black"
    property string fontFamily: (parent) ? parent.fontFamily : ""

    property var selectedItem: null
    property bool editSelectedItemProperties: false

    onTitleChanged: {
        textItem.text = title;
    }

    onSelectedItemChanged: {
        if(selectedItem.textItem !== null) {
            console.log("selectedItem.textItem: ", selectedItem.textItem);
            textPropertiesItem.selectedItem = selectedItem;
            textPropertiesItem.visible = selectedItem.textItem.selecting;
        }
        else if(selectedItem === textItem)
        {
            console.log("selectedItem == textItem: ", selectedItem == textItem);
            textPropertiesItem.visible = titleRect.selected;
        }
    }

    visible: true
    width: (parent) ? parent.width : 0
    height: (parent) ? parent.height : 0

    //NOTE: For what reason this rectangle exist?
    Rectangle  {
        anchors.fill: (parent) ? parent : null
        color: "transparent"
        border{
            width: 1
            color: "black"
        }
    }

    TextPropertiesItem {
        id: textPropertiesItem
        z: titleRect.z + 1
        visible: false
    }

    Item  {
        id: titleRect

        property bool selected: false
        property int borderWidth : (selected) ? 5 : 2
        property color borderColor : (selected) ? "lightsteelblue" : "lightgrey"

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: topTitleMargin
        }

        visible: (layout != "") && (layout != "Empty")
        width: contentWidth
        height: textItem.textItem.height * 1.3
        z: parent.z + 1

        Rectangle {
            id: highlightRect

            onVisibleChanged: {
                if (!visible ) {
                    editSelectedItemProperties = false;
                }
            }

            anchors.fill: parent
            visible: helper.enableEdit()
            color: titleRect.borderColor
        }

        Rectangle {
            width: parent.width - titleRect.borderWidth * 2
            height: parent.height - titleRect.borderWidth * 2
            anchors.centerIn: parent
            color: (helper.enableEdit())? "white" : "transparent"

            TextItem {
                id: textItem

                onTextChanged: {
                    slide.title = (text !== slide.title) ? text : slide.title;
                }

                fontSize: titleFontSize
                fontFamily: titleFontFamily
                defaultText:  "Click to add title"
            }

            MouseArea {
                onClicked: {
                    selectedItem = textItem;
                    titleRect.selected = !titleRect.selected;
                }

                onPressAndHold: {
                    editSelectedItemProperties = !editSelectedItemProperties;
                    titleRect.selected = !titleRect.selected;
                }

                anchors.fill: parent
                enabled: helper.enableEdit()
            }
        }
    }

    Item {
        id: contentItem

        z: 10
        x: contentX
        y: contentY
        width: contentWidth
        height: contentHeight

        Text {
            id: centeredId

            color: slide.textColor
            width: parent.width
            anchors{
                centerIn: parent
                verticalCenterOffset: - parent.y / 3
            }

            text: centeredText
            wrapMode: Text.Wrap
            horizontalAlignment: Text.Center
            font{
                pixelSize: baseFontSize
                family: slide.fontFamily
            }
        }

        Text {
            id: writeInTextId

            property int length;

            color: slide.textColor
            anchors.fill: parent
            visible: slide.writeInText != undefined;

            wrapMode: Text.Wrap
            text: slide.writeInText.substring(0, length);
            font{
                family: slide.fontFamily
                pixelSize: baseFontSize
            }

            NumberAnimation on length {
                from: 0; to: slide.writeInText.length;
                duration: slide.writeInText.length * 30;
                running: slide.visible && slide.writeInText.length > 0
            }

        }

        Column {
            id: contentId

            anchors.fill: parent

            Repeater {

                model: content.length

                Row {
                    id: row

                    property int indentLevel: decideIndentLevel(content[index])
                    property int nextIndentLevel: index < content.length - 1 ? decideIndentLevel(content[index+1]) : 0
                    property real indentFactor: (10 - row.indentLevel * 2) / 10;

                    function decideIndentLevel(s) {
                        return s.charAt(0) === " " ? 1 + decideIndentLevel(s.substring(1)) : 0
                    }

                    x: slide.baseFontSize * indentLevel
                    height: text.height + (nextIndentLevel == 0 ? 1 : 0.3) * slide.baseFontSize * slide.bulletSpacing

                    Rectangle {
                        id: dot
                        y: baseFontSize * row.indentFactor / 2
                        width: baseFontSize / 4
                        height: baseFontSize / 4
                        color: slide.textColor
                        radius: width / 2
                        smooth: true
                        opacity: text.text.length === 0 ? 0 : 1
                    }

                    Rectangle {
                        id: space
                        width: dot.width * 2
                        height: 1
                        color: "#00ffffff"
                    }

                    TextEdit {
                        id: text

                        focus: true
                        color: slide.textColor
                        width: slide.contentWidth - parent.x - dot.width - space.width

                        text: content[index]
                        wrapMode: Text.WordWrap
                        textFormat: Text.PlainText
                        horizontalAlignment: Text.AlignLeft
                        font{
                            pixelSize: baseFontSize * row.indentFactor
                            family: slide.fontFamily
                        }
                    }
                }
            }
        }
    }

    Code {
        code: slide.code
        x: parent.width * 0.05
        y: parent.height * 0.2
        width: parent.width * 0.9
        height: parent.height * 0.7
    }
}
