CREATE DATABASE Hospital_record;
USE Hospital_record;

CREATE TABLE Patient (
    Id VARCHAR(36) PRIMARY KEY,
    BIRTHDATE DATE NOT NULL,            -- Birthdate is required
    DEATHDATE DATE DEFAULT NULL,        -- Allows NULL values for DEATHDATE
    PREFIX VARCHAR(10) DEFAULT NULL,    -- Allows NULL values
    FIRST VARCHAR(50) NOT NULL,         -- First name is required
    LAST VARCHAR(50) NOT NULL,          -- Last name is required
    SUFFIX VARCHAR(10) DEFAULT NULL,     -- Allows NULL values
    MAIDEN VARCHAR(50) DEFAULT NULL,     -- Allows NULL values
    MARITAL VARCHAR(20) DEFAULT NULL,    -- Allows NULL values
    RACE VARCHAR(20) DEFAULT NULL,       -- Allows NULL values
    ETHNICITY VARCHAR(20) DEFAULT NULL,  -- Allows NULL values
    GENDER CHAR(1) NOT NULL,            -- Gender is required
    BIRTHPLACE VARCHAR(100) DEFAULT NULL, -- Allows NULL values
    ADDRESS VARCHAR(100) DEFAULT NULL,    -- Allows NULL values
    CITY VARCHAR(50) DEFAULT NULL,        -- Allows NULL values
    STATE VARCHAR(50) DEFAULT NULL,       -- Allows NULL values
    COUNTY VARCHAR(50) DEFAULT NULL,      -- Allows NULL values
    ZIP VARCHAR(10) DEFAULT NULL,         -- Allows NULL values
    LAT DECIMAL(10, 8) DEFAULT NULL,      -- Allows NULL values
    LON DECIMAL(11, 8) DEFAULT NULL       -- Allows NULL values
);


LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Hospital+Patient+Records/patients.csv"
INTO TABLE patient
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS
(Id, BIRTHDATE, @DEATHDATE, PREFIX, FIRST, LAST, SUFFIX, MAIDEN, MARITAL, RACE, ETHNICITY, GENDER, BIRTHPLACE, ADDRESS, CITY, STATE, COUNTY, ZIP, LAT, LON)
SET DEATHDATE = NULLIF(@DEATHDATE, '');

select * from patient;

CREATE TABLE Organization (
    Id VARCHAR(36) PRIMARY KEY,
    NAME VARCHAR(100) NOT NULL,
    ADDRESS VARCHAR(100) DEFAULT NULL,
    CITY VARCHAR(50) DEFAULT NULL,
    STATE VARCHAR(50) DEFAULT NULL,
    ZIP VARCHAR(10) DEFAULT NULL,
    LAT DECIMAL(10, 8) DEFAULT NULL,
    LON DECIMAL(11, 8) DEFAULT NULL
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Hospital+Patient+Records/organizations.csv"
INTO TABLE organization
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

select * from organization;

CREATE TABLE Payers (
    Id VARCHAR(36) PRIMARY KEY,
    NAME VARCHAR(100) NOT NULL,
    ADDRESS VARCHAR(100) DEFAULT NULL,
    CITY VARCHAR(50) DEFAULT NULL,
    STATE_HEADQUARTERED VARCHAR(50) DEFAULT NULL,
    ZIP VARCHAR(10) DEFAULT NULL,
    PHONE VARCHAR(15) DEFAULT NULL
);


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Hospital+Patient+Records/payers.csv'
INTO TABLE Payers
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;


select * from payers;


CREATE TABLE Encounters (
    Id VARCHAR(36) PRIMARY KEY,
    Start_Date DATE,
    Start_Time TIME,
    End_Date DATE,
    End_Time TIME,
    Patient VARCHAR(36),
    Organization VARCHAR(36),
    Payer VARCHAR(36),
    EncounterClass VARCHAR(50),
    Code VARCHAR(50),
    Description TEXT,
    Base_Encounter_Cost DECIMAL(10, 2),
    Total_Claim_Cost DECIMAL(10, 2),
    Payer_Coverage DECIMAL(10, 2),
    ReasonCode VARCHAR(50),
    ReasonDescription TEXT,
	FOREIGN KEY (Patient) REFERENCES Patient(Id),
    FOREIGN KEY (Organization) REFERENCES Organization(Id),
    FOREIGN KEY (Payer) REFERENCES Payers(Id)
);


LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Hospital+Patient+Records/encounters.csv"
INTO TABLE encounters
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

select * from encounters;


CREATE TABLE Procedures (
    Start_Date DATE,
    Start_Time TIME,
    Stop_Date DATE,
    Stop_Time TIME,
    Patient VARCHAR(36),
    Encounter VARCHAR(36),
    Code VARCHAR(50),
    Description VARCHAR(150),
    Base_Cost int(10),
    ReasonCode VARCHAR(50),
    ReasonDescription VARCHAR(150),
    FOREIGN KEY (Patient) REFERENCES Patient(Id),
    FOREIGN KEY (Encounter) REFERENCES Encounters(Id)
);


LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Hospital+Patient+Records/procedures.csv"
INTO TABLE procedures
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;







