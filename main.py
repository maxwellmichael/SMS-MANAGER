# qpy:webapp: SMS Manager


import androidhelper
import sqlite3
import os
import time
import sys
from random import randint
from multiprocessing import Process
from threading import Thread, ThreadError
from bottle import route, run, template, request, redirect, error, response, ServerAdapter
import bottle


# SQLITE Connector
conn = sqlite3.connect('example.db')
curr = conn.cursor()
# The Android Object
droid = androidhelper.Android()

curr.execute(
    '''CREATE TABLE IF NOT EXISTS contacts (contact_id INTEGER PRIMARY KEY AUTOINCREMENT, number text, name text)''')

port = randint(1000, 9999)

cwd = os.getcwd()
def_path = cwd+'/projects3/SMS_MANAGER/'
os.chdir(def_path)


def getAllContacts():
    curr.execute("SELECT * FROM contacts")
    fetched = curr.fetchall()
    return fetched


def getContacts(value):
    value = '%'+value+'%'
    curr.execute(
        "SELECT * FROM contacts WHERE number LIKE ? OR name LIKE ?", (value, value,))
    fetched = curr.fetchall()
    return fetched


def deleteContact(id):
    try:
        curr.execute("DELETE FROM contacts WHERE contact_id=?", (id, ))
        conn.commit()
        return(True)
    except Exception as e:
        print(e)
        return(False)


def updateContact(id, number, name):
    print(f"Updating id: {id} with name {name} and {number}")
    try:
        curr.execute(
            "UPDATE contacts SET number = ? ,name = ? WHERE contact_id = ?", (number, name, id, ))
        conn.commit()
        return(True)
    except Exception as e:
        print(e)
        return(False)


def sendSMS(number, message):
    number = f'+91 {number}'
    print(f"Sending Message: {message} to Number: {number}")
    try:
        droid.smsSend(number, message)
    except Exception as e:
        print(e)
    print('SMS sent to '+number)


def exitApp():
    time.sleep(1)
    sys.exit()
    sys.stderr.close()


def webViewShow():
    time.sleep(0.1)
    droid.webViewShow('http://localhost:'+str(port)+'/')


@route('/')
def index():
    contacts = getAllContacts()
    return template('index', contacts=contacts, ADD_CONTACT=False, NEW_MESSAGE=False)


@error(404)
def error404(error):
    return 'Nothing here, sorry'


@route('/QuitApp')
def Quit():
    response.status = 200
    tr = Thread(target=exitApp)
    tr.start()
    return "Quitting"


@route('/AddContact')
def addNewContact():
    contacts = getAllContacts()
    return template('index', contacts=contacts, ADD_CONTACT=True, NEW_MESSAGE=False)


@route('/NewMessage')
def NewMessage():
    contacts = getAllContacts()
    return template('index', contacts=contacts, ADD_CONTACT=False, NEW_MESSAGE=True)


@route('/SMSContacts', method='POST')
def SmsContacts():
    contacts = getAllContacts()
    message = request.forms.get('message')
    print(f'Received message: {message}')
    for contact in contacts:
        sendSMS(contact[1], message)
    return redirect('/')


@route('/RemoveContact/<id>', method='DELETE')
def RemoveContact(id):
    print("Removing Contact with Id:"+id)
    if deleteContact(id):
        response.status = 200
        return "successfully Deleted"
    else:
        response.status = 500
        return "Couldnt Delete Number"


@route('/UpdateContact/<id>', method='PATCH')
def UpdateContact(id):
    number = request.query['number']
    name = request.query['name']
    print("Updating Contact with name:"+name)

    if updateContact(id, number, name):
        response.status = 200
        return "successfully Deleted"
    else:
        response.status = 500
        return "Couldnt Delete Number"


@route('/SearchContacts', method='POST')
def searchContacts():
    value = request.forms.get('search-input')
    print("Retreving Results for:"+value)
    contacts = getContacts(value)
    print(contacts)
    return template('index', contacts=contacts, ADD_CONTACT=False, NEW_MESSAGE=False)


@route('/SaveContact', method='POST')
def saveContact():
    name = request.forms.get('name')
    number = request.forms.get('number')
    print(f"Contact Number: {number}")
    curr.execute(
        "INSERT INTO contacts(number, name) VALUES (?,?)", (number, name))
    conn.commit()
    #droid.dialogCreateAlert("Contact Successfully Created")
    return redirect('/')


mp = Process(target=webViewShow)
mp.start()


try:
    run(host='localhost', port=str(port),
        debug=True)
except:
    mp.terminate()
