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

def addNewConference(conferenceName):
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    cursor.execute("INSERT INTO Conferences VALUES(Null, '{}')".format(conferenceName))
    conn.commit()
    conn.close()

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
    cursor.execute("INSERT INTO Messages VALUES('{}', '{}', '{}', '{}')".format(id, userName, message, timeCreate))
    conn.commit()
    conn.close()

def getMessagesByConferenceId(id):
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM Messages WHERE _id={}'.format(id))
    results = cursor.fetchall()
    conn.close()
    return results

print(getMessagesByConferenceId(432))





