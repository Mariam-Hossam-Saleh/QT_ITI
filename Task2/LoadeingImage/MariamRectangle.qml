import QtQuick
import QtQuick.Dialogs
import QtQuick.Controls


Rectangle {
    id: rectId
    signal rightClick
    signal leftClick
    MouseArea
    {
        anchors.fill: parent
        onDoubleClicked:
        {
            rectId.rightClick()
        }

        onClicked:
        {
            rectId.leftClick()
        }
    }
}
