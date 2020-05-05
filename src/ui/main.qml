import QtQuick 2.13
import QtQuick.Window 2.13
import QtGraphicalEffects 1.14

Window {
    visible: true
    width: 450
    height: 600
    color: "#EDEDED"
    title: qsTr("Hello World")

    Rectangle {

        id: top_bar
        x: 0
        y: 0
        border.width: 0
        width: 450
        height: 40
        color: "#ffffff"

        Rectangle {
            id: top_bar_border
            x: 0
            y: 40
            width: 450
            height: 2
            color: "#c5c5c5"
        }

        Item {
            Image {
                source: "img/close.png"
                width: 30
                height: 30
                smooth: false
                x: 405
                y: 5
            }
        }

        Text {
            id: top_bar_titile
            x: 0
            y: 0
            width: 450
            height: 40
            text: qsTr("Zoom Project")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 12
        }
    }

    Text {
        x: 35
        y: 64
        width: 380
        height: 28
        text: "Привет и добро пожаловать"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 24
    }

    Text {
        x: 35
        y: 122
        width: 380
        height: 28
        text: "Представься"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 24
    }

    Item {
        id: root
        Rectangle {
            x: 35
            y: 181
            width: 380
            height: 50
            color: "#ffffff"
            radius: 5
            TextEdit {
                id: textEdit
                x: 0
                y: 0
                width: 380
                height: 50
                text: qsTr("Логин")
                color: "#c5c5c5"
                wrapMode: Text.NoWrap
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 24

            }
        }


    }

    Rectangle {
        x: 35
        y: 271
        width: 380
        height: 50
        color: "#ffffff"
        radius: 5

        TextEdit {
            id: textEdit1
            x: 0
            y: 0
            width: 380
            height: 50
            color: "#c5c5c5"
            text: qsTr("И пароль")
            wrapMode: Text.NoWrap
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 24
        }


    }

    Rectangle {
        id: button
        x: 35
        y: 361
        width: 380
        height: 50
        color: "#4F5766"
        radius: 5
    }

    Rectangle {
        border.width: 0
        id: bottom1
        x: 0
        y: 560
        width: 450
        height: 40
        color: "#ffffff"
        transformOrigin: Item.Center
        antialiasing: false

        Rectangle {
            id: border_bottom
            x: 0
            y: 0
            width: 450
            height: 2
            color: "#c5c5c5"
        }

        Item {
            Image {
                source: "img/settings.svg"
                width: 30
                height: 30
                x: 15
                y: 5
            }
        }

        Item {
            Image {
                source: "img/phone.svg"
                width: 30
                height: 30
                x: 55
                y: 5
            }
        }
    }

}
