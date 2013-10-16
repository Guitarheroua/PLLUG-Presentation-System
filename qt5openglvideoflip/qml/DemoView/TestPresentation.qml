import QtQuick 2.0
import QtQuick.Controls 1.0
import Qt.labs.presentation 1.0
import "presentation"
import "templates"


Presentation {
    id: presentation
    width: screenPixelWidth
    height: screenPixelHeight
    MouseArea{
        anchors.fill:parent
        onClicked: {

        }
    }
    effect: flipEffect
    onCurrentSlideChanged:
    {
        slidesListPanel.selectSlide(currentSlide)
    }


    function addNewSlide(template)
    {
        var source = (template === "") ? "EmptySlide.qml" : template
        var component = Qt.createComponent(source);
        var newSlide = component.createObject(presentation/*, {"title": "New Slide"}*/);
        if (newSlide === null)
        {
            console.log("Error creating object");
        }
        presentation.newSlide(newSlide,presentation.currentSlide+1)
        //        optionsPanel.state = "closed"
        templatesListPanel.state = "opened"

    }

    function removeSlideAt(index)
    {
        presentation.removeSlide(index)
    }

    Loader {
        id : backgroundLoader
        anchors.fill: parent
    }

    //    BackgroundSwirls {}

    textColor: "black"


    EmptySlide
    {
        title: "first slide"
        visible: false
        content: [
            "Gradient Rectangle",
            "Swirls using ShaderEffect",
            " Movement using a vertexShader",
            " Colorized using a gradient rect converted to a texture",
            " Controlled using QML properties and animations",
            "Snow"
        ]

    }

    Slide {
        centeredText: "Animated Background"
        fontScale: 2
        visible: false
        title: "anim slide"


    }

    Slide {
        title: "Composition"
        visible: false
        content: [
            "Gradient Rectangle",
            "Swirls using ShaderEffect",
            " Movement using a vertexShader",
            " Colorized using a gradient rect converted to a texture",
            " Controlled using QML properties and animations",
            "Snow",
            " Using 'QtQuick.Particles 2.0'",
            " Emitter",
            " ImageParticle"
        ]


    }
    Slide {
        title: "Slide"
        visible: false
        content: [
            "  Text1",
            "  Text2",
            "  Text3",

        ]
        fontScale: 1
        Clock{}
    }

    Slide
    {
        title: "code slide"
        visible: false
        code: " RECT* rect = (RECT*) message->lParam;
        int fWidth = frameGeometry().width() - width();
        int fHeight = frameGeometry().height() - height();
        int nWidth = rect->right-rect->left - fWidth;
        int nHeight = rect->bottom-rect->top - fHeight;

        switch(message->wParam) {
        case WMSZ_BOTTOM:
        case WMSZ_TOP:
            rect->right = rect->left+(qreal)nHeight*mAspectRatio + fWidth;
            break;"
    }

    Slide {
        title: "Last Slide"
        visible: false
        centeredText: "Place some text here"
        fontScale: 2
        Clock{}
    }

    PageFlipShaderEffect
    {
        id: flipEffect
        currentSlide: presentation.currentSlide
        onCurrentSlideChanged:
        {
            presentation.currentSlide = currentSlide
        }
        screenWidth: presentation.width
        screenHeight: presentation.height
    }
    TemplatesListPanel
    {
        id: templatesListPanel
        width: 130
        height: presentation.height
        color: "gray"
        x: presentation.width - width
        z: presentation.z + 2
        onTemplateSelected:
        {
            if (source != "")
            {
                var component = Qt.createComponent(source);
                for (var i=0; i<presentation.slides[currentSlide].children.length; ++i)
                {
                    var templateToRemove;
                    if (presentation.slides[currentSlide].children[i].objectName === "template")
                    {
                        templateToRemove = presentation.slides[currentSlide].children[i]
                        if (templateToRemove)
                        {
                            templateToRemove.destroy();
                            break;
                        }
                    }
                }
                component.createObject(presentation.slides[currentSlide], {"objectName": "template"});
            }
        }
    }
    //    OptionsPanel{
    //        id: optionsPanel
    //    }


    SlidesListPanel
    {
        id: slidesListPanel
        slides: presentation.slides
        z: flipEffect.z + 1
        onSlideSelected:
        {
            presentation.goToSlide(index)
        }
    }
    MouseArea
    {
        anchors.fill: parent
        onClicked: {
            slidesListPanel.state = "closed"
            templatesListPanel.state = "closed"
        }
    }

}
