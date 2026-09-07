import QtQuick 2.15
import QtQuick.Window 2.15

Rectangle {
    id: root
    color: "#000000" // Pure monochrome black background

    property int stage: 0

    onStageChanged: {
        if (stage >= 1 && !introAnimation.running && content.opacity === 0) {
            introAnimation.running = true;
        }
        if (stage == 5) {
            fadeOutBusy.running = true;
        }
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0

        // Main Center Content
        Column {
            anchors.centerIn: parent
            spacing: 28

            // Custom Logo Badge
            Item {
                width: 120
                height: 120
                anchors.horizontalCenter: parent.horizontalCenter

                // Outer geometric white ring
                Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "#ffffff"
                    border.width: 1
                    radius: width / 2
                    opacity: 0.8
                }

                // Inner Custom SVG Logo
                Image {
                    id: logo
                    anchors.centerIn: parent
                    width: 76
                    height: 76
                    source: "images/logo.svg"
                    asynchronous: true
                    smooth: true
                }
            }

            // Title Typography
            Text {
                text: "SPACE NEON"
                color: "#ffffff"
                font.pixelSize: 16
                font.bold: true
                font.letterSpacing: 4
                font.family: "Monospace"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            // Minimal Busy Spinner Ring
            Item {
                id: busyWidgetContainer
                width: 32
                height: 32
                anchors.horizontalCenter: parent.horizontalCenter

                Image {
                    id: busyWidget
                    anchors.fill: parent
                    source: "images/busywidget.svg"
                    asynchronous: true
                    smooth: true

                    RotationAnimator on rotation {
                        from: 0
                        to: 360
                        duration: 1600
                        loops: Animation.Infinite
                        running: true
                    }
                }
            }
        }

        // Minimal Progress Bar
        Rectangle {
            id: progressBarBackground
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 70
            anchors.horizontalCenter: parent.horizontalCenter
            width: 220
            height: 2
            color: "#222222"
            radius: 1

            Rectangle {
                id: progressBar
                height: parent.height
                width: parent.width * Math.min(1.0, Math.max(0.05, root.stage / 6.0))
                color: "#ffffff"
                radius: 1

                Behavior on width {
                    NumberAnimation { duration: 250; easing.type: Easing.OutCubic }
                }
            }
        }

        // Bottom Footer (KDE Plasma Branding)
        Row {
            spacing: 8
            anchors {
                bottom: parent.bottom
                right: parent.right
                margins: 24
            }
            opacity: 0.6

            Text {
                color: "#ffffff"
                anchors.verticalCenter: parent.verticalCenter
                text: "KDE Plasma"
                font.pixelSize: 11
                font.family: "Monospace"
            }

            Image {
                asynchronous: true
                source: "images/kde.svg"
                width: 16
                height: 16
                smooth: true
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    // Smooth Intro Fade-In Animation (Breeze lifecycle)
    OpacityAnimator {
        id: introAnimation
        target: content
        from: 0
        to: 1
        duration: 400
        easing.type: Easing.InOutQuad
    }

    // Fade Out Busy Spinner at stage 5
    OpacityAnimator {
        id: fadeOutBusy
        target: busyWidgetContainer
        from: 1
        to: 0
        duration: 300
        easing.type: Easing.InOutQuad
    }
}
