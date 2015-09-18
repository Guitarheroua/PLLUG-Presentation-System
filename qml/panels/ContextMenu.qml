import QtQuick 2.4
import QtQuick.Controls 1.2

import ".."
import "../items"

Menu {
    id: idContextMenu
    property var presentation

    Menu {
        title: "Background"


        MenuItem {
            text: qsTr("Swirls")
            checkable: true
            property bool isTriggered: false
            property string sourcePath: "qrc:/background/BackgroundSwirls.qml"
            onTriggered:{
                isTriggered = !isTriggered;
                if (isTriggered) {
                    presentation.addBackground(sourcePath);
                }
                else {
                    presentation.removeBackground(sourcePath);
                }
            }
        }

        MenuItem {
            text: qsTr("Fire")
            checkable: true
            property bool isTriggered: false
            property string sourcePath: "qrc:/background/FireEffect.qml"
            onTriggered: {
                isTriggered = !isTriggered;
                if (isTriggered) {
                    presentation.addBackground(sourcePath)
                }
                else {
                    presentation.removeBackground(sourcePath)
                }
            }
        }

        MenuItem {
            text: qsTr("Underwater")
            checkable: true
            property bool isTriggered: false
            property string sourcePath: "qrc:/background/UnderwaterEffect.qml"
            onTriggered: {
                isTriggered = !isTriggered;
                if (isTriggered) {
                    presentation.addBackground(sourcePath)
                }
                else {
                    presentation.removeBackground(sourcePath)
                }
            }

        }
    }

    Menu{
        title: "Transitions"

        MenuItem {
            text: qsTr("PageFlipShader")
            checkable: true
            property bool isTriggered: false
            property string sourcePath: "qrc:/transitions/PageFlipShaderEffect.qml"
            onTriggered: {
                isTriggered = !isTriggered;
                if (isTriggered) {
                    presentation.addBackground(sourcePath)
                }
                else {
                    presentation.removeBackground(sourcePath)
                }
            }
        }
    }
//    MenuItem {
//        text: qsTr("None")
//        onTriggered: {
//            presentationLoader.setSource("qrc:/TestPresentation.qml");
//        }
//    }

}
