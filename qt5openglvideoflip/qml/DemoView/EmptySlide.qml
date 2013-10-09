import QtQuick 2.0
import Qt.labs.presentation 1.0

Slide
{
    id: slide
    property string backgroundImage
    Image
    {
        anchors.fill: parent
        source: slide.backgroundImage
    }
    title: "Empty slide"

}
