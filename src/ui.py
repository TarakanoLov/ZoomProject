#!/usr/bin/python
# coding: utf8
import sys  # sys нужен для передачи argv в QApplication
from PyQt5.QtCore import *
from PyQt5.QtWidgets import *
from PyQt5.QtQml import *
from PyQt5.QtGui import *
from PyQt5.QtQuick import *
from db.dbApi import *
from text_form_of_audio import *

class TasksModel(QAbstractListModel):
    TasksRole = Qt.UserRole + 1
    MessageRole = Qt.UserRole + 2

    tasksChanged = pyqtSignal()

    def __init__(self, parent=None):
        super().__init__(parent)
        self.task = []

    def data(self, index, role=Qt.DisplayRole):
        row = index.row()
        if role == TasksModel.TasksRole:
            return self.task[row]["name"]

    def rowCount(self, parent=QModelIndex()):
        return len(self.task)

    def roleNames(self):
        return {
            TasksModel.TasksRole: b'name',
        }

    @pyqtSlot(int)
    def reload(self,indx):
        result = getAllTasks(indx)
        self.beginResetModel()
        self.task = []
        for item in result:
            self.task.append({'name':item[2]})
        self.endResetModel()

    @pyqtSlot(str,int)
    def addTask(self,text,indx):
        print(indx)
        if indx == 0:
            return
        if text == "":
            return
        print(text)
        addTask(indx,text)
        self.reload(indx)

class DialogModel(QAbstractListModel):
    NameRole = Qt.UserRole + 1
    MessageRole = Qt.UserRole + 2
    ImportantRole = Qt.UserRole + 3
    IdRole = Qt.UserRole + 4
    #TimeRole = Qt.UserRole + 3

    dialogChanged = pyqtSignal()

    def __init__(self, parent=None):
        super().__init__(parent)
        allConferences = getMessagesByConferenceId(26)
        self.dialog = []
        for item in allConferences:
            self.dialog.append({'name':item[1],'id':[5],'message':item[2],'important':item[4]})

    def data(self, index, role=Qt.DisplayRole):
        row = index.row()
        if role == DialogModel.NameRole:
            return self.dialog[row]["name"]
        if role == DialogModel.IdRole:
            return self.dialog[row]["id"]
        if role == DialogModel.MessageRole:
            return self.dialog[row]["message"]
        if role == DialogModel.ImportantRole:
            return self.dialog[row]["important"]

    def rowCount(self, parent=QModelIndex()):
        return len(self.dialog)

    def roleNames(self):
        return {
            DialogModel.NameRole: b'name',
            DialogModel.MessageRole: b'message',
            DialogModel.IdRole: b'id',
            DialogModel.ImportantRole: b'important'
        }
    
    @pyqtSlot(int)
    def reload(self,id):
        allConferences = getMessagesByConferenceId(id)
        self.dialog = []
        self.beginResetModel()
        for item in allConferences:
            self.dialog.append({'name':item[1],'id':item[5],'message':item[2], 'important':item[4]})
        self.endResetModel()

    @pyqtSlot(str, int)
    def searchStr(self,str, indx):
        if str == "":
            self.reload(indx)
            return
        self.reload(indx)
        newDialogs = []
        for message in self.dialog:
            if str in message['message']:
                newDialogs.append(message)
        self.beginResetModel()
        self.dialog = newDialogs
        self.endResetModel()

    @pyqtSlot(int)
    def makeImportant(self,indx):
        important = importantMessage(indx)[0][0]
        if important == 0:
            important = 1
        elif important == 1:
            important = 0
        setImportant(indx,important)
        confId = getConIdByMessageId(indx)[0][0]
        self.reload(confId)
        
    @pyqtSlot(int)
    def showImportant(self,id):
        importantConferences = getImportantMessageByConf(id)
        self.dialog = []
        self.beginResetModel()
        for item in importantConferences:
            self.dialog.append({'name':item[1],'id':item[5],'message':item[2], 'important':item[4]})
        self.endResetModel()

        
        

