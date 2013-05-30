# Add more folders to ship with the application, here
folder_01.source = qml/DemoView
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    page.cpp \
    pagemodel.cpp \
    megaparse.cpp \
    block.cpp \
    blocksmodel.cpp \
    blocksview.cpp

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

HEADERS += \
    page.h \
    pagemodel.h \
    megaparse.h \
    block.h \
    blocksmodel.h \
    blocksview.h

OTHER_FILES += \
    resources/qml/web.qml \
    resources/qml/video.qml \
    resources/qml/test.qml \
    resources/qml/rectangle.qml \
    resources/qml/model.qml \
    resources/qml/main.qml \
    resources/qml/image.qml

RESOURCES += \
    resources.qrc
