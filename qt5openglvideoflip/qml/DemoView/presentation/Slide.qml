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


import QtQuick 2.0

Item {
    /*
      Slides can only be instantiated as a direct child of a Presentation {} as they rely on
      several properties there.
     */

    id: slide

    property bool isSlide: true

    property string title
    property variant content: []
    property string centeredText
    property string writeInText;
    property string notes

    property string codeFontFamily: parent.codeFontFamily
    property string code
    property real codeFontSize: baseFontSize * 0.6

    property real fontSize: parent.height * 0.05
    property real fontScale: 1

    property real baseFontSize: fontSize * fontScale
    property real titleFontSize: fontSize * 1.2 * fontScale
    property real bulletSpacing: 1

//    property real contentWidth: width

    property real topTitleMargin: parent.fontSize * 1.5

    property real contentX: parent.width * 0.05
    property real contentY: parent.height * 0.2
    property real contentWidth:  parent.width * 0.9
    property real contentHeight: parent.height * 0.7



    // Define the slide to be the "content area"
    //    x: parent.width * 0.05
    //    y: parent.height * 0.2
    //    width: parent.width * 0.9
    //    height: parent.height * 0.7
    width: parent.width
    height: parent.height
    Rectangle
    {
        anchors.fill: parent
        color: "transparent"
            border.width: 3
            border.color: "black"
    }



    property real masterWidth: parent.width
    property real masterHeight: parent.height

    property color titleColor: parent.titleColor;
    property color textColor: parent.textColor;
    property string fontFamily: parent.fontFamily;

    property var selectedItem: null
    property bool editSelectedItemProperties: false

    visible: false

    onCodeChanged: {
        listModel.clear();
        var codeLines = slide.code.split("\n");
        for (var i=0; i<codeLines.length; ++i) {
            listModel.append({
                                 line: i,
                                 code: codeLines[i]
                             });
        }
    }

    Text {
        id: titleText
        font.pixelSize: titleFontSize
        text: title
        anchors.horizontalCenter:  parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: topTitleMargin
        font.bold: true;
        font.family: slide.fontFamily
        color: slide.titleColor
        horizontalAlignment: Text.Center
    }
    Item
    {
        id: contentItem
        x: contentX
        y: contentY
        width: contentWidth
        height: contentHeight
        Text {
            id: centeredId
            width: parent.width
            anchors.centerIn: parent
            anchors.verticalCenterOffset: - parent.y / 3
            text: centeredText
            horizontalAlignment: Text.Center
            font.pixelSize: baseFontSize
            font.family: slide.fontFamily
            color: slide.textColor
            wrapMode: Text.Wrap
        }

        Text {
            id: writeInTextId
            property int length;
            font.family: slide.fontFamily
            font.pixelSize: baseFontSize
            color: slide.textColor

            anchors.fill: parent
            wrapMode: Text.Wrap

            text: slide.writeInText.substring(0, length);

            NumberAnimation on length {
                from: 0;
                to: slide.writeInText.length;
                duration: slide.writeInText.length * 30;
                running: slide.visible && parent.visible && slide.writeInText.length > 0
            }

            visible: slide.writeInText != undefined;
        }


        Column {
            id: contentId
            anchors.fill: parent

            Repeater {
                model: content.length

                Row {
                    id: row

                    function decideIndentLevel(s) { return s.charAt(0) == " " ? 1 + decideIndentLevel(s.substring(1)) : 0 }
                    property int indentLevel: decideIndentLevel(content[index])
                    property int nextIndentLevel: index < content.length - 1 ? decideIndentLevel(content[index+1]) : 0
                    property real indentFactor: (10 - row.indentLevel * 2) / 10;

                    height: text.height + (nextIndentLevel == 0 ? 1 : 0.3) * slide.baseFontSize * slide.bulletSpacing
                    x: slide.baseFontSize * indentLevel

                    Rectangle {
                        id: dot
                        y: baseFontSize * row.indentFactor / 2
                        width: baseFontSize / 4
                        height: baseFontSize / 4
                        color: slide.textColor
                        radius: width / 2
                        smooth: true
                        opacity: text.text.length == 0 ? 0 : 1
                    }

                    Rectangle {
                        id: space
                        width: dot.width * 2
                        height: 1
                        color: "#00ffffff"
                    }

                    Text {
                        id: text
                        width: slide.contentWidth - parent.x - dot.width - space.width
                        font.pixelSize: baseFontSize * row.indentFactor
                        text: content[index]
                        textFormat: Text.PlainText
                        wrapMode: Text.WordWrap
                        color: slide.textColor
                        horizontalAlignment: Text.AlignLeft
                        font.family: slide.fontFamily
                    }
                }
            }
        }
    }

    Item
    {
        id: codeItem
        x: parent.width * 0.05
        y: parent.height * 0.2
        width: parent.width * 0.9
        height: parent.height * 0.7
        visible: (code != "")
        Rectangle
        {
            id: codeItemBackground
            anchors.fill: parent
            radius: height / 10;
            gradient: Gradient {
                GradientStop { position: 0; color: Qt.rgba(0.8, 0.8, 0.8, 0.5); }
                GradientStop { position: 1; color: Qt.rgba(0.2, 0.2, 0.2, 0.5); }
            }
            border.color: slide.textColor;
            border.width: height / 250;
            antialiasing: true
        }

        ListModel
        {
            id: listModel
        }


        onVisibleChanged: {
            listView.focus = slide.visible;
            listView.currentIndex = -1;
        }

        ListView {
            id: listView;

            anchors.fill: parent;
            anchors.margins: codeItemBackground.radius / 2
            clip: true

            model: listModel;
            focus: true;

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    listView.focus = true;
                    listView.currentIndex = listView.indexAt(mouse.x, mouse.y + listView.contentY);
                }

            }

            delegate: Item {

                id: itemDelegate

                height: lineLabel.height
                width: parent.width

                Rectangle {
                    id: lineLabelBackground
                    width: lineLabel.height * 3;
                    height: lineLabel.height;
                    color: slide.textColor;
                    opacity: 0.1;
                }

                Text {
                    id: lineLabel
                    anchors.right: lineLabelBackground.right;
                    text: (line+1) + ":"
                    color: slide.textColor;
                    font.family: slide.codeFontFamily
                    font.pixelSize: slide.codeFontSize
                    font.bold: itemDelegate.ListView.isCurrentItem;
                    opacity: itemDelegate.ListView.isCurrentItem ? 1 : 0.9;

                }

                Rectangle {
                    id: lineContentBackground
                    anchors.fill: lineContent;
                    anchors.leftMargin: -height / 2;
                    color: slide.textColor
                    opacity: 0.2
                    visible: itemDelegate.ListView.isCurrentItem;
                }

                Text {
                    id: lineContent
                    anchors.left: lineLabelBackground.right
                    anchors.leftMargin: lineContent.height;
                    anchors.right: parent.right;
                    color: slide.textColor;
                    text: code;
                    font.family: slide.codeFontFamily
                    font.pixelSize: slide.codeFontSize
                    font.bold: itemDelegate.ListView.isCurrentItem;
                    opacity: itemDelegate.ListView.isCurrentItem ? 1 : 0.9;
                }
            }
        }
    }

}
