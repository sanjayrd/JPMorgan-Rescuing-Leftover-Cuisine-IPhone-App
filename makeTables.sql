CREATE TABLE IF NOT EXISTS Volunteers
(	id			INT primary key AUTO_INCREMENT,
	firstName	VARCHAR(255) not null,
	lastName	VARCHAR(255) not null,
	email		VARCHAR(255) unique not null,
	password	VARCHAR(255) not null,
	phone		VARCHAR(255) unique not null,
	lat DECIMAL(10, 8),
	lng DECIMAL(11, 8)
);

CREATE TABLE IF NOT EXISTS Restaurants
(
	id			INT primary key AUTO_INCREMENT,
	name 		VARCHAR(255) not null,
	lat DECIMAL(10, 8),
	lng DECIMAL(11, 8),
	username	VARCHAR(255) unique not null,
	password	VARCHAR(255) not null
);

CREATE TABLE IF NOT EXISTS Shelters
(
	id			INT primary key AUTO_INCREMENT,
	name 		VARCHAR(255) not null,
	lat DECIMAL(10, 8),
	lng DECIMAL(11, 8),
	username	VARCHAR(255) unique not null,
	password	VARCHAR(255) not null
);

CREATE TABLE IF NOT EXISTS Events
(
	id				INT primary key AUTO_INCREMENT,
	time			DATETIME NOT NULL,
	restaurantId	INT NOT NULL,
	shelterId		INT NOT NULL,
	FOREIGN KEY (restaurantId) REFERENCES Restaurants(id),
	FOREIGN KEY (shelterId) REFERENCES Shelters(id)
);

CREATE TABLE IF NOT EXISTS VolunteerToEvent
(
	eventId		INT,
	volunteerId	INT,
	FOREIGN KEY (eventId) REFERENCES Events(id),
	FOREIGN KEY (volunteerId) REFERENCES Volunteers(id),
	PRIMARY KEY(eventId, volunteerId)
);

INSERT INTO Volunteers 
	(firstName, lastName, email, password, phone, lat, lng)
VALUES 
	("John", "Smith", "john@gmail.com", "password1", "8003435555", "40.775", "-73.93"),
	("Jane", "Doe", "jane@gmail.com", "password2", "8009932993", "40.789", "-73.923"),
	("Bob", "Dillon", "bobdillon@gmail.com", "password3", "8025932993", "40.773", "-73.943")
;

INSERT INTO Restaurants
	(name, lat, lng, username, password)
VALUES
	("Starbucks", "40.76", "-73.95", "starbucks1", "starbucks"),
	("Starbucks", "40.73", "-73.98", "starbucks2", "starbucks")
;

INSERT INTO Shelters
	(name, lat, lng, username, password)
VALUES
	("Shelter", "40.68", "-73.96", "shelter1", "shelter"),
	("Shelter", "40.69", "-73.94", "shelter2", "shelter")
;

INSERT INTO Events
	(time, restaurantId, shelterId)
VALUES
	("2014-10-27 23:59:59", "1", "1"),
	("2014-10-25 23:59:59", "1", "1"),
	("2014-10-28 23:59:59", "2", "1"),
	("2014-10-27 23:59:59", "1", "2")
;

INSERT INTO VolunteerToEvent
	(eventId, volunteerId)
VALUES
	("1", "1"),
	("2", "2"),
	("3", "1"),
	("4", "2")
;




