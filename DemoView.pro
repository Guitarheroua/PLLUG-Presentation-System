QT       += core gui qml opengl multimedia webkit quick network

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets webkitwidgets

TARGET = DemoView
TEMPLATE = app

CONFIG += c++11

HEADERS += \
    mainview.h \
    helper.h \
    presentationmanager.h \
    contentblock.h \
    slidemodel.h


SOURCES += \
    main.cpp \
    mainview.cpp \
    helper.cpp \
    presentationmanager.cpp \
    contentblock.cpp \
    slidemodel.cpp

RESOURCES += \
    resources.qrc \
    qml.qrc
