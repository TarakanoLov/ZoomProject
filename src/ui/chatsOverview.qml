import QtQuick 2.13
import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.13
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.14
import QtQuick 2.10
import QtQuick.Layouts 1.3

ApplicationWindow {
    id:mainWindow
    objectName: "mainWindow"
    visible: true
    width: 900
    height: 800
    color: "#EDEDED"
    title: qsTr('Frameless')
    flags: Qt.Window | Qt.FramelessWindowHint
    property int previousX
    property int previousY

    property var globalId: id

    FontLoader {
        id: localFont
        source: "fonts/Raleway-Light.ttf"
    }




    MouseArea {
        anchors.fill: parent

        onPressed: {
            previousX = mouseX
            previousY = mouseY
        }

        onMouseXChanged: {
            var dx = mouseX - previousX
            mainWindow.setX(mainWindow.x + dx)
        }

        onMouseYChanged: {
            var dy = mouseY - previousY
            mainWindow.setY(mainWindow.y + dy)
        }

    }

    Rectangle {
        height: 461
        color: "#EDEDED"
        width: 650
        y: 70
        x: 250
        border.width: 0
        ListView {
            y: 0
            height: 520
            anchors.topMargin: 0
            anchors.fill: parent
            model: dialogModel
            delegate: dialogDelegate
            ScrollBar.vertical: ScrollBar {
                active: true
            }
            focus: true
        }
        Item{
            id: important
            x: 0
            y: 460

            Rectangle {
                id: rectangle

                width: 650
                height: 30
                color: "#ffffff"
                border.color: "#cecece"


            }

            CheckBox {
                id: checkBox
                x: 5
                y: 5
                width: 299
                height: 20
                font.family: "Raleway"
                text: qsTr("Показать только важные сообщения")
                hoverEnabled: true
                enabled: true
                indicator.width: 20
                indicator.height: 20

                checkState:{
                    if (checkState === Qt.Checked)
                        dialogModel.showImportant(globalId)
                    else
                        dialogModel.reload(globalId)
                }
            }
        }

        Component {
            id: dialogDelegate

            Rectangle{
                id: kek
                property var importantMessage: id
                height: root.height + 25
                width: 620
                color: "#EDEDED"
                Text{
                    height: 15
                    x: 15

                    color: "#FF1E1E"
                    font.family: "Raleway"
                    text: name
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHLeft
                }
                Rectangle {
                    id: root
                    width: 600
                    height: textInRoot.height + 20
                    radius: 5
                    x: 15
                    y: 20
                    color: "#ffffff"

                    Text{
                        id: textInRoot
                        clip: true
                        x: 10
                        y: 10
                        color: "#000000"
                        font.family: "Raleway"
                        font.pixelSize: 14
                        text: message
                        width: root.width - 20
                        wrapMode: Text.WordWrap
                        verticalAlignment: Text.AlignJustify
                    }
                    Button {
                        width: 20
                        height: 20
                        x: 580
                        Image {
                            source: "img/important.svg"
                            id: importantImage
                            width: 20
                            height: 20
                        }

                        background: Rectangle {
                            opacity: 0
                        }

                        ColorOverlay{
                            anchors.fill: importantImage
                            source: importantImage
                            color:  mouseAreaImportant.containsMouse ? "#5667FF" : important === 1 ? "red" : "black"
                            antialiasing: true
                        }
                        MouseArea {
                            id: mouseAreaImportant
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: dialogModel.makeImportant(importantMessage)
                        }
                    }
                }
            }
        }


    }


    Rectangle {
        id: side_bar
        y: 40
        width: 250
        height: 720
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
            width: 250; height: 690
            ListView {
                anchors.bottomMargin: 0
                anchors.fill: parent
                model: chatsModel
                delegate: chatsDelegate
                focus: true
                ScrollBar.vertical: ScrollBar {
                    active: true
                }
            }
            Component {
                id: chatsDelegate
                Rectangle {
                    height: 77
                    width: 235
                    property var chatId: id
                    Text {
                        height: 34
                        x: 13
                        y: 1
                        width: 215
                        text: name
                        color: text.name === 'Highlights' ? "#5667FF" : "black"
                        elide: Text.ElideRight
                        font.family: "Raleway"
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
                            id: contentImage
                            width: 20
                            height: 20
                        }

                        ColorOverlay{
                            anchors.fill: contentImage
                            source: contentImage
                            color:  mouseAreaContent.containsMouse ? "#5667FF" : "black"
                            antialiasing: true
                        }
                        MouseArea {
                            id: mouseAreaContent
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: { chatsModel.saveTxt(chatId)}
                        }



                        background: Rectangle {
                            opacity: 0
                        }
                    }

                    Button {
                        width: 20
                        height: 20
                        x: 124
                        y: 31

                        Image {
                            source: "img/show.svg"
                            id: viewImage
                            width: 20
                            height: 20
                        }

                        ColorOverlay{
                            anchors.fill: viewImage
                            source: viewImage
                            color:  mouseAreaView.containsMouse ? "#5667FF" : "black"
                            antialiasing: true
                        }
                        MouseArea {
                            id: mouseAreaView
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {globalId = chatId; chatsModel.viewChat(chatId); taskModel.reload(globalId)}
                        }

                        background: Rectangle {
                            opacity: 0
                        }
                    }

                    Button {
                        width: 20
                        height: 20
                        x: 222
                        y: 31
                        Image {
                            source: "img/side_bar_delete.svg"
                            id: deleteImage
                            width: 20
                            height: 20
                            clip: false
                        }

                        ColorOverlay{
                            anchors.fill: deleteImage
                            source: deleteImage
                            color:  mouseAreaDelete.containsMouse ? "#5667FF" : "black"
                            antialiasing: true
                        }
                        MouseArea {
                            id: mouseAreaDelete
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: chatsModel.deletePerson(index, chatId)
                        }

                        background: Rectangle {
                            opacity: 0
                        }

                    }

                    Button {
                        width: 20
                        height: 20
                        x: 188
                        y: 31
                        Image {
                            source: "img/side_bar_settings.svg"
                            id: settingsImage
                            width: 20
                            height: 20
                        }

                        background: Rectangle {
                            opacity: 0
                        }

                        ColorOverlay{
                            anchors.fill: settingsImage
                            source: settingsImage
                            color:  mouseAreaSettings.containsMouse ? "#5667FF" : "black"
                            antialiasing: true
                        }
                        MouseArea {
                            id: mouseAreaSettings
                            anchors.fill: parent
                            hoverEnabled: true
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

        Button {
            x: 0
            y: 0
            width: 250
            height: 30
            flat: false
            highlighted: false
            clip: false
            opacity: 1

            objectName: "testButton"
            contentItem: Text {
                id: reloadButton
                text: "Обновить беседы"
                font.family: "Raleway"
                color: "#000000"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
            background: Rectangle {
                opacity: 0
            }
            ColorOverlay{
                anchors.fill: reloadButton
                source: reloadButton
                color: mouseAreaReload.containsMouse ? "#5667FF" : "#000000"
                antialiasing: true
            }
            MouseArea {
                id: mouseAreaReload
                anchors.fill: parent
                hoverEnabled: true
                onClicked: chatsModel.reload()
            }
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
            width: 20
            height: 20
            x: 865
            y: 10
            signal exitApp
            Image {
                id:imcl
                source: "img/close.png"
                width: 20
                height: 20
                smooth: true
                mipmap: true
            }
            background: Rectangle {
                opacity: 0
            }
            ColorOverlay{
                anchors.fill: imcl
                source: imcl
                scale: mouseAreaClose.containsMouse ? 1.25:1
                antialiasing: true
            }
            MouseArea {
                id: mouseAreaClose
                anchors.fill: parent
                hoverEnabled: true
                onClicked: close()
            }
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


    Item{
        id: search
        y: 40
        x: 250
        width:650
        height:30
        Rectangle {
            color: "#ffffff"
            width:650
            height:30
            anchors.top: parent
            border.color: "#cecece"
            TextEdit {
                id: textEdit
                x: 15
                width: 621
                height: 30
                color: "#686868"
                text:    qsTr("Поиск")
                font.pixelSize: 14
                font.family: "Raleway"
                onTextChanged: dialogModel.searchStr(textEdit.text,globalId)
                verticalAlignment: Text.AlignVCenter
                onFocusChanged:{
                    if(focus)
                        text = ""
                    else
                        text = qsTr("Поиск")
                }
            }
        }
    }


    Rectangle {
        id: rectangle1
        x: 0
        y: 69
        width: 250
        height: 1
        color: "#cecece"
    }


    Rectangle {
        id: rectangle123
        x: 250
        y: 560
        width: 650
        height: 200
        color: "#ededed"




        Rectangle {
            height: 170
            color: "#EDEDED"
            y: 45
            width: 650
            border.width: 0
            ListView {
                y: 30
                height: 100
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0
                anchors.fill: parent
                model: taskModel
                delegate: tasksDelegate
                ScrollBar.vertical: ScrollBar {
                    active: true
                }
                focus: true
            }
            Component {
                id: tasksDelegate
                CheckBox {
                    id: checkBox1
                    text: name
                }
            }
        }

        Button {
            x: 0
            y: 0
            width: 177
            height: 30
            text: qsTr("Добавить новую заметку")

            id: taskButton
            background: Rectangle {
                opacity: 0
            }
            MouseArea {
                id: mouseAreaTask
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {print("lol"); taskModel.addTask(textEdit1.text,globalId); textEdit1.text = "Заметка" }
            }
            ColorOverlay{
                anchors.fill: taskButton
                source: taskButton
                color: mouseAreaTask.containsMouse ? "#5667FF" : "#000000"
                antialiasing: true
            }

        }
        Rectangle {
            id: rectangle2
            x: 177
            y: 0
            width: 473
            height: 30
            color: "#ffffff"
            border.color: "#cecece"
        }
    }

    Rectangle {
        id: bottom_bar
        border.width: 0
        x: 0
        y: 760
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

    TextEdit {
        id: textEdit1
        x: 433
        y: 560
        width: 467
        height: 30
        color: "#686868"
        text: qsTr("Заметка")
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 12

        onFocusChanged:{
            if(focus)
                text = ""
        }
    }

    Rectangle {
        x: 0
        id: butterfly1
        y: 0
        width: 900
        height: 800
        color: "#00000000"
        border.width: 1
        border.color: "#CECECE"

        Rectangle {
            id: rectangle3
            x: 251
            y: 589
            width: 176
            height: 1
            color: "#00000000"
            border.color: "#cecece"
        }
    }
}
