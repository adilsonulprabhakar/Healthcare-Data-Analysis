
## Project Title: **Healthcare Data Analysis**

### Project Objective:
Analyze patient encounters, procedures, and associated costs in a healthcare setting to derive insights about patient demographics, procedure efficiency, and financial performance.

### Dataset Overview

Dataset : https://app.mavenanalytics.io/datasets     -- Hospital Patient Records

### 1. Table: `patient`
| Column Name   | Data Type     |
|---------------|----------------|
| Id            | varchar(36)    |
| BIRTHDATE     | date           |
| DEATHDATE     | date           |
| PREFIX        | varchar(10)    |
| FIRST         | varchar(50)    |
| LAST          | varchar(50)    |
| SUFFIX        | varchar(10)    |
| MAIDEN        | varchar(50)    |
| MARITAL       | varchar(20)    |
| RACE          | varchar(20)    |
| ETHNICITY     | varchar(20)    |
| GENDER        | char(1)        |
| BIRTHPLACE    | varchar(100)   |
| ADDRESS       | varchar(100)   |
| CITY          | varchar(50)    |
| STATE         | varchar(50)    |
| COUNTY        | varchar(50)    |
| ZIP           | varchar(10)    |
| LAT           | decimal(10,8)  |
| LON           | decimal(11,8)  |

### 2. Table: `organization`
| Column Name   | Data Type     |
|---------------|----------------|
| Id            | varchar(36)    |
| NAME          | varchar(100)    |
| ADDRESS       | varchar(100)    |
| CITY          | varchar(50)    |
| STATE         | varchar(50)    |
| ZIP           | varchar(10)    |
| LAT           | decimal(10,8)  |
| LON           | decimal(11,8)  |

### 3. Table: `payers`
| Column Name   | Data Type     |
|---------------|----------------|
| Id            | varchar(36)    |
| NAME          | varchar(100)    |
| ADDRESS       | varchar(100)    |
| CITY          | varchar(50)    |
| STATE_HEADQUARTERED | varchar(50) |
| ZIP           | varchar(10)    |
| PHONE         | varchar(15)    |

### 4. Table: `encounters`
| Column Name           | Data Type     |
|-----------------------|----------------|
| Id                    | varchar(36)    |
| Start_Date            | date           |
| Start_Time            | time           |
| End_Date              | date           |
| End_Time              | time           |
| Patient               | varchar(36)    |
| Organization          | varchar(36)    |
| Payer                 | varchar(36)    |
| EncounterClass        | varchar(50)    |
| Code                  | varchar(50)    |
| Description           | text           |
| Base_Encounter_Cost   | decimal(10,2)  |
| Total_Claim_Cost      | decimal(10,2)  |
| Payer_Coverage        | decimal(10,2)  |
| ReasonCode            | varchar(50)    |
| ReasonDescription      | text           |

### 5. Table: `procedures`
| Column Name           | Data Type     |
|-----------------------|----------------|
| Start_Date            | date           |
| Start_Time            | time           |
| Stop_Date             | date           |
| Stop_Time             | time           |
| Patient               | varchar(36)    |
| Encounter             | varchar(36)    |
| Code                  | varchar(50)    |
| Description           | varchar(150)   |
| Base_Cost             | decimal(10,2)  |
| ReasonCode            | varchar(50)    |
| ReasonDescription      | varchar(150)   |

---

### Questions to Explore:

#### 1. Patient Demographics Analysis
- What is the distribution of patients by gender and age group?
- How does the average age of patients vary across different organizations?
- What is the racial composition of the patient population?

#### 2. Encounter Analysis
- How many encounters were recorded for each patient?
- What is the average duration of encounters (difference between Start and Stop times)?
- What percentage of encounters were classified as ambulatory versus inpatient?

#### 3. Procedure Analysis
- What are the most common procedures performed based on the procedure codes?
- How does the average base cost of procedures vary by patient gender?
- What is the relationship between encounter class (e.g., ambulatory, inpatient) and the type of procedures performed?

#### 4. Cost Analysis
- What is the total cost incurred for procedures by each patient?
- Which organization has the highest total claim costs associated with patient encounters?
- What is the average payer coverage for different types of encounters?
- How many procedures are covered by insurance?

#### 5. Time Series Analysis
- How do the number of encounters and procedures performed vary over time (monthly, quarterly)?
- Are there specific months or seasons with a higher volume of patient encounters or procedures?
- What is the trend in total claim costs over the years?

#### 6. Performance Metrics
- What is the average cost per encounter, and how does it vary by patient demographic factors?
- How many patients have been admitted or readmitted over time?







