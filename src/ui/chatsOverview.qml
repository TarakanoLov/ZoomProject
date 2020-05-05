import QtQuick 2.13
import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.13
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.14
ApplicationWindow {
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
    source: "Raleway-Light.ttf"
    }



    Rectangle {
        height: 520
        color: "#00000000"
        width: 650
        y: 40
        x: 250
        border.width: 0
        Item {
           Text{
                width: 90
                height: 15
                y: 360
                x: 15
                color: "#FF1E1E"
                text: qsTr("Марина")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
           Text{
                width: 135
                height: 15
                y: 360
                x: 500
                color: "#c5c5c5"
                text: qsTr("Дата: 28.04.2020 14:30")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            Rectangle {
                x: 15
                y: 380
                width: 620
                height: 120
                radius: 5
            }
        }
    }

    Rectangle {
        id: side_bar
        y: 40
        width: 250
        height: 520
        border.width: 0



        Rectangle {
            id: side_bar_border_right
            x: 250
            y: 0
            width: 1
            height: 520
            color: "#c5c5c5"

        }

        Rectangle {
            y: 30
            width: 250; height: 490
            ListView {
                anchors.fill: parent
                model: PersonModel
                delegate: contactDelegate
                focus: true
            }
            Component {
                id: contactDelegate
                Rectangle {
                    height: 77
                    width: 235
                    Text {
                        height: 34
                        width: 235
                        x: 13
                        y: 1
                        text: name
                        font.family: "Raleway"
                        verticalAlignment: Text.AlignCenter
                        horizontalAlignment: Text.AlignLeft
                        font.pixelSize: 14
                    }
                    Button {
                        width: 20
                        height: 20
                        x: 154
                        y: 31
                        Image {
                            source: "img/side_bar_content.svg"
                            width: 20
                            height: 20
                        }
                        onClicked: PersonModel.addPerson("index","lol")
                    }

                    Button {
                        width: 20
                        height: 20
                        x: 222
                        y: 31
                        Image {
                            source: "img/side_bar_delete.svg"
                            width: 20
                            height: 20
                            clip: false
                        }
                        onClicked: PersonModel.deletePerson(index)
                    }

                    Item {
                        width: 20
                        height: 20
                        x: 188
                        y: 31
                        Image {
                            source: "img/side_bar_settings.svg"
                            width: 20
                            height: 20
                        }
                    }

                    Text {
                        height: 14
                        width: 133
                        x: 1
                        y: 57
                        color: "#C5C5C5"
                        text: qsTr("Дата: 28.04.2020 14:30")
                        font.family: "Raleway"
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: 11
                    }

                    Rectangle {
                        id: active
                        x: 152
                        y: 57
                        width: 88
                        height: 14
                        color: "#11D000"
                        radius: 5
                        Text {
                            height: 14
                            width: 64
                            x: 12
                            text: qsTr("Активно")
                            font.family: "Raleway"
                            color: "#FFFFFF"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 12
                        }
                    }
                }
            }
        }

        Text {
            width: 250
            height: 30
            color: "black"
            text: qsTr("Добавить новую беседу или поиск")
            font.family: "Raleway"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 12
        }
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

        Button {
            objectName: "settingsButton"
            x: 15
            y: 6
            width: 30
            height: 30
            signal settingsShow
            Image {
                source: "img/settings.svg"
                width: 30
                height: 30
                smooth: true
                mipmap: true
            }

            background: Rectangle {
                    opacity: 0
            }
            onClicked: settingsShow()
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


/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:14;invisible:true}
}
##^##*/
