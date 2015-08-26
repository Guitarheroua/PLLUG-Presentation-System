import QtQuick 2.4
import QtQuick.Controls 1.2

import "../"

Menu {
    id: idContextMenu

    MenuItem {
        text: qsTr("Exit")
        onTriggered: Qt.quit();
    }

    MenuItem {
        text: qsTr("BackgroundSwirls")
        onTriggered:{
            presentationLoader.setSource("qrc:/background/BackgroundSwirls.qml")
        }
    }

    MenuItem {
        text: qsTr("FireEffect")
        onTriggered: {
            presentationLoader.setSource("qrc:/background/FireEffect.qml")

        }
    }

    MenuItem {
        text: qsTr("Underwater")
        onTriggered: {
            presentationLoader.setSource("qrc:/background/UnderwaterEffect.qml")
        }
    }

    MenuItem {
        text: qsTr("Swirl")
        onTriggered: {
            presentationLoader.setSource("qrc:/background/Swirl.qml")
        }
    }

    MenuItem {
        text: qsTr("defaul")
        onTriggered: {
            presentationLoader.setSource("qrc:/TestPresentation.qml");
        }
    }
}
