from flask import Flask, session, request, jsonify
from flask.ext import restful
from flask.ext.restful import reqparse, abort, Api, Resource
from flaskext.mysql import MySQL
from flask.ext.mail import Mail
from flask.ext.mail import Message
import json

mysql = MySQL()

app = Flask(__name__)


app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = 'cfg2014!'
app.config['MYSQL_DATABASE_DB'] = 'mainDb'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)


@app.route('/')
def index():
	return 'hi'

@app.route('/request/validateLogin', methods=['POST'])
def login():
	email = request.form['email']
	password = request.form['password']
	db = mysql.connect()
	cursor = db.cursor()
	cursor.execute("SELECT * FROM Volunteers WHERE email=%s AND password=%s", (email, password))
	databaseResponse = cursor.fetchone()
	if databaseResponse is None:
		return json.dumps({"successOrFailure": "failure"})
	else:
		return json.dumps({"successOrFailure": "success"})

@app.route('/request/addNewUser', methods=['POST'])
def addNewUser():
	email = request.form['email']
	password = request.form['password']
	firstName = request.form['firstName']
	lastName = request.form['lastName']
	phoneNumber = request.form['phone']
	lat = request.args.get('lat')
	lng = request.args.get('lat')
	db = mysql.connect()
	cursor = db.cursor()
	if lat is None:
		cursor.execute("INSERT INTO Volunteers(firstName, lastName, email, password, phone, lat, lng) VALUES (%s,%s,%s,%s,%s, 'NULL', 'NULL')", (firstName, lastName, email, password, phoneNumber))
		db.commit()
		return json.dumps({"successOrFailure": "success"})
	else:
		cursor.execute("INSERT INTO Volunteers (firstName, lastName, email, password, phone, lat, lng) VALUES (%s,%s,%s,%s,%s,%s,%s)", (firstName, lastName, email, password, phoneNumber, lat, lng))
		db.commit()
		return json.dumps({"successOrFailure": "success"})
	return json.dumps({"successOrFailure": "failure"})

@app.route('/request/getEvents', methods=['GET'])
def getEvents():
	db = mysql.connect()
	cursor = db.cursor()
	cursor.execute("SELECT * FROM Events")
	dataTuple = cursor.fetchall()
	data = [list(elem) for elem in dataTuple]
	dataList = []
	for row in data:
		restaurantId = row[2]
		shelterId = row[3]
		cursor.execute("SELECT * FROM Restaurants WHERE id=%s", (restaurantId,))
		restaurantData = cursor.fetchone()
		restaurantName = restaurantData[1]
		restaurantLat = restaurantData[2]
		restaurantLng = restaurantData[3]
		cursor.execute("SELECT * FROM Shelters WHERE id=%s", (shelterId,))
		shelterData = cursor.fetchone()
		shelterName = shelterData[1]
		shelterLat = shelterData[2]
		shelterLng = shelterData[3]		
		tmpData = {'uniqueId': str(row[0]), 'time': str(row[1])}
		tmpData['restaurantName'] = str(restaurantName)
		tmpData['restaurantLat'] = str(restaurantLat)
		tmpData['restaurantLng'] =  str(restaurantLng)
		tmpData['shelterName'] = str(shelterName)
		tmpData['shelterLat'] = str(shelterLat)
		tmpData['shelterLng'] = str(shelterLng)
		dataList.append(tmpData)
	return json.dumps(dataList)

@app.route('/request/signUpForEvent', methods=['POST'])
def signUpForEvent():
	email = request.form['email']
	eventId = request.form['eventId']
	db = mysql.connect()
	cursor = db.cursor()
	cursor.execute("SELECT * FROM Volunteers WHERE email=%s", (email,))
	userId = cursor.fetchone()[0]
	cursor.execute("INSERT INTO VolunteerToEvent (eventId, volunteerId) VALUES (%s, %s)", (eventId, userId))
	db.commit()
	return json.dumps({"successOrFailure": "success"})

@app.route('/request/getSignedUpEvents', methods=['POST'])
def getSignedUpEvents():
	email = request.form['email']
	db = mysql.connect()
	cursor = db.cursor()
	cursor.execute("SELECT * FROM Volunteers WHERE email=%s", (email,))
	userId = cursor.fetchone()[0]
	cursor.execute("SELECT * FROM VolunteerToEvent WHERE volunteerId=%s", (userId,))
	dataTuple= cursor.fetchall()
	data = [list(elem) for elem in dataTuple]
	dataList = []
	for row in data:
		eventId = row[0]
		cursor.execute("SELECT * FROM Events WHERE id=%s",(eventId,))
		eventData = cursor.fetchone()
		restaurantId = eventData[2]
		shelterId = eventData[3]
		cursor.execute("SELECT * FROM Restaurants WHERE id=%s", (restaurantId,))
		restaurantData = cursor.fetchone()
		restaurantName = restaurantData[1]
		restaurantLat = restaurantData[2]
		restaurantLng = restaurantData[3]
		cursor.execute("SELECT * FROM Shelters WHERE id=%s", (shelterId,))
		shelterData = cursor.fetchone()
		shelterName = shelterData[1]
		shelterLat = shelterData[2]
		shelterLng = shelterData[3]		
		tmpData = {'uniqueId': str(eventData[0]), 'time': str(eventData[1])}
		tmpData['restaurantName'] = str(restaurantName)
		tmpData['restaurantLat'] = str(restaurantLat)
		tmpData['restaurantLng'] =  str(restaurantLng)
		tmpData['shelterName'] = str(shelterName)
		tmpData['shelterLat'] = str(shelterLat)
		tmpData['shelterLng'] = str(shelterLng)
		dataList.append(tmpData)
	return json.dumps(dataList)

@app.route('/request/getDistanceBetweenTwoPoints')
def getDistanceBetweenTwoPoints():
	firstLat = request.form[firstLat]
	firstLng = request.form[firstLng]
	secondLat = request.form[secondLat]
	secondLng = request.form[secondLng]

if __name__ == '__main__':
    app.run(host='0.0.0.0')