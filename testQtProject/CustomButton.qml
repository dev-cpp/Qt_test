import QtQuick 2.0

Item {
    id: root
    property alias buttonColor: baseButton.color
    property alias buttonText: baseButtonText.text
    property alias textColor: baseButtonText.color
    property bool isBorder: false
    property bool isEnabled: true
    property color borderColor

    signal clicked()

    Rectangle {
        id: baseButton
        anchors.fill: parent

        Text {
            id: baseButtonText
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: height * 0.4
            wrapMode: Text.WordWrap
            maximumLineCount: 2
        }

        MouseArea {
            anchors.fill: parent
            enabled: root.isEnabled
            onClicked:  { root.clicked() }
        }

        Component.onCompleted: {
            if (root.isBorder) {
                border.color = root.borderColor
                border.width = 1
            }
        }
    }
}
