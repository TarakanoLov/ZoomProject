import sqlite3
import os.path

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
db_path = os.path.join(BASE_DIR, 'database.db3')

def getAllConferences():
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM Conferences')
    results = cursor.fetchall()
    conn.close()
    return results

def addNewConference(conferenceName, conferenceId):
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    cursor.execute("INSERT INTO Conferences VALUES(Null, '{}', '{}')".format(conferenceName, conferenceId))
    conn.commit()
    cursor.execute('SELECT last_insert_rowid()')
    results = cursor.fetchall()
    conn.close()
    return results

def getAmountOfConferences():
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM Conferences')
    results = cursor.fetchall()
    conn.close()
    return len(results)

def addMessage(id, userName, message, timeCreate):
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    cursor.execute("INSERT INTO Messages VALUES('{}', '{}', '{}', '{}', 0, NULL)".format(id, userName, message, timeCreate))
    conn.commit()
    conn.close()

def getMessagesByConferenceId(id):
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM Messages WHERE _id={}'.format(id))
    results = cursor.fetchall()
    conn.close()
    return results

def lastInsertID():
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    cursor.execute('SELECT last_insert_rowid()')
    results = cursor.fetchall()
    conn.close()
    return results

def importantMessage(id):
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    cursor.execute('SELECT important FROM Messages WHERE message_id={}'.format(id))
    results = cursor.fetchall()
    conn.close()
    return results

def getConIdByMessageId(id):
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    cursor.execute('SELECT _id FROM Messages WHERE message_id={}'.format(id))
    results = cursor.fetchall()
    conn.close()
    return results

def deleteConference(id):
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    cursor.execute('DELETE FROM Conferences WHERE _id={}'.format(id))
    conn.commit()
    conn.close()

def deleteMessages(id):
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    cursor.execute('DELETE FROM Messages WHERE _id={}'.format(id))
    conn.commit()
    conn.close()

def setImportant(id,important):
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    sql = 'UPDATE Messages SET important = {} WHERE message_id = {} '.format(important,id)
    cursor.execute(sql)
    conn.commit()

def getImportantMessageByConf(id):
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM Messages WHERE _id={} AND important = 1'.format(id))
    results = cursor.fetchall()
    conn.close()
    return results

def addTask(chatId, desc):
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    cursor.execute("INSERT INTO Tasks VALUES(Null, '{}', '{}')".format( chatId, desc))
    conn.commit()
    conn.close()

def deleteTask(taskId):
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    cursor.execute('DELETE FROM Tasks WHERE id={}'.format(taskId))
    conn.commit()
    conn.close()

def getAllTasks(chatId):
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM Tasks WHERE chat_id={}'.format(chatId))
    results = cursor.fetchall()
    conn.close()
    return results