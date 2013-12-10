import QtQuick 2.0
import "../StringUtils.js" as StringUtils

Rectangle
{
    id: textItemRect
    property string type : "text"
    property alias textItem: textEdit
    property color fontColor : "black"
    property bool fontBold : true
    property bool fontItalic : false
    property double fontSize : 12
    property bool fontUnderline : false
    property bool fontStrikeout : false
    property bool bullets : false

    property string backgroundColor : "transparent"
    property string fontFamily: "Arial"

    property real widthCoeff
    property real heightCoeff

    property real xCoeff
    property real yCoeff

    property string defaultText: "Click to add text"

    function getText()
    {
        return textEdit.getText(0,textEdit.text.length)
    }

    onFontBoldChanged:
    {
//        textEdit.font.bold = fontBold
    }

    onFontItalicChanged:
    {
//        textEdit.font.italic = fontItalic
    }

    onFontSizeChanged:
    {
//        textEdit.font.pointSize = fontSize
    }

    onFontStrikeoutChanged:
    {
//        textEdit.font.strikeout = fontStrikeout
    }
    onFontUnderlineChanged:
    {
//        textEdit.font.underline = fontUnderline
    }

    onFontColorChanged:
    {
//        textEdit.color = fontColor
    }

    onBulletsChanged:
    {
        addBullets()
    }


    function addBullets()
    {

    }


    color: backgroundColor
    anchors.fill: parent
    z: parent.z + 1

    TextEdit
    {
        id: textEdit
        enabled: textItemRect.parent.parent.enableEdit
        anchors
        {
            top:  parent.top
            left: parent.left
        }
        clip: true
        anchors.centerIn: parent
        text: defaultText
        font
        {

            family: fontFamily
            pointSize: fontSize
            bold: fontBold
            italic: fontItalic
            underline: fontUnderline
            strikeout: fontStrikeout
        }
        color: fontColor
        textFormat: TextEdit.RichText
        selectByMouse: true
        mouseSelectionMode: TextInput.SelectWords
        persistentSelection: true
        focus: true
        activeFocusOnPress: true

        property bool selecting : false

        MouseArea
        {
            anchors.fill: parent
            onClicked: {
                textEdit.text = (textEdit.text === defaultText) ? "" : textEdit.text
                textEdit.forceActiveFocus()
                textEdit.deselect()
                textEdit.cursorPosition = textEdit.positionAt(mouse.x+x,mouse.y+y)
            }
            onDoubleClicked:
            {
                textEdit.selectWord()
            }

            onPressAndHold:
            {
                textEdit.cursorPosition = textEdit.positionAt(mouse.x+x,mouse.y+y)
                textEdit.selecting = true
            }
            onMouseXChanged:
            {
                if (textEdit.selecting)
                {
                    textEdit.moveCursorSelection(textEdit.positionAt(mouse.x+x,mouse.y+y), TextInput.SelectCharacters);
                }
            }

        }

    }

    Keys.onPressed:
    {
        if ((event.key == Qt.Key_A) && (event.modifiers & Qt.ControlModifier))
        {
            textEdit.selectAll()
        }
    }
}
