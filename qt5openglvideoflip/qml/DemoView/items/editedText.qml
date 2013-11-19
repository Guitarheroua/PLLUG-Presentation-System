import QtQuick 2.0

Rectangle
{
    id: editedTextItem
    property string type : "text"
    property alias textItem: textEdit
    property color selectedColor
    property bool fontBold
    property bool fontItalic
    property bool fontSize
    property bool fontUnderline
    property bool fontStrikeout

    property string backgroundColor : "transparent"
    property string fontFamily
    property string fontColor

    property real widthCoeff
    property real heightCoeff

    property real xCoeff
    property real yCoeff

    property string defaultText: "<span style=\"color:green\">Click</span> to <span style=\"color:red\">add</span> text"

    property string selectedTextProperties: ""

    onFontBoldChanged:
    {
        selectedTextProperties += "font-weight:bold;"
        formatSelectedText()
    }
    onSelectedColorChanged:
    {
        selectedTextProperties += "color:" + selectedColor + ";"
        console.log(selectedTextProperties)
        formatSelectedText()
    }


    function formatSelectedText()
    {
        textEdit.prev = textEdit.getFormattedText(0,textEdit.selectionStart);
        textEdit.after = textEdit.getFormattedText(textEdit.selectionEnd, textEdit.text.lastIndexOf(">")-textEdit.selectionEnd )
        var k = textEdit.prev.indexOf("<!--EndFragment-->");
        textEdit.prev = textEdit.prev.substring(0,k);
        var i = textEdit.after.indexOf("<!--StartFragment-->");
        textEdit.after = textEdit.after.substring(i+20,textEdit.after.lastIndexOf(">")+1);
//                console.log("\n", textEdit.prev, "\n", textEdit.after, "\n", textEdit.selectedText)
        textEdit.text = textEdit.prev + "<span style=\""+ selectedTextProperties + "\">" + textEdit.selectedText + "</span>"  + textEdit.after
//                console.log("\nRESULT\n", textEdit.text)
    }

    color: backgroundColor
    anchors.fill: parent
    z: parent.z + 1

    TextEdit{
        id: textEdit
        anchors
        {
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
        focus: true
        activeFocusOnPress: true
        onSelectedTextChanged:
        {
//            textEdit.text = selectedText;
        }
        property bool selecting : false
        property string prev
        property string after
        MouseArea
        {
            anchors.fill: parent
            onClicked: {
                textEdit.text = (textEdit.text === defaultText) ? "" : textEdit.text
                textEdit.forceActiveFocus()
                textEdit.deselect()
                textEdit.cursorPosition = textEdit.positionAt(mouse.x+x,mouse.y+y)
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
//            onReleased:
//            {
//                textEdit.prev = textEdit.getFormattedText(0,textEdit.selectionStart);
//                textEdit.after = textEdit.getFormattedText(textEdit.selectionEnd, textEdit.text.lastIndexOf(">")-textEdit.selectionEnd )
//                var k = textEdit.prev.indexOf("<!--EndFragment-->");
//                textEdit.prev = textEdit.prev.substring(0,k);
//                var i = textEdit.after.indexOf("<!--StartFragment-->");
//                textEdit.after = textEdit.after.substring(i+20,textEdit.after.lastIndexOf(">")+1);
////                console.log("\n", textEdit.prev, "\n", textEdit.after, "\n", textEdit.selectedText)
//                textEdit.text = textEdit.prev + selectedTextProperties + textEdit.selectedText + "</span>"  + textEdit.after
////                console.log("\nRESULT\n", textEdit.text)
//            }
        }
    }


}
