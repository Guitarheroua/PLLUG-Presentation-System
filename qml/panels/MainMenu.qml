import QtQuick 2.4
import QtQuick.Controls 1.4

MenuBar {
    Menu {
        title: "&File"
        MenuItem { action: idActionMenu.fileCreare }
        MenuItem { action: idActionMenu.fileOpen }
        MenuItem { action: idActionMenu.fileSaveAs }

        MenuSeparator { }

        MenuItem { action: idActionMenu.exit }
    }

    Menu {
        title: "&Edit"
        MenuItem { action: idActionMenu.undo }
        MenuItem { action: idActionMenu.redo }

        MenuSeparator { }

        MenuItem { action: idActionMenu.cut }
        MenuItem { action: idActionMenu.copy }
        MenuItem { action: idActionMenu.paste }

        MenuSeparator { }

        MenuItem { action: idActionMenu.selectAll }
    }

    Menu {
        title: "&View"
        MenuItem { action: idActionMenu.showPresentation}
    }

    Menu {
        title: "&Help"
        MenuItem { text: "About..." ; onTriggered: aboutBox.open() }
    }
}
