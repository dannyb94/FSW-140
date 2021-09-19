CREATE SCHEMA BobRoss;
USE BobRoss;

#Create, alter, drop tables

ALTER TABLE `elements-by-episode`
RENAME TO RossFiles;
SELECT * FROM RossFiles;

CREATE TABLE Night AS (SELECT episode, title, night FROM RossFiles WHERE night = 1);
CREATE TABLE Bushes AS (SELECT episode, title, bushes FROM RossFiles WHERE bushes = 1);
CREATE TABLE Beach AS (SELECT episode, title, beach FROM RossFiles WHERE beach = 1);

SELECT * FROM Beach;
SELECT * FROM Bushes;
SELECT * FROM Night;

DROP TABLE Bushes;


#SET operations, Subqueries, Order of op queries

SELECT DISTINCT 'Beach' AS episode_type, episode, title FROM Beach WHERE title IN (
	SELECT title FROM Beach WHERE title LIKE '%Storm%')
UNION
SELECT 'Night', episode, title FROM Night
UNION
SELECT 'Bushes', episode, title FROM Bushes WHERE title IN (
	SELECT title FROM Bushes WHERE title LIKE '%Mountain%')
ORDER BY title DESC LIMIT 20;


#Associations (foreign keys)

ALTER TABLE RossFiles ADD UNIQUE(EPISODE(80));
#Line 34 executes fine, but 37 & 39 will not. I was trying to add a key length based on the error below.
#"Error Code: 1170. BLOB/TEXT column 'EPISODE' used in key specification without a key length"
ALTER TABLE RossFiles ADD PRIMARY KEY RossFiles(EPISODE);

ALTER TABLE RossFiles ADD FOREIGN KEY (episode) REFERENCES RossFiles(episode);
			# ADD CONSTRAINT BR_EpID      VARCHAR(30) 


#Joins & multiple table joins
#I can only see an output when I use Left or Right Join, but only from 1 of the tables. Using Join alone does execute correctly, but the table is empty.

SELECT Bushes.episode, Bushes.title, Night.episode, Night.title FROM Bushes JOIN Night
ON Bushes.episode = Night.episode AND Bushes.title = Night.title;

SELECT * FROM Night RIGHT JOIN Bushes ON Bushes.episode = Night.episode;
SELECT * FROM Bushes RIGHT JOIN Night ON Bushes.episode = Night.episode;