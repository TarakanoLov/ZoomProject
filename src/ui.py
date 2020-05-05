#!/usr/bin/python
# coding: utf8
import sys  # sys нужен для передачи argv в QApplication
from PyQt5.QtCore import *
from PyQt5.QtWidgets import *
from PyQt5.QtQml import *
from PyQt5.QtGui import *
from PyQt5.QtQuick import *

class PersonModel(QAbstractListModel):

    NameRole = Qt.UserRole + 1
    AgeRole = Qt.UserRole + 2

    personChanged = pyqtSignal()

    def __init__(self, parent=None):
        super().__init__(parent)
        self.persons = [
            {'name': 'jon', 'age': 20},
            {'name': 'jane', 'age': 25}
        ]

    def data(self, index, role=Qt.DisplayRole):
        row = index.row()
        if role == PersonModel.NameRole:
            return self.persons[row]["name"]
        if role == PersonModel.AgeRole:
            return self.persons[row]["age"]

    def rowCount(self, parent=QModelIndex()):
        return len(self.persons)

    def roleNames(self):
        return {
            PersonModel.NameRole: b'name',
            PersonModel.AgeRole: b'age'
        }

    @pyqtSlot(str, int)
    def addPerson(self, name, age):
        self.beginInsertRows(QModelIndex(), self.rowCount(), self.rowCount())
        self.persons.append({'name': name, 'age': age})
        self.endInsertRows()

    @pyqtSlot(int, str, int)
    def editPerson(self, row, name, age):
        ix = self.index(row, 0)
        self.persons[row] = {'name': name, 'age': age}
        self.dataChanged.emit(ix, ix, self.roleNames())

    @pyqtSlot(int)
    def deletePerson(self, row):
        self.beginRemoveColumns(QModelIndex(), row, row)
        del self.persons[row]
        self.endRemoveRows()

def exitApp():
    QApplication.quit()

def main():
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()
    

    personModel = PersonModel()

    engine.rootContext().setContextProperty("PersonModel", personModel)

    engine.load(QUrl(r'ui/chatsOverview.qml'))
    engine.load(QUrl(r'ui/settings.qml'))
    chatOverview = engine.rootObjects()[0]
    settings = engine.rootObjects()[1]
    def settingShow():
        settings.show()

    def settingClose():
        settings.close()



    buttonChatOverviewClose = chatOverview.findChild(QObject,"closeButton")
    buttonChatOverviewShowSettings = chatOverview.findChild(QObject,"settingsButton")
    buttonChatOverviewClose.exitApp.connect(exitApp)
    buttonChatOverviewShowSettings.settingsShow.connect(settingShow)

    buttonSettingsClose = settings.findChild(QObject,"closeButton")
    buttonSettingsClose.exitApp.connect(settingClose)

    chatOverview.show()
    
    #buttonClose = addNewChat.findChild(QObject,"closeButton")
    
    
    #newChat = addNewChat.findChild(QObject,"addNewChat")
    #newChat.show()
    #rootObject.show()


    #buttonClose.exitApp.connect(exitApp)
    #view.show()
    #kek = view.rootObject()
    #print(kek)
    #kek.exitApp.connect(exitApp)
    app.exec_()

if __name__ == '__main__':
    main()

