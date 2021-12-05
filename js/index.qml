 import QtQuick 2.7
    import QtQuick.Controls 2.3
    Rectangle {
        color: "#179AF3"
        anchors.fill: parent
        Text {
            text: "KDE"
            font.pixelSize: 80
            font.bold: true
            color: "#82CB38"
            anchors.centerIn: parent
            RotationAnimator on rotation {
                running: true
                loops: Animation.Infinite
                from: 0
                to: 360
                duration: 1500
            }
        }
    }
