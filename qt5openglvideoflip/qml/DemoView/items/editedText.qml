import QtQuick 2.0

Rectangle
{
    id: editedTextItem
    property string type : "text"
    property alias textItem: textEdit
    property string backgroundColor : "transparent"
    property int fontSize
    property string fontFamily
    property string fontColor

    property real widthCoeff
    property real heightCoeff

    property real xCoeff
    property real yCoeff

    property string defaultText: "<b>Click</b> to add text"

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
        MouseArea
        {
            anchors.fill: parent
            onClicked: {
                textEdit.text = (textEdit.text === defaultText) ? "" : textEdit.text
    //            textEdit.forceActiveFocus()
                textEdit.cursorPosition = textEdit.positionAt(mouse.x+x,mouse.y+y);
                textEdit.selectWord()
            }
            onPressAndHold:
            {

            }
        }
    }


}
