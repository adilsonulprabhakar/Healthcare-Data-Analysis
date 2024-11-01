-- 3. Procedure Analysis
-- What are the most common procedures performed based on the procedure codes?
SELECT code
	,Description
	,count(*) total_no
FROM procedures
GROUP BY code
ORDER BY total_no DESC;

-- How does the average base cost of procedures vary by patient gender?
SELECT p.gender
	,round(avg(pr.base_cost), 2) AS avg_base_cost
FROM procedures pr
INNER JOIN patient p ON p.id = pr.patient
GROUP BY p.gender;

-- What is the relationship between encounter class (e.g., ambulatory, inpatient) and the type of procedures performed?
SELECT e.encounterclass
	,p.code
	,p.description
	,count(*) AS frequency
FROM encounters e
INNER JOIN procedures p ON e.id = p.encounter
GROUP BY e.EncounterClass
	,p.Code
ORDER BY e.EncounterClass
	,frequency DESC;

-- 4. Cost Analysis
-- What is the total cost incurred for procedures by each patient?
SELECT e.patient
	,pa.first
	,pa.last
	,count(p.code) AS no_of_procedure
	,sum(p.base_cost) AS total_cost
FROM encounters e
INNER JOIN procedures p ON e.id = p.Encounter
INNER JOIN patient pa ON e.Patient = pa.id
GROUP BY e.patient
ORDER BY total_cost DESC;

-- What is the average payer coverage for different types of encounters?
SELECT EncounterClass
	,round(AVG(Payer_Coverage), 2) AS Average_Payer_Coverage
FROM encounters
GROUP BY EncounterClass
ORDER BY Average_Payer_Coverage DESC;

-- What is the average coverage provided by each payer for different types of encounters, 
-- and which encounter class tends to receive the highest average coverage from each payer?
SELECT p.NAME
	,e.encounterclass
	,avg(e.payer_coverage) AS avg_coverage
FROM encounters e
INNER JOIN payers p ON e.Payer = p.id
GROUP BY p.NAME
	,e.EncounterClass
ORDER BY p.NAME
	,avg_coverage DESC;

-- How many procedures are covered by insurance?
SELECT *
FROM payers;

SELECT COUNT(*) AS Total_Insured_Procedures
FROM procedures p
INNER JOIN encounters e ON p.Encounter = e.Id
WHERE e.Payer NOT IN ('b1c428d6-4f07-31e0-90f0-68ffa6ff8c76');-- Find the No insurance ID from payer table
