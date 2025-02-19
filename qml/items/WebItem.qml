import QtQuick 2.4
import QtWebKit 3.0

Rectangle {
    id: webItemRoot
    objectName: "rootItem"
    property string type : "web"
    property string source
    property int fontSize
    property string fontFamily
    property string captionAlign
    property string textAlign

    property real widthCoeff : 1
    property real heightCoeff : 1

    property real xCoeff : 1
    property real yCoeff : 1

    property int titleY

    signal urlChanged(string url)

    onCaptionAlignChanged: {
        if ( webItemRoot.captionAlign === "top" ) {
            titleRect.anchors.top = titleRect.parent.top
        }
        else if ( webItemRoot.captionAlign === "bottom" ) {
            titleRect.anchors.bottom = titleRect.parent.bottom
        }
    }

    onTextAlignChanged: {
        if ( webItemRoot.textAlign === "center") {
            titleText.horizontalAlignment = Text.AlignHCenter
            fullscreenImage.anchors.right = titleRect.right
            backImage.anchors.right = fullscreenImage.left
        }
        else  if ( webItemRoot.textAlign === "left") {
            titleText.horizontalAlignment = Text.AlignLeft
            fullscreenImage.anchors.right = titleRect.right
            backImage.anchors.right = fullscreenImage.left
        }
        else  if ( webItemRoot.textAlign === "right") {
            titleText.horizontalAlignment = Text.AlignRight
            fullscreenImage.anchors.left = titleRect.left
            backImage.anchors.left = fullscreenImage.right
        }
    }

    onParentChanged: {
        widthCoeff = width/parent.width
        heightCoeff = height/parent.height
        xCoeff = x/parent.width
        yCoeff = y/parent.height
    }

    Rectangle {
        id: titleRect
        objectName: "Caption"
        width: parent.width
        height: titleText.height + 15
        opacity: 0.1
        clip: true
        z: 1
        Text {
            id: titleText
            objectName: "CaptionText"
            width: parent.width
            font.pixelSize: webItemRoot.fontSize
            font.family: webItemRoot.fontFamily
            verticalAlignment: Text.AlignVCenter
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                titleRect.opacity = 0.7
            }
            onExited: {
                titleRect.opacity = 0.1
            }
        }

        Behavior on opacity  {
            PropertyAnimation{}
        }

        Image {
            id: backImage
            anchors {
                top: parent.top
                left: fullscreenImage.right
                topMargin: 3
                leftMargin: 5
                rightMargin: 5
            }
            opacity: (webView.canGoBack) ? 1.0 : 0.5
            source: "qrc:/icons/back.png"
            width: parent.height - 6
            height: parent.height - 6
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (webView.canGoBack ) {
                        webView.goBack()
                    }
                }
            }
        }
        Image {
            id: forwardImage
            anchors {
                top: parent.top
                left: backImage.right
                topMargin: 3
                leftMargin: 5
                rightMargin: 5
            }
            opacity: (webView.canGoForward) ? 1.0 : 0.5
            source: "qrc:/icons/forward.png"
            width: parent.height - 6
            height: parent.height - 6
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (webView.canGoForward ) {
                        webView.goForward()
                    }
                }
            }
        }

        Image {
            id: fullscreenImage
            objectName: "fullScreenImage"
            property string fullScreenSrc: "qrc:/icons/fullscreen.png"
            property string fullScreenExitSrc: "qrc:/icons/fullscreen_exit.png"
            anchors {
                top: parent.top
                topMargin: 3
                leftMargin: 5
                rightMargin: 5
            }

            states:[
                State {
                    name: "full"
                    PropertyChanges {
                        target: fullscreenImage
                        source: fullScreenExitSrc
                    }
                    PropertyChanges {
                        target: webItemRoot
                        width: (webItemRoot.parent) ? webItemRoot.parent.width : 0
                        height: (webItemRoot.parent) ? webItemRoot.parent.height : 0
                        x: 0
                        y: 0
                        z: 2

                    }
                },
                State {
                    name: "native"
                    PropertyChanges {
                        target: fullscreenImage
                        source: fullScreenSrc
                    }
                    PropertyChanges {
                        target: webItemRoot
                        width: (webItemRoot.parent) ? widthCoeff*webItemRoot.parent.width : 0
                        height: (webItemRoot.parent) ? heightCoeff*webItemRoot.parent.height : 0
                        x: (webItemRoot.parent) ? xCoeff*webItemRoot.parent.width : 0
                        y: (webItemRoot.parent) ? yCoeff*webItemRoot.parent.height : 0
                        z: 1

                    }
                }
            ]
            //            transitions: [
            //              Transition {
            //                  from: "full"; to: "native"
            //                  PropertyAnimation { target: item
            //                                      properties: "width,height"; duration: 1000;  }
            //              },
            //              Transition {
            //                  from: "native"; to: "full"
            //                  PropertyAnimation { target: item
            //                                      properties: "width,height"; duration: 1000;}
            //              } ]

            state: "native"
            source: fullScreenSrc
            width: parent.height - 6
            height: parent.height - 6
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (fullscreenImage.state === "full" ) {
                        fullscreenImage.state = "native"
                        titleRect.y = webItemRoot.titleY
                    }
                    else {
                        fullscreenImage.state = "full"
                        if ( titleY !== 0 ) {
                            titleRect.y = webItemRoot.height - titleRect.height
                        }
                        titleRect.opacity = 0.0
                    }
                }

            }

        }

    }
    WebView {
        id: webView
        objectName: "webView"
        anchors.fill: parent
        boundsBehavior: Flickable.StopAtBounds
        url: (source) ? source : "http://google.com"
        onUrlChanged: {
            webItemRoot.urlChanged(url)
        }
        onLoadingChanged: {
            if ( loadRequest.status === WebView.LoadStartedStatus)
            {
                var urll = loadRequest.url
                //                    stop()
                //                    loadHtml(urll)
            }
        }

        //            preferredHeight: flickable.height
        //            preferredWidth: flickable.width
    }

}
