-- 1. Patient Demographics Analysis
-- What is the distribution of patients by gender and age group?
-- (gender)
SELECT gender
	,count(id) AS no_of_patients
FROM patient
GROUP BY gender;

-- (AGE)
SELECT max(birthdate)
	,min(birthdate)
FROM patient;

SELECT CASE 
		WHEN age BETWEEN 0
				AND 10
			THEN 'KIDS'
		WHEN age BETWEEN 10
				AND 18
			THEN 'TEENS'
		WHEN age BETWEEN 18
				AND 59
			THEN 'ADULTS'
		ELSE 'SENIOR CITIZEN'
		END AS Category
	,count(id) AS no_of_patients
FROM (
	SELECT id
		,FIRST
		,LAST
		,GENDER
		,birthdate
		,YEAR('2023-01-01') - YEAR(birthdate) - (DATE_FORMAT('2023-01-01', '%m%d') < DATE_FORMAT(birthdate, '%m%d')) AS age
	FROM patient
	) age_group
GROUP BY Category;

-- What is the racial composition of the patient population?
SELECT race
	,count(id) AS no_of_patient
FROM patient
GROUP BY race;

-- 2. Encounter Analysis
-- How many encounters were recorded for each patient?
SELECT p.id
	,p.first
	,p.last
	,YEAR('2023-01-01') - YEAR(birthdate) - (DATE_FORMAT('2023-01-01', '%m%d') < DATE_FORMAT(birthdate, '%m%d')) AS age
	,count(e.id) AS no_of_visit
FROM encounters e
INNER JOIN patient p ON p.id = e.Patient
GROUP BY e.Patient
ORDER BY no_of_visit DESC;

-- What is the average duration of encounters (difference between Start and Stop times)?
SELECT SEC_TO_TIME(AVG(TIME_TO_SEC(duration))) AS avg_duration
FROM (
	SELECT Id
		,Start_Date
		,Start_Time
		,End_Date
		,End_Time
		,TIME_FORMAT(TIMEDIFF(CONCAT (
					End_Date
					,' '
					,End_Time
					), CONCAT (
					Start_Date
					,' '
					,Start_Time
					)), '%H:%i:%s') AS duration
	FROM encounters
	) AS ss;

-- OR
SELECT SEC_TO_TIME(AVG(TIME_TO_SEC(TIMEDIFF(CONCAT (
						End_Date
						,' '
						,End_Time
						), CONCAT (
						Start_Date
						,' '
						,Start_Time
						))))) AS avg_duration
FROM encounters;

-- What percentages are there fo each encounter class?
SELECT DISTINCT encounterclass
FROM encounters;

WITH encounder_types
AS (
	SELECT encounterclass
		,count(*) AS no_of_encounter
	FROM encounters
	GROUP BY encounterclass
	)
	,total
AS (
	SELECT count(id) AS total_no
	FROM encounters
	)
SELECT e.encounterclass
	,round(((e.no_of_encounter / t.total_no) * 100), 2) AS percentage
FROM encounder_types e
	,total t
ORDER BY percentage DESC;
