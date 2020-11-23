import QtQuick 2.12
import QtQuick.Window 2.12 as W
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3

import QtQuick.Scene3D 2.12
import Qt3D.Core 2.12
import Qt3D.Render 2.12
import Qt3D.Input 2.12
import Qt3D.Extras 2.12

W.Window {
    id: mainWindow
    minimumWidth: 1225
    minimumHeight: 845
    title: "test_Polonskiy"
    visible: true

    property int previousX
    property int previousY
    MouseArea {
        height: parent.height*0.1
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        onPressed: {
            previousX = mouseX;
            previousY = mouseY;
        }

        onPositionChanged: {
            if(mainWindow.visibility == Window.Maximized) {
                showNormal();
            } else {
                mainWindow.setX(mainWindow.x + (mouseX - previousX));
                mainWindow.setY(mainWindow.y + (mouseY - previousY));
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
                GradientStop { position: 0.0; color: "#ffffff" }
                GradientStop { position: 1.0; color: "#505050" }
            }

        Rectangle{
            id: titlebar
            color: "black"
            height: parent.height*0.1
            width: parent.width*0.9

            anchors {
                top: parent.top
                left: parent.left
                margins: 10
            }

            Text {
                color: "white"
                font.family: "Verdana"
                anchors.margins: 5
                anchors.left: parent.left
                anchors.top: parent.top
                font.pixelSize: parent.height*0.1
                text: "v.10_7586_13580 dev"
            }

            Text {
                font.family: "Verdana"
                anchors.leftMargin: 10
                anchors.bottomMargin: 7
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                font.pixelSize: parent.height*0.25
                text: "<font color=\"white\">ZIRKONZAHN</font><font color=\"#F56330\">.Modifier</font>"
            }

            Button {
                height: parent.height
                width: parent.height
                anchors.right: parent.right
                onClicked: Qt.quit()
                background: Rectangle {
                    color: "black"

                    Image {
                        anchors.leftMargin: 25
                        anchors.rightMargin: 25
                        anchors.topMargin: 15
                        anchors.bottomMargin: 10
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: closebt.top
                        source: "qrc:/close.png"
                    }

                    Text {
                        id: closebt
                        anchors.bottomMargin: 15
                        horizontalAlignment: Text.AlignHCenter
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        color: "white"
                        text: "Close"
                    }

                }
            }
        }

        Rectangle{
            id: controlbar
            color: "#F56330"
            height: parent.height*0.1
            width: parent.height*0.1

            anchors {
                top: parent.top
                left: titlebar.right
                right: parent.right
                margins: 10
            }

            Text {
                color: "white"
                anchors.centerIn: parent
                font.pixelSize: parent.height*0.3
                text: "<font size=\"7\">M</font><font size=\"3\">F</font>"
            }

            Button {
                id: minimize
                height: parent.width/3
                width: parent.width/3
                anchors.left: parent.left
                background: Rectangle {
                    color: mouseAreaMin.containsMouse ? "#50ffffff" : "transparent"

                    Image {
                        anchors.fill: parent
                        source: "qrc:/minimize-button.png"
                    }

                }
                MouseArea {
                    id: mouseAreaMin
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: mainWindow.showMinimized()
                }

            }
            Button {
                id: maximize
                height: parent.width/3
                width: parent.width/3
                anchors.left: minimize.right
                background: Rectangle {
                    color: mouseAreaMax.containsMouse ? "#50ffffff" : "transparent"

                    Image {
                        anchors.fill: parent
                        source: mainWindow.visibility == Window.Maximized ? "qrc:/normal-button.png" : "qrc:/maximize-button.png"
                    }
                }
                MouseArea {
                    id: mouseAreaMax
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: mainWindow.visibility == Window.Maximized ? mainWindow.showNormal() : mainWindow.showMaximized()
                }
            }
            Button {
                id: close
                height: parent.width/3
                width: parent.width/3
                anchors.left: maximize.right
                background: Rectangle {
                    color: mouseAreaClose.containsMouse ? "#50ffffff" : "transparent"

                    Image {
                        anchors.fill: parent
                        source: "qrc:/close-button.png"
                    }
                }
                MouseArea {
                    id: mouseAreaClose
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: Qt.quit()
                }
            }
        }

        Rectangle{
            id: sidebar
            color: "black"
            height: parent.height*0.9
            width: parent.width*0.2

            anchors {
                top: titlebar.bottom
                left: parent.left
                bottom: parent.bottom
                margins: 10
            }

            Text {
                id: headerText
                width: parent.width * 0.96
                height: parent.height * 0.05
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height * 0.4
                anchors.right: parent.right
                color: "white"
                text: "WIZARD"
            }

            Rectangle {
                id: headSplitter
                width: parent.width
                height: 1
                color: "white"
                anchors.top: headerText.bottom
            }

            Item {
                anchors {
                    top: headSplitter.bottom
                    bottom: footerItem.top
                    left: parent.left
                    right: parent.right
                    margins: 10
                }

                ColumnLayout {
                    id: layouts
                    anchors.fill: parent
                    spacing: 10
                    readonly property real heightComponents: height * 0.05

                    CustomTextEdit {
                        Layout.fillWidth: true
                        Layout.preferredHeight: layouts.heightComponents
                        text: "Load scans"
                        colorText: "white"
                    }

                    CustomTextEdit {
                        Layout.fillWidth: true
                        Layout.preferredHeight: layouts.heightComponents
                        text: "Upper"
                        colorText: "white"
                    }

                    RowLayout {
                        Layout.fillWidth: true

                        CustomButton {
                            id: loadBttn
                            Layout.preferredHeight: layouts.heightComponents
                            Layout.fillWidth: true
                            buttonColor: "black"
                            buttonText: "Load"
                            textColor: "white"
                            isBorder: true
                            borderColor: "white"
                            onClicked: fileDialog.open()
                        }

                        CustomButton {
                            id: removeBttn
                            Layout.preferredHeight: layouts.heightComponents
                            Layout.fillWidth: true
                            buttonColor: "black"
                            buttonText: "Remove"
                            textColor: "white"
                            isBorder: true
                            borderColor: "white"

                            onClicked: {
                                sceneLoader.source = ""
                                fileNameComponent.labelText = ""
                            }
                        }
                    }

                    CustomLabel {
                        id: fileNameComponent
                        Layout.fillWidth: true
                        Layout.preferredHeight: layouts.heightComponents
                    }

                    Item {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }
                }
            }

            Rectangle {
                id: footerSplitter
                width: parent.width
                height: 1
                color: "white"
                anchors.bottom: footerItem.top
            }

            Item {
                id: footerItem
                width: parent.width
                height: parent.height * 0.08
                anchors.bottom: parent.bottom

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 10

                    CustomButton {
                        id: backBttn
                        isEnabled: false
                        Layout.preferredHeight: layouts.heightComponents
                        Layout.fillWidth: true
                        buttonColor: "black"
                        buttonText: "Back"
                        textColor: "white"
                        isBorder: true
                        borderColor: "white"
                    }

                    CustomButton {
                        id: nextBttn
                        isEnabled: false
                        Layout.preferredHeight: layouts.heightComponents
                        Layout.fillWidth: true
                        buttonColor: "black"
                        buttonText: "Next"
                        textColor: "white"
                        isBorder: true
                        borderColor: "white"
                    }
                }
            }
            }
        }

        Rectangle {
            id: scene
            color: "transparent"
            height: parent.height*0.865
            width: parent.width*0.775

            anchors {
                top: titlebar.bottom
                bottom: parent.bottom
                left: sidebar.right
                right: parent.right
                margins: 10
            }

            FileDialog
                {
                    id: fileDialog
                    folder: shortcuts.home
                    onAccepted:
                    {
                        const url = fileDialog.fileUrl

                        sceneLoader.source = url
                        fileNameComponent.labelText = (String(url).slice(String(url).lastIndexOf("/")+1))
                    }
                }

            Scene3D
                {
                    anchors.fill: parent

                    aspects: ["input", "logic"]
                    cameraAspectRatioMode: Scene3D.AutomaticAspectRatio

                    Entity
                    {
                        id: sceneRoot

                        Camera
                        {
                            id: camera
                            projectionType: CameraLens.PerspectiveProjection
                            fieldOfView: 90
                            aspectRatio: 16/9
                            nearPlane : 0.1
                            farPlane : 1000.0
                            position: Qt.vector3d( 0.0, 0.0, 40.0 )
                            upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
                            viewCenter: Qt.vector3d( 0.0, 0.0, 0.0 )
                        }

                        OrbitCameraController
                        {
                            camera: camera
                        }

                        components: [
                            RenderSettings
                            {
                                activeFrameGraph: ForwardRenderer
                                {
                                    clearColor: "transparent"
                                    camera: camera
                                }
                            },
                            InputSettings{}
                        ]

                        Entity {
                            components: [
                                DirectionalLight {
                                    worldDirection: Qt.vector3d(40.0, -40.0, 40.0).normalized();
                                    color: "#FFFFFF"
                                    intensity: 1.0
                                }
                            ]
                        }

                        Entity {
                            components: [
                                DirectionalLight {
                                    worldDirection: Qt.vector3d(-40.0, -40.0, -40.0).normalized();
                                    color: "#FFFFFF"
                                    intensity: 1.0
                                }
                            ]
                        }

                        Entity
                        {
                            id: monkeyEntity
                            components: [
                                SceneLoader
                                {
                                    id: sceneLoader
                                }
                            ]
                        }
                    }
                }
        }

    flags: Qt.Window | Qt.FramelessWindowHint
}
