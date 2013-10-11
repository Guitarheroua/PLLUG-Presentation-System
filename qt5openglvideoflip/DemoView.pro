QT       += core gui qml opengl multimedia webkit quick network

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets webkitwidgets

TARGET = DemoView
TEMPLATE = app


HEADERS += \
    page.h \
    pagemodel.h \
    megaparse.h \
    block.h \
    blocksmodel.h \
    blocksview.h \
    mainview.h \
    machelper.h \
    helper.h \
    webviewitem.h


SOURCES += \
    page.cpp \
    pagemodel.cpp \
    megaparse.cpp \
    block.cpp \
    blocksmodel.cpp \
    blocksview.cpp \
    main.cpp \
    mainview.cpp \
    helper.cpp \
    webviewitem.cpp \


OTHER_FILES += \
    qml/DemoView/web.qml \
    qml/DemoView/video.qml \
    qml/DemoView/test.qml \
    qml/DemoView/rectangle.qml \
    qml/DemoView/model.qml \
    qml/DemoView/main.qml \
    qml/DemoView/image.qml \
    qml/DemoView/testwebview.qml \
    qml/DemoView/testvideo.qml \
    qml/DemoView/testWebView.qml \
    qml/DemoView/TestPage.qml \
    qml/DemoView/Block.qml \
    qml/DemoView/TemplatesList.qml \
    qml/DemoView/TestPresentation.qml \
    qml/DemoView/PageFlipShaderEffect.qml \
    qml/DemoView/Swirl.qml \
    qml/DemoView/BackgroundSwirls.qml \
    qml/DemoView/EmptySlide.qml \
    qml/DemoView/StartScreen.qml \
    qml/DemoView/OldDemoMain.qml \
    qml/DemoView/FeaturesPanel.qml \
    qml/DemoView/SlidesListPanel.qml

RESOURCES += \
    resources.qrc

macx
{
#    OBJECTIVE_SOURCES += machelper.mm
#    LIBS += -framework Cocoa \
#    -framework Foundation \
#    -framework AppKit \
#    -framework Carbon

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

FORMS +=
