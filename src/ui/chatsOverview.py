import sys  # sys нужен для передачи argv в QApplication
from PyQt5.QtCore import *
from PyQt5.QtWidgets import *
from PyQt5.QtQml import *
from PyQt5.QtGui import *
from PyQt5.QtQuick import *
from .settings import *

class ChatOverview(QObject):

    def __init__(self,engine):
        self.engine = engine.load(QUrl(r'src/ui/chatsOverview.qml'))
        index = len(engine.rootObjects())
        self.settings = SettingsWindow(engine)
        self.item = engine.rootObjects()[index - 1]
        self.closeButton = self.item.findChild(QObject,"closeButton")
        self.closeButton.exitApp.connect(self.settings.show)
    
    def show(self):
        self.item.show()


