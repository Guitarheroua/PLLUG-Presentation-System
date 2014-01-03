QT       += core gui qml opengl multimedia webkit quick network

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets webkitwidgets

TARGET = DemoView
TEMPLATE = app


HEADERS += \
    megaparse.h \
    block.h \
    blocksmodel.h \
    blocksview.h \
    mainview.h \
    machelper.h \
    helper.h \
    webviewitem.h \
    slide.h \
    presentationmanager.h


SOURCES += \
    megaparse.cpp \
    block.cpp \
    blocksmodel.cpp \
    blocksview.cpp \
    main.cpp \
    mainview.cpp \
    helper.cpp \
    webviewitem.cpp \
    slide.cpp \
    presentationmanager.cpp


OTHER_FILES += \
    qml/DemoView/web.qml \
    qml/DemoView/video.qml \
    qml/DemoView/test.qml \
    qml/DemoView/model.qml \
    qml/DemoView/main.qml \
    qml/DemoView/testwebview.qml \
    qml/DemoView/testvideo.qml \
    qml/DemoView/testWebView.qml \
    qml/DemoView/TestPage.qml \
    qml/DemoView/Block.qml \
    qml/DemoView/TestPresentation.qml \
    qml/DemoView/PageFlipShaderEffect.qml \
    qml/DemoView/BackgroundSwirls.qml \
    qml/DemoView/EmptySlide.qml \
    qml/DemoView/StartScreen.qml \
    qml/DemoView/OldDemoMain.qml \
    qml/DemoView/SlidesListPanel.qml \
    qml/DemoView/items/web.qml \
    qml/DemoView/items/video.qml \
    qml/DemoView/items/image.qml \
    qml/DemoView/BackgroundRectangle.qml \
    qml/DemoView/TemplatesListPanel.qml \
    qml/DemoView/OptionsPanel.qml \
    qml/DemoView/presentation/SlideCounter.qml \
    qml/DemoView/presentation/Slide.qml \
    qml/DemoView/presentation/Presentation.qml \
    qml/DemoView/presentation/CodeSlide.qml \
    qml/DemoView/presentation/Clock.qml \
    qml/DemoView/FireEffect.qml \
    qml/DemoView/ItemPropertiesPanel.qml \
    qml/DemoView/items/editedText.qml \
    qml/DemoView/panels/SlidesListPanel.qml \
    qml/DemoView/panels/OptionsPanel.qml \
    qml/DemoView/background/FireEffect.qml \
    qml/DemoView/background/BackgroundSwirls.qml \
    qml/DemoView/background/StarSkyEffect.qml \
    qml/DemoView/background/UnderwaterEffect.qml \
    qml/DemoView/panels/LayoutsListPanel.qml \
    qml/DemoView/layouts/Layout4.qml \
    qml/DemoView/layouts/Layout5.qml \
    qml/DemoView/layouts/Layout6.qml \
    qml/DemoView/layouts/Layout7.qml \
    qml/DemoView/items/titleItem.qml \
    qml/DemoView/layouts/Layout3.qml \
    qml/DemoView/items/Code.qml \
    qml/DemoView/layouts/Layout2.qml \
    qml/DemoView/layouts/Layout1.qml \
    qml/DemoView/panels/TextMenu.qml \
    qml/DemoView/components/ColorPicker/ColorPicker.qml \
    qml/DemoView/components/ColorPicker/NumberBox.qml \
    qml/DemoView/components/ColorPicker/PanelBorder.qml \
    qml/DemoView/components/ColorPicker/ColorUtils.js \
    qml/DemoView/components/ColorPicker/SBPicker.qml \
    qml/DemoView/panels/OptionsMenuItem.qml \
    qml/DemoView/panels/ColorMenuItem.qml \
    qml/DemoView/components/ColorPicker/ColorSlider.qml \
    qml/DemoView/panels/PositionMenu.qml \
    qml/DemoView/panels/SizeMenu.qml \
    qml/DemoView/panels/ToolbarItem.qml \
    qml/DemoView/StringUtils.js \
    qml/DemoView/StringUtils.js \
    qml/DemoView/layouts/Layout.qml \
    qml/DemoView/items/TextItem.qml

RESOURCES += \
    resources.qrc

macx
{
    OBJECTIVE_SOURCES += machelper.mm
    LIBS += -framework Cocoa \
    -framework Foundation \
    -framework AppKit \
    -framework Carbon

    WEBPROCESS.files = libexec/QtWebProcess
    WEBPROCESS.path = Contents/MacOS
    QML.files = qml
    QML.path = Contents/Resources
    DATA.files = data
    DATA.path = Contents/Resources
    QMAKE_BUNDLE_DATA += WEBPROCESS
    QMAKE_BUNDLE_DATA += QML
    QMAKE_BUNDLE_DATA += DATA
    QMAKE_INFO_PLIST = Info.plist
}

