DROP DATABASE IF EXISTS game;
CREATE DATABASE game;
USE game;
CREATE TABLE Game (
	GameID INTEGER PRIMARY KEY NOT NULL, 
	points INTEGER NOT NULL,
	fecha VARCHAR(50) NOT NULL,
	time VARCHAR(50),
	duration FLOAT,
	winner VARCHAR(50) NOT NULL
)ENGINE = InnoDB;

CREATE TABLE Player (
	username VARCHAR(50) PRIMARY KEY NOT NULL, 
	password VARCHAR(50) NOT NULL
)ENGINE = InnoDB;

CREATE TABLE Questions (
	questionID INTEGER PRIMARY KEY NOT NULL,
	question VARCHAR(50) NOT NULL
)ENGINE = InnoDB;

CREATE TABLE Answers (
	answerID INTEGER PRIMARY KEY NOT NULL,
	answer VARCHAR(50) NOT NULL
)ENGINE = InnoDB;

CREATE TABLE QuestionsRel (
	questID INTEGER,
	answID INTEGER NOT NULL,
	FOREIGN KEY (questID) REFERENCES Questions(questionID),
	FOREIGN KEY (answID) REFERENCES Answers(answerID)
)ENGINE = InnoDB;

CREATE TABLE Participation (
	Player VARCHAR(50) NOT NULL,
	Game INTEGER,
	FOREIGN KEY (Player) REFERENCES Player(username),
	FOREIGN KEY (Game) REFERENCES Game(GameID)
)ENGINE = InnoDB;

INSERT INTO Player VALUES('Juan',1234);
INSERT INTO Player VALUES('Maria',5678);
INSERT INTO Player VALUES('Pedro',9012);

INSERT INTO Game VALUES(1,23,'23/09/2025','9:15',2.38,'Maria');
INSERT INTO Game VALUES(2,10,'22/09/2025','14:30',5.59,'Pedro');
INSERT INTO Game VALUES(3,4,'21/09/2025','10:42',1.95,'Juan');

INSERT INTO Questions VALUES(1,'¿Cuál es la capital de España?');
INSERT INTO Questions VALUES(2,'¿Cuál es la capital de Australia?');
INSERT INTO Questions VALUES(3,'¿Cuál es la capital de China?');

INSERT INTO Answers VALUES(1,'Madrid');
INSERT INTO Answers VALUES(2,'Canberra');
INSERT INTO Answers VALUES(3,'Pequín');

INSERT INTO QuestionsRel VALUES (1,1);
INSERT INTO QuestionsRel VALUES (2,2);
INSERT INTO QuestionsRel VALUES (3,3);

INSERT INTO Participation VALUES ('Juan',2);
INSERT INTO Participation VALUES ('Maria',1);
INSERT INTO Participation VALUES ('Pedro',1);