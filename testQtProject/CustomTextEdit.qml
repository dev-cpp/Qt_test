import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id: root
    property alias text: baseTextEdit.text
    property color colorText

    TextField {
        id: baseTextEdit
        width: parent.width
        height: parent.height
        font.pointSize: height * 0.3
        focus: true
        color: root.colorText
        background: Item {}

        onCursorVisibleChanged: {
            if (cursorVisible) {
                color = "orange"
            }

            else {
                color = root.colorText
            }
        }
    }

    Rectangle {
        id: splitter
        width: parent.width
        height: 1
        color: baseTextEdit.color
        anchors.top: baseTextEdit.bottom
    }
}
