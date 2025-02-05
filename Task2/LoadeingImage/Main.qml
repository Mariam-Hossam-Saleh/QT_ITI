import QtQuick
import QtQuick.Controls

Window {
    id: windowID
    width: 640
    height: 480
    visible: true
    title: qsTr("Task2 Loading Images")

    // Custom properties for buttons
    property bool button1: false
    property bool button2: false
    property bool button3: false
    property bool button4: false

    Column {
        //anchors.centerIn: parent
        spacing: 20
        width: parent.width * 0.8
        y: parent.height - 300
        x: width/7
        Row {
            spacing: 20
            width: parent.width
            Button {
                width: parent.width / 2 - 20
                height: 50
                text: button1 ? "Hide Image" : "Load Image from Working Directory"
                onClicked: button1 = !button1
            }

            Button {
                width: parent.width / 2 - 20
                height: 50
                text: button2 ? "Hide Image" : "Load Image from Working Directory"
                onClicked: button2 = !button2
            }
        }

        Row {
            spacing: 20
            width: parent.width
            Button {
                width: parent.width / 2 - 20
                height: 50
                text: button3 ? "Hide Image" : "Load Image from Working Directory"
                onClicked: button3 = !button3
            }

            Button {
                width: parent.width / 2 - 20
                height: 50
                text: button4 ? "Hide Image" : "Load Image from Working Directory"
                onClicked: button4 = !button4
            }
        }
    }

    Item {
        id: item1
        visible: button1
        anchors.fill: parent
        Image {
            id: img1ID
            height:  400
            width: 600
            y: windowID.height/6
            x: windowID.width/2 - (width/2)
            source: "file:ivi.jpg"
        }
        Text {
            id: image1Text
            text: qsTr("Method (1):Loaded Image from the working directory")
            y: img1ID.y + img1ID.height
            x: img1ID.x
        }
    }

    Item {
        id: item2
        visible: button2
        anchors.fill: parent
        Image {
            id: img2ID
            height:  400
            width: 600
            y: windowID.height/6
            x: windowID.width/2 - (width/2)
            source: "file:/home/mariam/Downloads/vehicle.jpg"
        }
        Text {
            id: image2Text
            text: qsTr("Method (2):Loaded Image from the full absolute path")
            y: img2ID.y + img2ID.height
            x: img2ID.x
        }
    }

    Item {
        id: item3
        visible: button3
        anchors.fill: parent
        Image {
            id: img3ID
            height:  400
            width: 600
            y: windowID.height/6
            x: windowID.width/2 - (width/2)
            source: "qrc:/images/car1.png"
        }
        Text {
            id: image3Text
            text: qsTr("Method (3):Loaded Image from resource file")
            y: img3ID.y + img3ID.height
            x: img3ID.x
        }
    }

    Item {
        id: item4
        visible: button4
        anchors.fill: parent
        Image {
            id: img4ID
            height:  400
            width: 600
            y: windowID.height/6
            x: windowID.width/2 - (width/2)
            source: "https://www.nuvisionautoglass.com/wp-content/uploads/2024/09/ADAS-in-Cars.webp"
        }
        Text {
            id: image4Text
            text: qsTr("Method (4):Loaded Image from URL")
            y: img4ID.y + img4ID.height
            x: img4ID.x
        }
    }
}
