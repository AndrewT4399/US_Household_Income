SELECT * 
FROM us_project.us_household_income;

SELECT * 
FROM us_project.us_household_income_statistics;
-- id column is has random characters. Let's rename it to just 'id'
ALTER TABLE us_project.us_household_income_statistics
RENAME COLUMN `ï»¿id` TO `id`
;

## Let's check the difference between the number of rows the two tables had imported
SELECT COUNT(id)
FROM us_project.us_household_income;
-- This one has 32292

SELECT COUNT(id)
FROM us_project.us_household_income_statistics;
-- This one has 32526

## Checking and removing duplicate rows on us_household_income table
SELECT id, COUNT(id)
FROM us_household_income
GROUP BY id
HAVING COUNT(id) > 1
;

SELECT *
FROM (
	SELECT row_id, 
	id,
	ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
	FROM us_household_income
	) duplicates
    WHERE row_num > 1
;

DELETE FROM us_household_income
WHERE row_id IN (
	SELECT row_id
	FROM (
		SELECT row_id, 
		id,
		ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
		FROM us_household_income
		) duplicates
		WHERE row_num > 1)
;

## Checking and removing duplicate rows on us_household_income_statistics table
SELECT id, COUNT(id)
FROM us_household_income_statistics
GROUP BY id
HAVING COUNT(id) > 1
;
-- None found!

## Checking the state_name column since we saw some inconsistency there on our initial exploration
SELECT DISTINCT State_Name
FROM us_household_income
ORDER BY 1
;

UPDATE us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia'
;

UPDATE us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama'
;

SELECT DISTINCT *
FROM us_household_income
WHERE County = 'Autauga County'
ORDER BY 1
;

UPDATE us_household_income
SET place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont'
;


SELECT Type, COUNT(Type)
FROM us_household_income
GROUP BY Type
;

UPDATE us_household_income
SET Type = 'Borough'
WHERE Type = 'Boroughs'
;

SELECT DISTINCT ALand, AWater
FROM us_household_income
WHERE (AWater = 0 OR AWater = '' OR AWater IS NULL)
AND (ALand = 0 OR ALand = '' OR ALand IS NULL)
;























