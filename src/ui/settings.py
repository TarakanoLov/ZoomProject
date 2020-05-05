import sys  # sys нужен для передачи argv в QApplication
from PyQt5.QtCore import *
from PyQt5.QtWidgets import *
from PyQt5.QtQml import *
from PyQt5.QtGui import *
from PyQt5.QtQuick import *

class SettingsWindow(QApplication):
    def __init__(self,engine):
        print("kek")
 
    def show(self):
        #self.item.show()
        print("lol")

