QT       += core gui qml opengl quick

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

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
    helper.h

SOURCES += \
    page.cpp \
    pagemodel.cpp \
    megaparse.cpp \
    block.cpp \
    blocksmodel.cpp \
    blocksview.cpp \
    main.cpp \
    mainview.cpp \
    helper.cpp


OTHER_FILES += \
    qml/DemoView/web.qml \
    qml/DemoView/video.qml \
    qml/DemoView/test.qml \
    qml/DemoView/rectangle.qml \
    qml/DemoView/model.qml \
    qml/DemoView/main.qml \
    qml/DemoView/image.qml

RESOURCES += \
    resources.qrc

macx
{
    QML.files = qml
    QML.path = Contents/Resources
    DATA.files = data
    DATA.path = Contents/Resources
    QMAKE_BUNDLE_DATA += QML
    QMAKE_BUNDLE_DATA += DATA
    QMAKE_INFO_PLIST = Info.plist
}
