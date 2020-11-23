import QtQuick 2.0

Item {
    id: root
    property color borderColor: "grey"
    property alias labelText: baseLabelText.text
    property alias textColor: baseLabelText.color

    Rectangle {
        id: baseButton
        anchors.fill: parent
        border.width: 1
        border.color: root.borderColor
        color: "transparent"

        Text {
            id: baseLabelText
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: height * 0.4
            elide: Text.ElideRight
            color: "grey"
        }
    }
}
