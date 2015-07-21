import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

import "presentation"
import "panels"

SplitView{
    id: horisontalSplitView
    anchors.fill: parent

    SplitView{
        id: verticalSplitView
        Layout.fillWidth: true
        orientation: Qt.Vertical

        Presentation {
            id: presentation
            Layout.fillHeight: true
            textColor: "black"

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


