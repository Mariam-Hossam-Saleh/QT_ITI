import QtQuick

Window {
    id: win
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    Rectangle{
        anchors.centerIn: parent
        Rectangle{
            id: rect1
            width: 100
            height: 100
            visible: true
            color: "#F0A8D0"
            radius: 10
            x: parent.width*0.5 - 260
            y: parent.height*0.5 - 50
            Rectangle{
                id: rect1_1
                width: 80
                height: 80
                visible: true
                color: "#FFC6C6"
                radius: 10
               anchors.centerIn: parent
            }
            Text {
                id: rect1txt
                text: qsTr("Hello")
                anchors.centerIn: parent
                //font.pointSize: 50
                //font.family:
            }
        }
        Rectangle{
            id: rect2
            width: 100
            height: 100
            visible: true
            color: "#809D3C"
            radius: 10
            x: parent.width*0.5 - 140
            y: parent.height*0.5 - 50
            Rectangle{
                id: rect2_1
                width: 80
                height: 80
                visible: true
                color: "#A9C46C"
                radius: 10
               anchors.centerIn: parent
            }
            Text {
                id: rect2txt
                text: qsTr("World")
                anchors.centerIn: parent
                //font.pointSize: 50
                //font.family:
            }
        }
        Rectangle{
            id: rect3
            width: 100
            height: 100
            visible: true
            color: "#FFE6C9"
            radius: 10
            x: parent.width*0.5 - 20
            y: parent.height*0.5 - 50
            Rectangle{
                id: rect3_1
                width: 80
                height: 80
                visible: true
                color: "#FFC785"
                radius: 10
               anchors.centerIn: parent
            }
            Text {
                id: rect3txt
                text: qsTr("I'm")
                anchors.centerIn: parent
                //font.pointSize: 50
                //font.family:
            }
        }
        Rectangle{
            id: rect4
            width: 100
            height: 100
            visible: true
            color: "#2973B2"
            radius: 10
            x: parent.width*0.5 + 100
            y: parent.height*0.5 - 50
            Rectangle{
                id: rect4_1
                width: 80
                height: 80
                visible: true
                color: "#9ACBD0"
                radius: 10
               anchors.centerIn: parent
            }
            Text {
                id: rect4txt
                text: qsTr("Mariam")
                anchors.centerIn: parent
                //font.pointSize: 50
                //font.family:
            }
        }
        Rectangle{
            id: rect5
            width: 100
            height: 100
            visible: true
            color: "#D2665A"
            radius: 50
            x: parent.width*0.5 + 220
            y: parent.height*0.5 - 50
            Rectangle{
                id: rect5_1
                width: 80
                height: 80
                visible: true
                color: "#F2B28C"
                radius: 40
               anchors.centerIn: parent
            }
            Text {
                id: rect5txt
                text: qsTr("Hossam")
                anchors.centerIn: parent
                //font.pointSize: 50
                //font.family:
            }
        }
    }
}
