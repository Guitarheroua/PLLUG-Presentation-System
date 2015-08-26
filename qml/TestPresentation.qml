import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

import "presentation"
import "panels"

SplitView{
    id: horisontalSplitView
    anchors.fill: parent
    property bool isContextMenuVisible: true


    SplitView{
        id: verticalSplitView
        Layout.fillWidth: true
        orientation: Qt.Vertical

        Presentation {
            id: presentation
            Layout.fillHeight: true
            textColor: "black"


            MouseArea{
                id:ma
                anchors.fill: parent

                hoverEnabled: true
                acceptedButtons: Qt.LeftButton | Qt.RightButton

                onClicked: {

                    if (mouse.button == Qt.RightButton)
                    {
                        contextMenuid.popup(isContextMenuVisible);
                        isContextMenuVisible = !isContextMenuVisible;
                    }
                    //            else
                    //                isContextMenuVisible = true
                }
            }

            //    MouseArea{
            //        anchors.fill: parent
            //        onClicked: {
            //            contextMenuid.popup(isContextMenuVisible);
            //            isContextMenuVisible = !isContextMenuVisible;
            //        }
            //    }

            //    Menu {
            //        id:contextMenuid
            //        title: "Edit"

            //        MenuItem {
            //            text: "Cut"
            //            shortcut: "Ctrl+X"
            //        }

            //        MenuItem {
            //            text: "Copy"
            //            shortcut: "Ctrl+C"
            //        }

            //        MenuItem {
            //            text: "Paste"
            //            shortcut: "Ctrl+V"
            //        }

            //        MenuSeparator { }

            //        Menu {
            //            title: "More Stuff"

            //            MenuItem {
            //                text: "Do Nothing"
            //            }
            //        }
            //    }


            Menu {
                id:contextMenuid
                title: qsTr("File")
                MenuItem {
                    text: qsTr("Exit")
                    onTriggered: Qt.quit();
                }


                MenuItem {
                    text: qsTr("Import Ego")
                    onTriggered: {
                        var importEgo = Qt.createComponent("qrc:///qml/ImportEgo.qml");
                        var importEgoWnd = importEgo.createObject();
                        importEgoWnd.show();
                    }
                }
                MenuItem {
                    text: qsTr("Export Ego")
                    onTriggered: {
                        var reader = Qt.createComponent("qrc:///qml/ExportEgo.qml");
                        var readerWnd = reader.createObject();
                        readerWnd.show();
                    }
                }

                MenuItem {
                    text: qsTr("Profile")
                    onTriggered: {
                        var profile = Qt.createComponent("qrc:///qml/Profile.qml");
                        var profileWnd = profile.createObject();
                        profileWnd.show();
                    }
                }

                MenuItem {
                    text: qsTr("Single Chat")
                    onTriggered: {
                        var single = Qt.createComponent("qrc:///qml/SingleConversation.qml");
                        var singleWnd = single.createObject();
                        singleWnd.show();
                    }
                }

                MenuItem {
                    text: qsTr("Threaded Chat")
                    onTriggered: {
                        var threaded = Qt.createComponent("qrc:///qml/ThreadChat.qml");
                        var threadedWnd = threaded.createObject();
                        threadedWnd.show();
                    }
                }

                MenuItem {
                    text: qsTr("About")
                    onTriggered: {
                        var threaded = Qt.createComponent("qrc:///qml/About.qml");
                        var threadedWnd = threaded.createObject();
                        threadedWnd.show();
                    }
                }


            }

            Component.onCompleted: {
                addNewSlide();
            }

            onCurrentSlideChanged: {
                slidesListPanel.selectSlide(currentSlide)
            }

            function addNewSlide() {
                var component = Qt.createComponent("presentation/Slide.qml");
                var newSlide = component.createObject(presentation, {"layout": "Empty"});
                if (newSlide === null) {
                    console.log("Error creating object", component.status, component.url, component.errorString());
                }
                presentation.newSlide(newSlide, presentation.currentSlide+1, false)

            }

            function removeSlideAt(index) {
                presentation.removeSlide(index)
            }

            function setLayout(source) {
                if (source !== "") {
                    for (var i=0; i<presentation.slides[currentSlide].children.length; ++i) {
                        var layoutToRemove
                        if (presentation.slides[currentSlide].children[i].objectName === "layout") {
                            layoutToRemove = presentation.slides[currentSlide].children[i]
                            if (layoutToRemove) {
                                layoutToRemove.destroy()
                                presentation.slides[currentSlide].layout = "Empty"
                                break;
                            }
                        }
                    }
                    if (source !== "Empty") {
                        var component = Qt.createComponent(source);
                        component.createObject(presentation.slides[currentSlide], {"objectName": "layout"});
                        presentation.slides[currentSlide].layout = source
                    }
                }
            }

            function addBackground(source) {
                if (source !== "") {
                    for(var i=0; i<presentation.slides.length; ++i) {
                        var background = Qt.createComponent(source)
                        background.createObject(presentation.slides[i], {"objectName": source, z: "-1"});
                    }
                }
            }

            function removeBackground(source) {
                if (source !== "") {
                    for (var i=0; i<presentation.slides.length; ++i) {
                        for (var j=0; j<presentation.slides[i].children.length; ++j) {
                            var effectToRemove
                            if (presentation.slides[i].children[j].objectName === source) {
                                effectToRemove = presentation.slides[i].children[j]
                                if (effectToRemove) {
                                    effectToRemove.destroy()
                                    break
                                }
                            }
                        }
                    }
                }
            }

            function addTransition(source) {
                if (source !== "") {
                    var transitionComponent = Qt.createComponent(source);
                    var transition = transitionComponent.createObject(presentation, {"objectName": source,
                                                                          "currentSlide": presentation.currentSlide,
                                                                          "screenWidth": presentation.width,
                                                                          "screenHeight" : presentation.height });
                    presentation.transition = transition
                }
            }

            function removeTransition(source) {
                for (var i=0; i<presentation.children.length; ++i) {
                    var transitionToRemove
                    if (presentation.children[i].objectName === source) {
                        transitionToRemove = presentation.children[i]
                        if (transitionToRemove) {
                            transitionToRemove.destroy()
                            presentation.transition = null
                            break
                        }
                    }
                }
            }

            OptionsPanel {
                id: optionsPanel
            }
        }

        SlidesListPanel {
            id: slidesListPanel
            Layout.minimumHeight: 17
            Layout.maximumHeight: 150
            slides: presentation.slides
            z: 3
            onSlideSelected: {
                presentation.goToSlide(index)
            }
        }
    }

    LayoutsListPanel {
        id: layoutsListPanel
        Layout.minimumWidth: 15
        Layout.maximumWidth: 150
    }
}


