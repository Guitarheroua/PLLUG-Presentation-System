QT       += core gui qml opengl multimedia webkit quick network

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets webkitwidgets

TARGET = DemoView
TEMPLATE = app

CONFIG += c++11

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

RESOURCES += \
    resources.qrc \
    qml.qrc

#macx
#{
#    OBJECTIVE_SOURCES += machelper.mm
#    LIBS += -framework Cocoa \
#    -framework Foundation \
#    -framework AppKit \
#    -framework Carbon

#    WEBPROCESS.files = libexec/QtWebProcess
#    WEBPROCESS.path = Contents/MacOS
#    QML.files = qml
#    QML.path = Contents/Resources
#    DATA.files = data
#    DATA.path = Contents/Resources
#    QMAKE_BUNDLE_DATA += WEBPROCESS
#    QMAKE_BUNDLE_DATA += QML
#    QMAKE_BUNDLE_DATA += DATA
#    QMAKE_INFO_PLIST = Info.plist
#}
