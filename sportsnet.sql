DROP DATABASE IF EXISTS sportsnet;

CREATE DATABASE sportsnet;

USE sportsnet;

CREATE TABLE countries (
	ID INT PRIMARY KEY AUTO_INCREMENT
,	NAME VARCHAR(100) NOT NULL
);

CREATE TABLE cities (
	ID INT PRIMARY KEY AUTO_INCREMENT
,	NAME VARCHAR(100) NOT NULL
,	COUNTRY_ID INT
);

CREATE TABLE sports (
	ID INT PRIMARY KEY AUTO_INCREMENT
,	NAME VARCHAR(100) NOT NULL
);

CREATE TABLE users (
	ID INT PRIMARY KEY AUTO_INCREMENT
,	NAME VARCHAR(100) NOT NULL
,	SURNAME VARCHAR(100) NOT NULL
,	EMAIL VARCHAR(100) UNIQUE NOT NULL
,	PASSWORD VARCHAR(100) NOT NULL
,	CITY_ID INT
);

CREATE TABLE `events` (
	ID INT PRIMARY KEY AUTO_INCREMENT
,	`DATE` DATE NOT NULL
,	VENUE VARCHAR(100) NOT NULL
,	DESCRIPTION TEXT
,	DURATION time
,	CITY_ID INT
);

CREATE TABLE posts (
	ID INT PRIMARY KEY AUTO_INCREMENT
,	DESCRIPTION TEXT
,	SPORT_ID INT
,	USER_ID INT
);

CREATE TABLE teams (
	ID INT PRIMARY KEY AUTO_INCREMENT
,	NAME VARCHAR(100)
,	SPORT_ID INT
);

CREATE TABLE user_sports (
	ID INT PRIMARY KEY AUTO_INCREMENT
,	SPORT_ID INT
,	USER_ID INT
);
CREATE TABLE user_teams (
	ID INT PRIMARY KEY AUTO_INCREMENT
,	PLAYER BOOLEAN DEFAULT FALSE
,	CAPTAIN BOOLEAN DEFAULT FALSE
,	USER_ID INT
,	TEAM_ID INT
)
COMMENT "Users can follow a team, be a player of the team or be the captain of the team(admin)"
;

CREATE TABLE team_events(
	ID INT PRIMARY KEY AUTO_INCREMENT
,	EVENT_ID INT
,	TEAM_ID INT
);

CREATE TABLE user_events (
	ID INT PRIMARY KEY AUTO_INCREMENT
,	EVENT_ID INT
,	USER_ID INT
);

CREATE TABLE city_sports(
	ID INT PRIMARY KEY AUTO_INCREMENT
,	SPORT_ID INT
,	CITY_ID INT
);

ALTER TABLE cities
	ADD CONSTRAINT fk_cities_country
    FOREIGN KEY (COUNTRY_ID) REFERENCES countries(ID);
    
ALTER TABLE users
	ADD CONSTRAINT fk_users_city
    FOREIGN KEY (CITY_ID) REFERENCES cities(ID);   

ALTER TABLE `events`
	ADD CONSTRAINT fk_events_city
    FOREIGN KEY (CITY_ID) REFERENCES cities(ID);  

ALTER TABLE posts
	ADD CONSTRAINT fk_posts_sport
    FOREIGN KEY (SPORT_ID) REFERENCES sports(ID),
	ADD CONSTRAINT fk_posts_user
    FOREIGN KEY (USER_ID) REFERENCES users(ID); 

ALTER TABLE teams
	ADD CONSTRAINT fk_teams_sport
    FOREIGN KEY (SPORT_ID) REFERENCES sports(ID);

ALTER TABLE user_sports
	ADD CONSTRAINT fk_user_sports_sport
    FOREIGN KEY (SPORT_ID) REFERENCES sports(ID),
	ADD CONSTRAINT fk_user_sports_user
    FOREIGN KEY (USER_ID) REFERENCES users(ID);
    
ALTER TABLE user_teams
	ADD CONSTRAINT fk_user_teams_team
    FOREIGN KEY (TEAM_ID) REFERENCES teams(ID),
	ADD CONSTRAINT fk_user_teams_user
    FOREIGN KEY (USER_ID) REFERENCES users(ID);
    
    
ALTER TABLE team_events
	ADD CONSTRAINT fk_team_events_team
    FOREIGN KEY (TEAM_ID) REFERENCES teams(ID),
	ADD CONSTRAINT fk_team_events_event
    FOREIGN KEY (EVENT_ID) REFERENCES `events`(ID);
    
ALTER TABLE user_events
	ADD CONSTRAINT fk_user_events_event
    FOREIGN KEY (EVENT_ID) REFERENCES `events`(ID),
	ADD CONSTRAINT fk_user_events_user
    FOREIGN KEY (USER_ID) REFERENCES users(ID);
    
ALTER TABLE city_sports
	ADD CONSTRAINT fk_city_sports_sport
    FOREIGN KEY (SPORT_ID) REFERENCES sports(ID),
	ADD CONSTRAINT fk_city_sports_city
    FOREIGN KEY (CITY_ID) REFERENCES cities(ID);    
