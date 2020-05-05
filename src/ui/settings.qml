import QtQuick 2.13
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.13
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.14

Window {
    width: 900
    height: 600
    objectName: "mainWindow"
    visible: true
    maximumWidth: 900
    maximumHeight: 600
    minimumWidth: 900
    minimumHeight: 600
    color: "#EDEDED"
    title: qsTr("Hello World")

    FontLoader {
    id: localFont
    source: "fonts/Raleway-Light.ttf"
    }

    Rectangle {

        id: top_bar
        x: 0
        y: 0
        border.width: 0
        width: 900
        height: 40
        color: "#ffffff"

        Rectangle {
            id: top_bar_border
            x: 0
            y: 40
            width: 900
            height: 1
            color: "#c5c5c5"
        }


        Button {
            objectName: "closeButton"
            width: 30
            height: 30
            x: 855
            y: 5
            signal exitApp
            Image {
                source: "img/close.png"
                width: 30
                height: 30
                smooth: true
                mipmap: true
            }
            background: Rectangle {
                    opacity: 0
            }

            onClicked: exitApp()
        }

        Text {
            id: top_bar_title
            x: 0
            y: 0
            width: 900
            height: 40
            text: qsTr("Zoom Project")
            font.family: "Raleway"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 12
        }
    }


    Rectangle {
        id: bottom_bar
        border.width: 0
        x: 0
        y: 560
        width: 900
        height: 40
        color: "#ffffff"
        transformOrigin: Item.Center
        antialiasing: false

        Rectangle {
            id: bottom_bar_border
            x: 0
            y: 0
            width: 900
            height: 1
            color: "#c5c5c5"
        }
    }

    Button {
        id: button
        x: 17
        y: 46
        width: 100
        height: 25
        text: qsTr("Button")
    }

    CheckBox {
        id: checkBox
        x: 21
        y: 86
        width: 857
        height: 40
        text: qsTr("Check Box")
    }

    Label {
        id: label
        x: 37
        y: 354
        text: qsTr("Некоторые важные сообщения")
    }

    Rectangle {
        id: rectangle
        x: 27
        y: 386
        width: 851
        height: 136
        color: "#ffffff"
    }

}