def findNewData():
    newData = get_list_of_message_from_recognize_audio()
    for chat in newData:
        inserId = addNewConference(chat['conference_name'],chat['conference_id'])[0][0]
        messages = chat['users_messages']
        confResult = chat['conference_summary']
        for message in messages:
            addMessage(inserId,message['user'],message['text'],None)
        for item in confResult:
            addMessage(inserId,"Highlights",item, None)

class ChatsModel(QAbstractListModel):

    NameRole = Qt.UserRole + 1
    IdRole = Qt.UserRole + 2

    personChanged = pyqtSignal()

    def __init__(self, parent=None):
        super().__init__(parent)
        self.dialogModel = DialogModel()
        self.taskModel = TasksModel()
        allConferences = getAllConferences()
        self.chats = []
        for item in allConferences:
            self.chats.append({'name':item[1],'id':item[0]})
            print(item[2])
            
    def getDialogModel(self):
        return self.dialogModel

    def getTasksModel(self):
        return self.taskModel

    def data(self, index, role=Qt.DisplayRole):
        row = index.row()
        if role == ChatsModel.NameRole:
            return self.chats[row]['name']
        if role == ChatsModel.IdRole:
            return self.chats[row]['id']

    def rowCount(self, parent=QModelIndex()):
        return len(self.chats)

    def roleNames(self):
        return {
            ChatsModel.NameRole: b'name',
            ChatsModel.IdRole: b'id'
        }

    @pyqtSlot()
    def reload(self):
        findNewData()
        self.chats.clear()
        allConferences = getAllConferences()
        self.beginResetModel()
        self.chats.clear()
        self.endResetModel()
        for item in allConferences:
            self.beginInsertRows(QModelIndex(), self.rowCount(), self.rowCount())
            self.chats.append({'name':item[1],'id':item[0]})
            self.endInsertRows()
        
    @pyqtSlot(int)
    def saveTxt(self,id):
        print(id)
        file = open(f"{id}.txt","w")
        string = ""
        for item in getMessagesByConferenceId(id):
            string = item[1] + ": " + item[2] + "\n"
            file.write(string)
        file.close

    @pyqtSlot(int)
    def viewChat(self, id):
        self.dialogModel.reload(id)

    @pyqtSlot(int, str, int)
    def editPerson(self, row, name, age):
        ix = self.index(row, 0)
        self.chats[row] = {'name': name}
        self.dataChanged.emit(ix, ix, self.roleNames())

    @pyqtSlot(int, int)
    def deletePerson(self, row, chatId):
        self.beginRemoveColumns(QModelIndex(), row, row)
        del self.chats[row]
        self.endRemoveRows()
        deleteConference(chatId)
        deleteMessages(chatId)



def exitApp():
    QApplication.quit()

def main():
    app = QApplication(sys.argv)
    
    engine = QQmlApplicationEngine()
    

    chatsModel = ChatsModel()
    #dialogModel = DialogModel()
    engine.rootContext().setContextProperty("chatsModel", chatsModel)
    engine.rootContext().setContextProperty("dialogModel", chatsModel.getDialogModel())
    engine.rootContext().setContextProperty("taskModel", chatsModel.getTasksModel())
    engine.load(QUrl(r'ui/chatsOverview.qml'))
    chatOverview = engine.rootObjects()[0]
    #settings = engine.rootObjects()[1]

    def settingShow():
        settings.show()

    def settingClose():
        settings.close()



    buttonChatOverviewClose = chatOverview.findChild(QObject,"closeButton")
    buttonChatOverviewShowSettings = chatOverview.findChild(QObject,"settingsButton")
    buttonChatOverviewClose.exitApp.connect(exitApp)
    buttonChatOverviewShowSettings.settingsShow.connect(settingShow)

    #buttonSettingsClose = settings.findChild(QObject,"closeButton")
    #buttonSettingsClose.exitApp.connect(settingClose)
    app.exec_()

if __name__ == '__main__':
    main()

