import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    property alias fileCreare: fileCreateAction
    property alias fileOpen: fileOpenAction
    property alias fileSaveAs: fileSaveAsAction
    property alias exit: exitAction

    property alias undo: undoAction
    property alias redo: redoAction
    property alias cut: cutAction
    property alias copy: copyAction
    property alias paste: pasteAction
    property alias selectAll: selectAllAction

    Action {
        id: fileCreateAction
        //    iconSource: "images/fileopen.png"
        //    iconName: "document-open"
        text: "Create"
        shortcut: "ctrl+n"
        onTriggered: {
            helper.setCreatePresentationMode();
            presentationLoader.setSource("TestPresentation.qml")
            startScreen.state = "closed"
        }
    }
    Action {
        id: fileOpenAction
        //    iconSource: "images/fileopen.png"
        //    iconName: "document-open"
        text: "Open"
        shortcut: "ctrl+o"
        onTriggered: {
            helper.openPresentation(fileDialog.fileUrl)
            startScreen.state = "closed"
        }
    }
    Action {
        id: fileSaveAsAction
        //    iconSource: "images/filesave.png"
        //    iconName: "document-save"
        text: "Save As…"
        shortcut: "shift+ctrl+s"
        onTriggered: {
            fileDialog.selectExisting = false
            fileDialog.open()
        }
    }
    Action {
        id: exitAction
        //    iconSource: "images/filesave.png"
        //    iconName: "document-save"
        text: "Exit"
        shortcut: "ctrl+q"
        onTriggered: {
            Qt.quit()
        }
    }

    Action {
        id: undoAction
        text: "Undo"
        shortcut: "ctrl+z"
        //        iconSource: "images/editcut.png"
        //        iconName: "edit-cut"
        onTriggered: textArea.cut()
    }
    Action {
        id: redoAction
        text: "Redo"
        shortcut: "shift+ctrl+z"
        //        iconSource: "images/editcut.png"
        //        iconName: "edit-cut"
        onTriggered: textArea.cut()
    }
    Action {
        id: cutAction
        text: "Cut"
        shortcut: "ctrl+x"
        //        iconSource: "images/editcut.png"
        //        iconName: "edit-cut"
        onTriggered: textArea.cut()
    }
    Action {
        id: copyAction
        text: "Copy"
        shortcut: "ctrl+c"
        //        iconSource: "images/editcopy.png"
        //        iconName: "edit-copy"
        onTriggered: textArea.copy()
    }
    Action {
        id: pasteAction
        text: "Paste"
        shortcut: "ctrl+v"
        //        iconSource: "qrc:images/editpaste.png"
        //        iconName: "edit-paste"
        onTriggered: textArea.paste()
    }
    Action {
        id: selectAllAction
        text: "Select ALL"
        shortcut: "ctrl+A"
        //        iconSource: "images/editcut.png"
        //        iconName: "edit-cut"
        onTriggered: textArea.cut()
    }
}

