CREATE SCHEMA WhiteChristmas;
USE WhiteChristmas;
SELECT * FROM whitechristmasdata;

-- Show the average daily temperature for August 10th, 1964.
SELECT yr, dy, AVG(m4) FROM whitechristmasdata WHERE yr = 1964 AND dy = 10;

-- Show the twelve temperatures.
SELECT yr, dy, m12 FROM whitechristmasdata WHERE yr BETWEEN 1812 AND 1812+11 AND dy = 25;

-- For each age 1-12 show which years were a White Christmas.
-- Show 'White Christmas' or 'No snow' for each age.
SELECT yr, dy, AVG(m12) 
CASE 
	WHEN MIN(m12) < 0 THEN 'White Christmas' #WHEN (m12 >= 1) THEN 'No Snow'
    ELSE 'No Snow' 
END AS xmasData
FROM whitechristmasdata WHERE yr BETWEEN 1812 AND 1812+11 AND dy BETWEEN 21 AND 25 ORDER BY yr;

-- List all the years and the wcc for children born in each year of the data set.
-- Only show years where the wcc was at least 7.
SELECT yr, dy, m12 FROM whitechristmasdata WHERE yr BETWEEN 1815 AND 1815+9 AND dy = 25; #dy BETWEEN 24 AND 25

-- Display the average temperatures for August by decade.
SELECT ROUND(yr-2) decade, ROUND(AVG(m8)) temp FROM whitechristmasdata GROUP BY yr; 
SELECT ROUND(yr-2) decade, ROUND(AVG(m8)) temp FROM whitechristmasdata WHERE yr = yr+10;
SELECT ROUND(yr-2) decade, ROUND(AVG(m8)) temp FROM whitechristmasdata WHERE yr BETWEEN 1770 AND 1770+10;








SELECT ROUND(yr,-1) decade, ROUND(AVG(NULLIF(m8,-999))/10,1)
  FROM hadcet
GROUP BY ROUND(yr,-1)

SELECT AVG(month) FROM       
(SELECT yr, AVG(m8) AS "month" FROM UKtemps) ByMonth
WHERE yr BETWEEN yr AND yr+9;  