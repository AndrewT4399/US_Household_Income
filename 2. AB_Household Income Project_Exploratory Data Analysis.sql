# US Household Income Exploratory Data Analysis

SELECT *
FROM us_household_income
;

SELECT *
FROM us_household_income_statistics
;

-- Top 10 largest states by land mass
SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_household_income
GROUP BY State_Name
ORDER BY 2 DESC
LIMIT 10
;

-- Top 10 largest states by water
SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_household_income
GROUP BY State_Name
ORDER BY 3 DESC
LIMIT 10
;


SELECT *
FROM us_household_income u
JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
;



SELECT u.State_Name, County, Type, `Primary`, Mean, Median
FROM us_household_income u
JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
;

-- 5 States with the lowest average income 
SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 2
LIMIT 10
;

-- 10 States with the lowest median income 
SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 3
LIMIT 10
;

-- Top 10 States with the highest average income
SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 2 DESC
LIMIT 10
;

-- Top 10 States with the highest median income
SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 3 DESC
LIMIT 10
;

SELECT Type, COUNT(Type),ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY Type
ORDER BY 3 DESC
;

SELECT Type, COUNT(Type),ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY Type
HAVING COUNT(Type) > 100
ORDER BY 4 DESC
;

SELECT *
FROM us_household_income
WHERE Type = 'Community'
;

SELECT u.State_Name, City, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name, City
ORDER BY ROUND(AVG(Mean),1) DESC
;
