import QtQuick 2.4
import "../StringUtils.js" as StringUtils

Item {
    id: textItemRect
    property string type : "text"
    property string text
    property alias textItem: textEdit
    property color fontColor : "black"
    property bool fontBold : true
    property bool fontItalic : false
    property double fontSize : 20
    property bool fontUnderline : false
    property bool fontStrikeout : false
    property bool bullets : false
    property variant content: []
    property real bulletSpacing: 1

    property string backgroundColor : "transparent"
    property string fontFamily: "Arial"

    property real widthCoeff
    property real heightCoeff

    property real xCoeff
    property real yCoeff

    property string defaultText: "Click to add text"

    //signal hideRect

    function getText() {
        return textEdit.getText(0,textEdit.text.length)
    }

    onFontBoldChanged: {
//        textEdit.font.bold = fontBold
    }

    onFontItalicChanged: {
//        textEdit.font.italic = fontItalic
    }

    onFontSizeChanged: {
//        textEdit.font.pointSize = fontSize
    }

    onFontStrikeoutChanged: {
//        textEdit.font.strikeout = fontStrikeout
    }
    onFontUnderlineChanged: {
//        textEdit.font.underline = fontUnderline
    }

    onFontColorChanged: {
//        textEdit.color = fontColor
    }

    onBulletsChanged: {
        addBullets()
    }

    function addBullets() {
        content = getText().split(/*String.fromCharCode(8233)*/"\n")
        textEdit.visible = false
    }

//    color: backgroundColor
    anchors.fill: parent
    z: parent.z + 1

    TextEdit  {
        id: textEdit
        property bool selecting : false
        enabled: helper.enableEdit()
        anchors {
            top:  parent.top
            left: parent.left
        }
        clip: true
        anchors.centerIn: parent
        text: (textItemRect.text === "") ? defaultText : textItemRect.text
        font {
            family: fontFamily
            pixelSize: fontSize
            bold: fontBold
            italic: fontItalic
            underline: fontUnderline
            strikeout: fontStrikeout
        }
        color: fontColor
        textFormat: TextEdit.PlainText
        selectByMouse: true
        mouseSelectionMode: TextInput.SelectWords
        persistentSelection: true
        focus: true
        activeFocusOnPress: true
        onTextChanged: {
            textItemRect.text = text
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                textEdit.text = (textItemRect.getText() === defaultText) ? "" : textEdit.text
                textEdit.forceActiveFocus()
                textEdit.deselect()
                textEdit.cursorPosition = textEdit.positionAt(mouse.x+x,mouse.y+y)
            }
            onDoubleClicked: {
                textEdit.selectWord()
            }

            onPressAndHold: {
//                console.log("onPressAndHold");
//                textItemRect.hideRect();
                textEdit.cursorPosition = textEdit.positionAt(mouse.x+x,mouse.y+y)
                textEdit.selecting = true
            }
            onMouseXChanged: {
                if (textEdit.selecting) {
                    textEdit.moveCursorSelection(textEdit.positionAt(mouse.x+x,mouse.y+y), TextInput.SelectCharacters);
                }
            }
        }
    }

    Column {
        id: contentId
        anchors.fill: parent

        Repeater {
            id: repeater
            model: content.length

            Row {
                id: row
                function decideIndentLevel(s) { return s.charAt(0) === " " ? 1 + decideIndentLevel(s.substring(1)) : 0 }
                property int indentLevel: decideIndentLevel(content[index])
                property int nextIndentLevel: index < content.length - 1 ? decideIndentLevel(content[index+1]) : 0
                property real indentFactor: (10 - row.indentLevel * 2) / 10;
                height: text.height + (nextIndentLevel == 0 ? 1 : 0.3) * fontSize * bulletSpacing
                width: contentId.width
                x: fontSize * indentLevel

                Rectangle {
                    id: dot
                    y: fontSize * row.indentFactor / 2
                    width: fontSize / 4
                    height: fontSize / 4
                    color: fontColor
                    radius: width / 2
                    smooth: true
//                    opacity: text.text.length === 0 ? 0 : 1
                }

                Rectangle {
                    id: space
                    width: dot.width * 2
                    height: 1
                    color: "#00ffffff"
                }

                TextEdit {
                    id: text
                    width: parent.width - parent.x - dot.width - space.width
                    font.pixelSize: fontSize * row.indentFactor
                    text: content[index]
                    textFormat: Text.PlainText
                    wrapMode: Text.WordWrap
                    color: fontColor
                    horizontalAlignment: Text.AlignLeft
                    font.family: fontFamily
                    focus: true
                }
            }
        }
    }

    Keys.onPressed: {
        if ((event.key === Qt.Key_A) && (event.modifiers & Qt.ControlModifier)) {
            textEdit.selectAll()
        }
        if (event.key === 16777221 && bullets) {
            repeater.model += 1
        }
    }
}
