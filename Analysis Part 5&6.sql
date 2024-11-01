-- 5. Time Series Analysis
-- How do the number of encounters and procedures performed vary over time (monthly, quarterly)?
WITH quarter_encounter
AS (
	SELECT quarter(start_date) AS Quarters
		,count(*) AS total_encounters
	FROM encounters
	GROUP BY quarters
	)
	,quarter_procedure
AS (
	SELECT quarter(start_date) AS Quarters
		,count(*) AS total_procedure
	FROM procedures
	GROUP BY quarters
	)
SELECT e.quarters
	,e.total_encounters
	,p.total_procedure
FROM quarter_encounter e
INNER JOIN quarter_procedure p ON e.quarters = p.quarters
ORDER BY quarters;

-- (Monthly)
WITH month_encounters
AS (
	SELECT month(start_date) AS S_no
		,monthname(start_date) AS months
		,count(*) AS total_encounters
	FROM encounters
	GROUP BY months
	ORDER BY month(Start_Date)
	)
	,month_procedures
AS (
	SELECT month(start_date) AS S_no
		,monthname(start_date) AS months
		,count(*) AS total_procedures
	FROM procedures
	GROUP BY months
	)
SELECT e.S_no
	,e.months
	,e.total_encounters
	,p.total_procedures
FROM month_encounters e
INNER JOIN month_procedures p ON e.months = p.months;

-- Are there specific months or seasons with a higher volume of patient encounters or procedures?
WITH month_encounters
AS (
	SELECT month(start_date) AS S_no
		,monthname(start_date) AS months
		,count(*) AS total_encounters
	FROM encounters
	GROUP BY months
	ORDER BY month(Start_Date)
	)
	,month_procedures
AS (
	SELECT month(start_date) AS S_no
		,monthname(start_date) AS months
		,count(*) AS total_procedures
	FROM procedures
	GROUP BY months
	)
SELECT e.S_no
	,e.months
	,e.total_encounters
	,p.total_procedures
FROM month_encounters e
INNER JOIN month_procedures p ON e.months = p.months
ORDER BY total_encounters DESC
	,total_procedures DESC;

-- What is the trend in total claim costs over the years?
SELECT year(start_date) AS years
	,sum(total_claim_cost) AS total_claim_cost
FROM encounters
GROUP BY years
ORDER BY years;

-- 6. Performance Metrics
-- What is the average cost per encounter, and how does it vary by patient demographic factors?
-- Calculate average cost per encounter by gender, race, and ethnicity
SELECT p.GENDER
	,p.RACE
	,p.ETHNICITY
	,AVG(e.Total_Claim_Cost) AS Avg_Cost_Per_Encounter
FROM encounters e
INNER JOIN patient p ON e.Patient = p.Id
GROUP BY p.GENDER
	,p.RACE
	,p.ETHNICITY
ORDER BY p.GENDER
	,p.RACE
	,p.ETHNICITY;

SELECT ReasonCode
	,ReasonDescription
	,AVG(Base_Cost) AS Avg_Procedure_Cost
FROM procedures
GROUP BY ReasonCode
	,ReasonDescription
ORDER BY Avg_Procedure_Cost DESC;

-- How many patients have been admitted or readmitted over time?
SELECT DATE_FORMAT(e.Start_Date, '%Y-%m') AS Admission_Month
	,-- Change format for quarterly if needed
	COUNT(DISTINCT e.Patient) AS Total_Patients_Admitted
	,COUNT(DISTINCT CASE 
			WHEN Readmissions.Patient IS NOT NULL
				THEN Readmissions.Patient
			END) AS Total_Readmitted
FROM encounters e
LEFT JOIN (
	SELECT Patient
		,COUNT(*) AS Admission_Count
	FROM encounters
	GROUP BY Patient
	HAVING Admission_Count > 1
	) AS Readmissions ON e.Patient = Readmissions.Patient
GROUP BY Admission_Month
ORDER BY Admission_Month;
