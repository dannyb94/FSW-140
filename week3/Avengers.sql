-- 1.Show all of the information on the Avengers.
USE avengers;
SELECT * FROM avengers.avengers;

-- 2.Create a new table with information from another super hero group [can be imported from elsewhere or fictitious]. Make sure there is an appropriate header and must be at least 30 rows.
USE avengers;
CREATE TABLE x_men(
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    current VARCHAR(50) NOT NULL,
    gender VARCHAR(6) NOT NULL
) ENGINE=InnoDB;

INSERT INTO x_men VALUES
(1, 'Mystique', 'YES', 'FEMALE'),
(2, 'Wolverine', 'YES', 'MALE'),
(3, 'Rogue', 'YES', 'FEMALE'),
(4, 'Jean Grey', 'YES', 'FEMALE'),
(5, 'Professor X', 'YES', 'MALE'),
(6, 'Cyclops', 'YES', 'MALE'),
(7, 'Storm', 'YES', 'FEMALE'),
(8, 'Iceman', 'YES', 'MALE'),
(9, 'Pyro', 'YES', 'MALE'),
(10, 'Magik', 'YES', 'FEMALE'),
(11, 'Mimic', 'NO', 'MALE'),
(12, 'Psylocke', 'NO', 'FEMALE'),
(13, 'Nightcrawler', 'YES', 'MALE'),
(14, 'Shadowcat', 'YES', 'FEMALE'),
(15, 'Prestige', 'YES', 'FEMALE'),
(16, 'Marrow', 'YES', 'FEMALE'),
(17, 'Changeling', 'YES', 'MALE'),
(18, 'Havok', 'NO', 'MALE'),
(19, 'Sage', 'YES', 'FEMALE'),
(20, 'Omega Sentinel', 'NO', 'FEMALE'),
(21, 'Magneto', 'YES', 'MALE'),
(22, 'White Queen', 'YES', 'FEMALE'),
(23, 'Lifeguard', 'YES', 'FEMALE'),
(24, 'Stacy X', 'NO', 'FEMALE'),
(25, 'Armor', 'NO', 'FEMALE'),
(26, 'Sunspot', 'NO', 'MALE'),
(27, 'Magma', 'YES', 'FEMALE'),
(28, 'Hepzibah', 'YES', 'FEMALE'),
(29, 'Sunfire', 'NO', 'MALE'),
(30, 'Thunderbird', 'YES', 'MALE');

SELECT * FROM avengers.x_men;
USE avengers;
-- 3.Add a column to your new table (let us call it the new superheros) for those who are interested in joining the Avengers. Make this be randomly assigned.
ALTER TABLE x_men
ADD COLUMN new_superheroes VARCHAR(50);
SELECT id, name FROM x_men
ORDER BY name
LIMIT 11;
UPDATE x_men SET new_superheroes = (CASE
	WHEN RAND() > 0.5 THEN 'YES'
    ELSE 'NO'
END);

SELECT * FROM avengers.x_men;

-- 4.Add a column to your new table (the new superheros) for their favorite Avenger (have it randomly choose between  Anthony Edward "Tony" Stark,  Robert Bruce Banner, & Victor Shade).
ALTER TABLE x_men
ADD COLUMN fave_avenger VARCHAR(50);
UPDATE x_men SET fave_avenger = (CASE
	WHEN RAND() = 0.3  THEN 'Anthony Edward "Tony" Stark'
	WHEN RAND() > 0.6 THEN 'Robert Bruce Banner'
	ELSE 'Victor Shade'
END);

-- 5.Use a JOIN statement between the two tables for who is interested in joining the Avengers.

#x_men INNER JOIN avengers ON (x_men.name, x_men.current, x_men.gender) = avengers.name, avengers.current, avengers.gender

#SELECT x.name, x.current, x.gender, x.new_superheroes
#FROM x_men AS x, avengers AS ave
#INNER JOIN x_men ON ave.name = x.name
#WHERE x_men.id = avengers.id;

#SELECT x_men.name, x_men.current, x_men.gender, x_men.new_superheroes, avengers.name, avengers.current, avengers.gender
#FROM x_men AS xm, avengers AS ave
#FULL JOIN avengers
#ON x_men.name = avengers.name;

#SELECT x_men.name, x_men.current, x_men.gender, x_men.new_superheroes, avengers.name, avengers.current, avengers.gender FROM x_men AS xm
#CROSS JOIN avengers
#LEFT JOIN x_men ON x_men.name = avengers.name;

SELECT x_men.name, x_men.current, x_men.gender, x_men.new_superheroes, avengers.name AS ave FROM x_men
JOIN avengers ON avengers.name = x_men.fave_avenger
WHERE new_superheroes = 'YES';

-- 6.List all Avengers who have more than 1000 appearances in alphabetic order.
SELECT * FROM avengers.avengers WHERE appearances >= 1000 ORDER BY name;

-- 7.What Avengers do not have more than 1000 appearances?
SELECT * FROM avengers.avengers WHERE appearances <= 999 ORDER BY appearances;

-- 8.Not more than 500?
SELECT * FROM avengers.avengers WHERE appearances <= 500 ORDER BY appearances;

-- 9.Not more than 50 and female?
SELECT * FROM avengers.avengers WHERE appearances <= 50 AND gender = 'FEMALE';

-- 10.More than 150, male, and are full members?
SELECT * FROM avengers.avengers WHERE appearances >= 150 AND gender = 'MALE' AND honorary = 'FULL';

-- Wk4 Slack
SELECT * FROM avengers WHERE appearances IN (
	SELECT appearances FROM avengers 
	WHERE gender = 'FEMALE');


-- EXTRA CREDIT --
-- Write a function that can add a new superhero to the Avengers if they are interested in becoming an Avenger and if their favorite Avenger is Victor Shade.
-- DELIMITER $$
-- CREATE FUNCTION signUpNow() RETURNS INT DETERMINISTIC
-- BEGIN
-- 	DECLARE TOTAL INT;
--     SELECT DISTINCT COUNT(*) FROM avengers INTO total;
--     RETURN total;
-- END $$
-- DELIMITER ;