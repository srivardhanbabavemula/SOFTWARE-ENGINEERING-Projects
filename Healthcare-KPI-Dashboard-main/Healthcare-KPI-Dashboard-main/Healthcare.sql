SET GLOBAL SQL_SAFE_UPDATES = 0;

CREATE DATABASE Healthcare;
USE Healthcare;

ALTER TABLE data_healthcare_lab MODIFY COLUMN `Test Date` DATE;
UPDATE data_healthcare_patient
SET DOB = STR_TO_DATE(DOB , '%d-%m-%Y %H:%i')
WHERE DOB IS NOT NULL AND DOB != '';
ALTER TABLE data_healthcare_visit MODIFY COLUMN `Visit Date` DATE;

select * FROM data_healthcare_lab;

-- Data Model 
SELECT P.Patient_ID, P.FirstName,  P.Gender, P.DOB, P.Age, P.BloodType, P.Insc_Provider, 
 P.State, P.City, P.Country, P.Med_Hist, P.Race, P.Ethnicity, P.Marital_Status, P.Chronic_Conditn, 
 P.Allergies, D.`Doctor ID`, D.`Doctor Name`, D.Specialty, D.`Years Of Experience`, D.Specialization,
 V.`Visit ID`, V.`Visit Date`, V.`Visit Type`, V.`Reason for Visit`, V.`Visit Status`, V.`Follow Up Required`,
 T.`Treatment ID`,T.`Treatment Type`,T.`Treatment Name`, T.`Status`, T.`Treatment Cost`,
 L.`Lab Result ID`, L.`Test Name`, L.`Test Date`, L.Result, L.Units
 FROM data_healthcare_patient P
 JOIN data_healthcare_visit V ON V.`Patient ID` = P.`Patient_ID` 
 JOIN data_healthcare_doctor D ON D.`Doctor ID` = V.`Doctor ID`
 LEFT JOIN data_healthcare_treatment T ON T.`Visit ID` = V.`Visit ID`
 LEFT JOIN data_healthcare_lab L ON L.`Visit ID` = V.`Visit ID`
 ORDER BY `Visit Date` DESC;
 
 -- Total Patient count 
 SELECT COUNT(Patient_ID) FROM data_healthcare_patient;
 
 -- Treatment cost per visit 
SELECT ROUND(sum(`Treatment Cost`)/count(*),2) AS Average_cost from data_healthcare_treatment;
 
 -- Average Age
 SELECT Round(SUM(age)/count(Patient_ID),2) AS Average_age from data_healthcare_patient;
 
-- Follow-up rate
SELECT CONCAT(ROUND((SUM(CASE WHEN `Follow Up Required`='YES' THEN 1 ELSE 0 END)/count(`Patient ID`)*100),2),"%") AS Followup_rate FROM data_healthcare_visit;

-- Age wise patient Distribution 
SELECT CASE 
 WHEN Age BETWEEN 0 AND 18 THEN "Young" 
 WHEN Age BETWEEN 19 AND 35 THEN "Adult" 
 WHEN Age BETWEEN 36 AND 55 THEN "Middle-Aged"
 ELSE "Senior-Citizen"
 END AS Age_Groups, COUNT(Patient_ID) AS Patient_Count FROM data_healthcare_patient
 GROUP BY Age_Groups ORDER BY Patient_Count ASC;
 
-- Frequently Observed Conditions
SELECT Chronic_Conditn AS Chronic_Condition, COUNT(*) AS diagnosis_count
FROM data_healthcare_patient
GROUP BY Chronic_Conditn
ORDER BY diagnosis_count DESC
LIMIT 5;
-- Diagnosis 
SELECT Diagnosis, count(*) AS Diagnosis_Count FROM data_healthcare_visit 
GROUP BY Diagnosis;

-- location Wise Analysis
SELECT SUM(CASE WHEN `Follow Up Required`='YES' THEN 1 ELSE 0 END) AS Patient_count, City 
FROM data_healthcare_visit V Join data_healthcare_patient P on V.`Patient ID`= P.Patient_ID GROUP BY City; 

-- Visits over Time
SELECT 
    YEAR(`Visit Date`) AS visit_year,
    COUNT(*) AS visit_count
FROM data_healthcare_visit
GROUP BY visit_year
ORDER BY visit_year;
SELECT 
    DATE_FORMAT(`Visit Date`, '%Y-%m') AS visit_month,
    COUNT(*) AS visit_count
FROM data_healthcare_visit
GROUP BY visit_month
ORDER BY visit_month;

-- Lab Result 
SELECT `Test Name`, `Reference Range`, count(`Lab Result ID`) AS Result_Count 
FROM data_healthcare_lab 
GROUP BY `Test Name`, `Reference Range`
ORDER BY `Test Name`, `Reference Range`;

-- Percentage of Abnormal test
SELECT 
concat(ROUND((sum(CASE WHEN Result = 'Abnormal' THEN 1 ELSE 0 END)/count(*)*100),2),'%') 
AS Abnormal_Test FROM data_healthcare_lab;

-- Most Prescribed Medicines 
SELECT `Medication Prescribed`, count(`Visit ID`) AS Total_Prescribed 
FROM data_healthcare_treatment GROUP BY `Medication Prescribed`
ORDER BY Total_Prescribed DESC;

-- DOC overload
SELECT 
    `Doctor Name`,
    COUNT(`Visit ID`) AS visit_count
FROM data_healthcare_doctor D 
JOIN data_healthcare_visit V 
ON D.`Doctor ID` = V.`Doctor ID`
GROUP BY `Doctor Name`
ORDER BY visit_count DESC
LIMIT 10;

-- COMMONLY OBSERVED CONDITION
-- SELECT CASE 
--  WHEN Age BETWEEN 0 AND 18 THEN "Young" 
--  WHEN Age BETWEEN 19 AND 35 THEN "Adult" 
--  WHEN Age BETWEEN 36 AND 55 THEN "Middle-Aged"
--  ELSE "Senior-Citizen"
--  END AS Age_Groups, COUNT(Patient_ID) AS Patient_Count, Chronic_Conditn AS Chronic_Condition FROM data_healthcare_patient
-- WHERE Chronic_Conditn IN (
--     SELECT Chronic_Conditn FROM (
--         SELECT Chronic_Conditn, COUNT(*) AS diagnosis_count
--         FROM data_healthcare_patient
-- 		GROUP BY Chronic_Conditn
-- 		ORDER BY diagnosis_count DESC
-- 		LIMIT 5
--     ) AS top_diagnoses
-- )
-- GROUP BY Age_Groups, Chronic_Conditn
-- ORDER BY  Patient_Count, Chronic_Condition DESC;