import QtQuick 2.4
import "../StringUtils.js" as StringUtils

Rectangle {
    id: editedTextItem
    property string type : "text"
    property alias textItem: textEdit
    property color selectedColor
    property bool fontBold
    property bool fontItalic
    property int fontSize
    property bool fontUnderline
    property bool fontStrikeout
    property bool bullets

    property string backgroundColor : "transparent"
    property string fontFamily
    property string fontColor

    property real widthCoeff
    property real heightCoeff

    property real xCoeff
    property real yCoeff

    property string defaultText: /*"<ul><li><p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\">Click here maybe oh no</p></li>" +*/ "<span style=\"font-weight:bold\">
    <span style=\"color:green\">Click here maybe oh no</span>to dsffdsdf qweq gdf<span style=\"color:red\">add gsdfg serf qqqq</span> text vcvcv jgyjt assa</span>"

    property string selectedTextProperties: ""
    property string newTextProperties: ""
//    property variant attributes: { 'color': 'black', 'font_weight': 'normal',
//                                   'font_style': 'normal', 'font_size': 12,
//                                   'text_decoration': 'none'}
    property variant attributes: ({})

    function createStyleString() {
        var rStyle = "<span style=\"";
        for (var prop in attributes)
        {
            var lPropertyName = prop
            rStyle += lPropertyName.replace("_", "-") + ":" + attributes[prop]+";"
        }
        rStyle = rStyle.substring(0,rStyle.lastIndexOf(";")) + "\">"
        return rStyle
    }

    onFontBoldChanged: {
        changePropertyValue('font_weight', (fontBold) ? 'bold' : 'normal' )
    }

    onFontItalicChanged: {
        changePropertyValue('font_style', (fontItalic) ? 'italic' : 'normal')
    }

    onFontSizeChanged: {
        changePropertyValue('font_size', fontSize+"pt")
    }

    onFontStrikeoutChanged: {
        changePropertyValue('text_decoration', (fontStrikeout) ? 'line-through' : 'none')
    }
    onFontUnderlineChanged: {
        changePropertyValue('text_decoration', (fontUnderline) ? 'underline' : 'none')
    }

    onSelectedColorChanged: {
        changePropertyValue('color', selectedColor)
    }

    onBulletsChanged: {
        addBullets()
    }


    function changePropertyValue(pProperty, pValue) {
        setPropertyValue(pProperty,pValue)
        formatSelectedText()
    }

    function setPropertyValue(pProperty, pValue) {
        var temp = attributes
        temp[pProperty] = pValue
        attributes = temp
    }

    function addBullets() {
        var s1 = textEdit.getFormattedText(0, textEdit.cursorPosition)
        var i = s1.lastIndexOf("<p style=");
        var j = s1.lastIndexOf("</span>");
        s1 = s1.substring(0,j);
        s1 = s1.insert(i,"<ul><li>")
        var s2 = textEdit.getFormattedText(textEdit.cursorPosition, textEdit.text.lastIndexOf(">")+1)
        var k = s2.indexOf("<!--StartFragment-->");
        s2 = s2.substring(k,s2.lastIndexOf(">")+1)
        s2 = s2.substring(s2.indexOf("\">")+2,s2.lastIndexOf(">")+1 )
        var l = s2.indexOf("</p>")
        s2 = s2.insert(l+4, "</li>")
        var s = s1+s2
        s = s.replace("<!--StartFragment-->", "")
        s = s.replace("<!--EndFragment-->", "")
        textEdit.text = s
    }

    function formatSelectedText() {
        textEdit.prev = textEdit.getFormattedText(0,textEdit.selectionStart);
        textEdit.after = textEdit.getFormattedText(textEdit.selectionEnd, textEdit.text.lastIndexOf(">")-textEdit.selectionEnd )
        var k = textEdit.prev.indexOf("<!--EndFragment-->");
        textEdit.prev = textEdit.prev.substring(0,k);
        var i = textEdit.after.indexOf("<!--StartFragment-->");
        textEdit.after = textEdit.after.substring(i+20,textEdit.after.lastIndexOf(">")+1);
        textEdit.selectionStartPos = textEdit.selectionStart
        textEdit.selectionEndPos = textEdit.selectionEnd
        var s = textEdit.prev + createStyleString() + textEdit.selectedText + "</span>"  + textEdit.after
        textEdit.text = s
        textEdit.select(textEdit.selectionStartPos,textEdit.selectionEndPos )
    }

    function getTextStyle(pText) {
        var i = pText.indexOf("<!--StartFragment-->")
        var j = pText.indexOf("<!--EndFragment-->")
        pText = pText.substring(i+20,j)
        pText = pText.substring(1, pText.length )
        pText = pText.substring(0,pText.indexOf('>'))
        return pText
    }

    function parseStyle(pStyleString) {
        var i = pStyleString.indexOf("\"")
        var k = pStyleString.lastIndexOf("\"")
        var s = pStyleString.substring(i+1,k)
        var list = s.split(";")
        for(var i=0; i<list.length-1; ++i)
        {
            var l = list[i]
            var lList = l.split(":")
            var lName = lList[0].replace("-","_");
            setPropertyValue(lName.trim(),lList[1])
        }

    }
    color: backgroundColor
    anchors.fill: parent
    z: parent.z + 1

    TextEdit {
        id: textEdit
        property bool selecting : false
        property string prev
        property string after
        property string selected
        property int selectionStartPos
        property int selectionEndPos
        anchors {
            top:  parent.top
            left: parent.left
        }
        clip: true
        anchors.centerIn: parent
        text: defaultText
        font.family: "Halvetica"
        font.pixelSize: 15
        color: "black"
        textFormat: TextEdit.RichText
        selectByMouse: true
        mouseSelectionMode: TextInput.SelectWords
        persistentSelection: true
        focus: true
        activeFocusOnPress: true
        onSelectedTextChanged: {
            attributes = {}
            textEdit.selected = textEdit.getFormattedText(textEdit.selectionStart, textEdit.selectionEnd)
            parseStyle(getTextStyle(textEdit.selected))
        }
        onCursorPositionChanged: {
            textEdit.getFormattedText(textEdit.cursorPosition-1, textEdit.cursorPosition)
        }


        MouseArea {
            anchors.fill: parent
            onClicked: {
                textEdit.text = (textEdit.text === defaultText) ? "" : textEdit.text
                textEdit.forceActiveFocus()
                textEdit.deselect()
                textEdit.cursorPosition = textEdit.positionAt(mouse.x+x,mouse.y+y)
            }
            onDoubleClicked: {
                textEdit.selectWord()
            }

            onPressAndHold: {
                textEdit.cursorPosition = textEdit.positionAt(mouse.x+x,mouse.y+y)
                textEdit.selecting = true
            }

            onMouseXChanged: {
                if (textEdit.selecting) {
                    textEdit.moveCursorSelection(textEdit.positionAt(mouse.x+x,mouse.y+y),
                                                 TextInput.SelectCharacters)
                }
            }

        }

    }

    Keys.onPressed: {
        if ((event.key === Qt.Key_A) && (event.modifiers & Qt.ControlModifier)) {
            textEdit.selectAll()
        }
    }
}
