import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: win
    visible: true
    width: 1920
    height: 1080
    title: "PWM Car Headlight Control"

    // StackView for navigation
    StackView {
        id: stackView
        initialItem: homePage
        anchors.fill: parent
    }

    // Home Page
    Component {
        id: homePage

        Page {
            id: homePageContent
            anchors.fill: parent // Fill the entire window

            // Background
            Rectangle {
                anchors.fill: parent
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#E8F9FF" }
                    GradientStop { position: 1.0; color: "#FBFBFB" }
                }
            }
            Image {
                id: logo
                source: "qrc:/itilogo.svg"
                width: 300
                height: 300
                x:parent.width/2 - 150
                y:parent.height/2 - 300
                anchors.margins: 20
                fillMode: Image.PreserveAspectFit
            }

            Column {
                spacing: 10
                anchors.horizontalCenter: parent.horizontalCenter
                x: win.width/2
                y: win.height/2
                Text {
                    text: "Car Headlights PWM Controller"
                    color: "grey"
                    font {
                        pixelSize: 32
                        bold: true
                        family: "Arial"
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "Developed By: Mariam HossamEldin"
                    color: "grey"
                    font {
                        pixelSize: 24
                        family: "Arial"
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "ITI 9months Embedded Systems Program"
                    color: "grey"
                    font {
                        pixelSize: 24
                        family: "Arial"
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
            // Button to navigate to the second page
            Button {
                text: "Go to App Page"
                x:parent.width/2 - 100
                y:parent.height/2 + 150
                width: 200
                height: 50

                background: Rectangle {
                    color: parent.down ? "grey" : "#A94A4A"
                    radius: 10
                }

                contentItem: Text {
                    text: parent.text
                    font.pixelSize: 18
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {
                    // Navigate to the second page
                    stackView.push(secondPage)
                }
            }
        }
    }

    // Second Page
    Component {
        id: secondPage

        Page {
            id: secondPageContent
            anchors.fill: parent // Fill the entire window

            Rectangle {
                anchors.fill: parent
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#000000" } // Black
                    GradientStop { position: 1.0; color: "#1A1A1A" } // Dark grey
                }
            }

            Rectangle {
                width: gifAnimation.width + 200
                height: gifAnimation.height + 200
                anchors.centerIn: parent
                border.color: "black"
                border.width: 200

                AnimatedImage {
                    id: gifAnimation
                    source: "qrc:/Car.gif"
                    anchors.centerIn: parent
                    playing: false // Start with the GIF paused
                    onCurrentFrameChanged: {
                        // Perform an action when the GIF reaches a specific frame
                        if (currentFrame === greenFrame)
                        {
                            greenRGB();
                        }
                        else if (currentFrame === 36)
                        {
                            rect1.border.color = "#grey"
                        }
                        else if (currentFrame === cyanFrame)
                        {
                            cyanRGB();
                        }
                        else if (currentFrame === 74)
                        {
                            rect1.border.color = "#grey"
                        }
                        else if (currentFrame === orangeFrame)
                        {
                            orangeRGB();
                        }
                        else if (currentFrame === 112)
                        {
                            rect1.border.color = "#grey"
                        }
                    }
                    Image {
                        id: logo
                        source: "qrc:/itilogo.png"
                        width: 100
                        height: 100
                        x: -50
                        anchors.left: parent.left - 100
                        anchors.top: parent.top - 100
                        anchors.margins: 20
                        fillMode: Image.PreserveAspectFit
                    }
                }
            }

            // Track the current frame manually
            property int currentFrame: 0

            // Define the target frame for the action
            property int greenFrame: 3

            // Define the target frame for the action
            property int cyanFrame: 41

            // Define the target frame for the action
            property int orangeFrame: 79

            // SequentialAnimation to control playback
            SequentialAnimation {
                id: gifController
                running: gifAnimation.playing

                // Advance to the next frame
                ScriptAction {
                    script: {
                        if (currentFrame < gifAnimation.frameCount - 1) {
                            currentFrame += 1;
                        } else {
                            currentFrame = 0; // Loop back to the first frame
                        }
                        gifAnimation.currentFrame = currentFrame; // Update the GIF frame
                    }
                }

                // Add a delay between frames (based on the GIF's frame rate)
                PauseAnimation {
                    duration: gifAnimation.frameRate > 0 ? 1000 / gifAnimation.frameRate : 100 // Default to 100ms if frame rate is unknown
                }

                // Loop the animation
                onStopped: {
                    if (gifAnimation.playing) {
                        gifController.restart();
                    }
                }
            }

            Button {
                id: btn
                width: 150
                height: 80
                text: gifAnimation.playing ? "Pause PWM" : gifAnimation.paused ? "Resume PWM" : "Start PWM"
                contentItem: Text {
                    text: parent.text
                    color: "black"
                    font.pixelSize: 22
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                background: Rectangle {
                    id:rect1
                    anchors.fill: parent
                    color: "grey"
                    opacity: 0.5
                    radius: width / 2
                    border.width: 8
                }
                x: parent.width/2 - btn.width/2
                y: btn.height*2
                onClicked: {
                    if (gifAnimation.playing) {
                        // Pause the GIF
                        gifAnimation.playing = false;
                        gifController.stop();
                    } else {
                        // Resume or start the GIF
                        gifAnimation.playing = true;
                        gifController.restart();
                    }
                backend.togglePWM0();
                }
            }

            function greenRGB() {
                console.log("Target frame reached! Setting RGP to green...");
                rect1.border.color = "#16FF00"
                backend.turnOffGPIO23();
                backend.turnOffGPIO24();
            }

            function cyanRGB() {
                console.log("Target frame reached! Setting RGP to cyan...");
                rect1.border.color = "cyan"
                backend.turnOnGPIO24();
                backend.turnOffGPIO23();
            }

            function orangeRGB() {
                console.log("Target frame reached! Setting RGP to orange...");
                rect1.border.color = "#FF8F00"
                backend.turnOnGPIO23();
                backend.turnOffGPIO24();
            }
        }
    }
}

