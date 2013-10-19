import QtQuick 2.0

Rectangle
{
    id: item
    property string type : "text"
    property string backgroundColor
//    property string source
    property int fontSize
    property string fontFamily
    property string fontColor

    property real widthCoeff
    property real heightCoeff

    property real xCoeff
    property real yCoeff

    property string defaultText: "Click to add text"
    color: "white"

    TextEdit{
        id: textEdit
        anchors.centerIn: parent
        text: defaultText
        font.family: "Halvetica"
        font.pixelSize: 15
        color: "red"
    }
    MouseArea
    {
        anchors.fill: parent
        onClicked: {
            textEdit.text = (textEdit.text === defaultText) ? "" : textEdit.text
            textEdit.forceActiveFocus()
        }
    }

}
