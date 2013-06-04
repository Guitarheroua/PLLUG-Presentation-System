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
    blocksview.h

SOURCES += \
    page.cpp \
    pagemodel.cpp \
    megaparse.cpp \
    block.cpp \
    blocksmodel.cpp \
    blocksview.cpp \
    main.cpp

OTHER_FILES += \
    resources/qml/web.qml \
    resources/qml/video.qml \
    resources/qml/test.qml \
    resources/qml/rectangle.qml \
    resources/qml/model.qml \
    resources/qml/main.qml \
    qml/web.qml \
    qml/video.qml \
    qml/test.qml \
    qml/rectangle.qml \
    qml/model.qml \
    qml/main.qml \
    qml/image.qml

RESOURCES += \
    resources.qrc
