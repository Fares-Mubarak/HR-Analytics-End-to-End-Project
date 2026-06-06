-- DATABASE CREATION


CREATE DATABASE HR_Project;
GO

USE HR_Project;
GO

/*
Employee dataset was imported from a CSV file
into SQL Server to simulate a real-world BI workflow.
*/

Select*from employee;



-- DATA QUALITY CHECK
SELECT
    SUM(CASE WHEN Employee_ID IS NULL THEN 1 ELSE 0 END) AS Null_ID,
    SUM(CASE WHEN Full_Name IS NULL THEN 1 ELSE 0 END) AS Null_Name,
    SUM(CASE WHEN Salary IS NULL THEN 1 ELSE 0 END) AS Null_Salary,
    SUM(CASE WHEN Performance_Rating IS NULL THEN 1 ELSE 0 END) AS Null_PR,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Null_Age,
    SUM(CASE WHEN Job_Level IS NULL THEN 1 ELSE 0 END) AS Null_JobLevel,
    SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END) AS Null_City
FROM employee;
-- Dataset contains no missing values in critical columns


-- WORKFORCE OVERVIEW
WITH Workforce_Overview AS (
SELECT
COUNT(*) AS Total_Employees,
COUNT(CASE WHEN Status = 'ACTIVE' THEN 1 END) AS Active_Employees,
COUNT(CASE WHEN Status != 'ACTIVE' THEN 1 END) AS Total_Leavers,
COUNT(CASE WHEN Status = 'TERMINATED' THEN 1 END) AS Terminated_Employees,
COUNT(CASE WHEN Status = 'RESIGNED' THEN 1 END) AS Resigned_Employees,
COUNT(CASE WHEN Status = 'RETIRED' THEN 1 END) AS Retired_Employees
FROM employee
)

SELECT *,
ROUND(Total_Leavers * 1.0 / Total_Employees * 100, 2) AS Attrition_Rate
FROM Workforce_Overview;
/*
Key Findings:

Attrition Rate exceeded 10%
Majority of exits are voluntary resignations
Retirements represent a very small percentage
*/


-- PERFORMANCE ANALYSIS
SELECT
Performance_Rating,
COUNT(*) AS Total_Employees,
COUNT(CASE WHEN Status = 'ACTIVE' THEN 1 END) AS Active_Employees,
COUNT(CASE WHEN Status != 'ACTIVE' THEN 1 END) AS Total_Leavers,
ROUND(AVG(Salary), 2) AS Avg_Salary
FROM employee
GROUP BY Performance_Rating
ORDER BY Active_Employees DESC;

/*
Key Findings:

Minimal salary differentiation between performance levels
Compensation structure does not strongly reward performance
*/

-- WORK MODE ANALYSIS
SELECT
    Work_Mode,
    COUNT(*) AS Total_Employees,
    ROUND(AVG(Salary), 2) AS Avg_Salary,
    ROUND(COUNT(CASE WHEN Status != 'Active' THEN 1 END) * 1.0 / COUNT(*) * 100, 2) AS Attrition_Rate,
    ROUND(COUNT(CASE WHEN Performance_Rating = 'Excellent' THEN 1 END) * 1.0 / COUNT(*) * 100, 2) AS Excellent_Rate,
    ROUND(COUNT(CASE WHEN Performance_Rating = 'Needs Improvement' THEN 1 END) * 1.0 / COUNT(*) * 100, 2) AS NeedsImprovement_Rate
FROM employee
GROUP BY Work_Mode
ORDER BY Excellent_Rate DESC;
/*
Key Findings:

Hybrid employees show stronger performance distribution
Remote employees have the highest Needs Improvement rate
Flexibility appears strongly connected to retention
*/

-- DEPARTMENT ANALYSIS
SELECT
    Department,
    COUNT(*) AS Total_Employees,
    ROUND(COUNT(CASE WHEN Status != 'Active' THEN 1 END) * 1.0 / COUNT(*) * 100, 2) AS Attrition_Rate,
    ROUND(AVG(Salary), 2) AS Avg_Salary,
    ROUND(COUNT(CASE WHEN Performance_Rating = 'Excellent' THEN 1 END) * 1.0 / COUNT(*) * 100, 2) AS Excellent_Rate,
    ROUND(COUNT(CASE WHEN Performance_Rating = 'Needs Improvement' THEN 1 END) * 1.0 / COUNT(*) * 100, 2) AS NeedsImprovement_Rate
FROM employee
GROUP BY Department
ORDER BY Total_Employees DESC;
/*
Key Findings:

HR has the highest attrition rate
HR also records the highest Needs Improvement rate
IT and Sales represent the largest workforce segments
*/

-- JOB LEVEL ANALYSIS
SELECT
    Job_Level,
    COUNT(*) AS Total_Employees,
    ROUND(AVG(Salary), 2) AS Avg_Salary,
    ROUND(COUNT(CASE WHEN Performance_Rating = 'Excellent' THEN 1 END) * 1.0 / COUNT(*) * 100, 2) AS Excellent_Rate,
    ROUND(COUNT(CASE WHEN Status != 'ACTIVE' THEN 1 END) * 1.0 / COUNT(*) * 100, 2) AS Attrition_Rate
FROM employee
GROUP BY Job_Level
ORDER BY Avg_Salary DESC;
/*
Key Findings:

Junior employees show the highest attrition rate
Most employees belong to Mid and Junior levels
Early-career retention is a major business risk
*/

-- SALARY DISTRIBUTION
SELECT 
      MIN(SALARY) AS Min_Salary,
      MAX(SALARY) AS Max_Salary,
      AVG(SALARY) AS Avg_Salary
      FROM employee; 
-- Average annual salary is approximately 90K
 ALTER TABLE employee
ADD Age_Group AS (
    CASE
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE 'Over 55'
    END);

SELECT
    Age_Group,
    COUNT(*) AS Total,
    ROUND(AVG(Salary), 2) AS Avg_Salary
FROM employee
GROUP BY age_group 
ORDER BY Age_Group ;
/*
Key Findings:

Workforce is heavily concentrated below age 35
Under 25 employees have the lowest salaries
Salary positively correlates with age and experience
*/

-- COUNTRY ANALYSIS
SELECT
    Country,
    COUNT(*) AS Total_Employees,
    ROUND(AVG(Salary), 2) AS Avg_Salary,
    ROUND(COUNT(CASE WHEN Status != 'ACTIVE' THEN 1 END) * 1.0 / COUNT(*) * 100, 2) AS Attrition_Rate,
    ROUND(COUNT(CASE WHEN Performance_Rating = 'Needs Improvement' THEN 1 END) * 1.0 
        / COUNT(*) * 100, 2) AS NeedsImprovement_Rate,
    ROUND(COUNT(CASE WHEN Performance_Rating = 'Excellent' THEN 1 END) * 1.0 
        / COUNT(*) * 100, 2) AS Excellent_Rate
    from employee
    GROUP BY Country
    ORDER BY Total_Employees DESC;
/*
Key Findings:

Attrition distribution is nearly identical across countries
Indicates a structural issue rather than a geographic issue
*/

-- EXPERIENCE ANALYSIS
SELECT TOP 10
    Job_Title,
    COUNT(*) AS Total_Employees,
    ROUND(AVG(Salary), 2) AS Avg_Salary,
    ROUND(COUNT(CASE WHEN Performance_Rating = 'Needs Improvement' THEN 1 END) * 1.0 
        / COUNT(*) * 100, 2) AS NeedsImprovement_Rate,
    ROUND(COUNT(CASE WHEN Performance_Rating = 'Excellent' THEN 1 END) * 1.0 
        / COUNT(*) * 100, 2) AS Excellent_Rate
FROM employee
GROUP BY Job_Title
ORDER BY Avg_Salary DESC;
-- Company heavily invests in IT and Finance departments 
--which aligns with the highest employee counts in these departments

SELECT
    Experience_Years,
    COUNT(*) AS Total_Employees,
    ROUND(AVG(Salary), 2) AS Avg_Salary,
    ROUND(COUNT(CASE WHEN Status != 'Active' THEN 1 END) * 1.0 
          / COUNT(*) * 100, 2) AS Attrition_Rate,
    ROUND(COUNT(CASE WHEN Performance_Rating = 'Needs Improvement' THEN 1 END) * 1.0 
          / COUNT(*) * 100, 2) AS NeedsImprovement_Rate,
    ROUND(COUNT(CASE WHEN Performance_Rating = 'Excellent' THEN 1 END) * 1.0 
          / COUNT(*) * 100, 2) AS Excellent_Rate
FROM employee
GROUP BY Experience_Years
ORDER BY Experience_Years ASC;
SELECT
    Department,
    Experience_Years,
    COUNT(*) AS Employees,
    ROUND(
        COUNT(CASE WHEN Status != 'ACTIVE' THEN 1 END) * 100.0
        / COUNT(*),2
    ) AS Attrition_Rate
FROM employee
WHERE Experience_Years >= 25
GROUP BY Department, Experience_Years
ORDER BY Attrition_Rate DESC;

SELECT
    Experience_Years,
    ROUND(AVG(Salary),2) AS Avg_Salary
FROM employee
WHERE Experience_Years >= 20
GROUP BY Experience_Years
ORDER BY Experience_Years;

SELECT
    Experience_Years,
    COUNT(*) AS Total_Employees,
    ROUND(AVG(Salary),2) AS Avg_Salary,
    ROUND(
        COUNT(CASE WHEN Status != 'ACTIVE' THEN 1 END) * 100.0
        / COUNT(*),2
    ) AS Attrition_Rate
FROM employee
GROUP BY Experience_Years
ORDER BY Experience_Years;

/*
Key Findings:

Attrition drops significantly after year 3
Early-career retention provides the highest retention ROI
*/


-- STAR SCHEMA DESIGN

-- Dim_Job
CREATE VIEW Dim_Job AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY Department, Job_Title, Job_Level,work_mode) AS Job_ID,
    Job_Title,
    Job_Level,
    Department,
    Work_Mode
FROM employee
GROUP BY Department, Job_Title, Job_Level,Work_Mode;

--dim_employee
CREATE VIEW Dim_Employee AS
SELECT 
    Employee_ID,
    Full_Name,
    Age,
    Age_Group,
    Experience_Years
FROM employee;

-- Dim_Performance
CREATE VIEW Dim_Performance AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY Performance_Rating,STATUS) AS Performance_ID,
    Performance_Rating,
    Status
FROM employee
GROUP BY Performance_Rating,Status;

-- Dim_Location
CREATE VIEW Dim_Location AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY Country, City) AS Location_ID,
    Country,
    City
FROM employee
GROUP BY Country, City;

-- Fact_Employee
CREATE VIEW Fact_Employee AS
SELECT 
    e.Employee_ID,
    j.Job_ID,
    p.Performance_ID,
    l.Location_ID,
    e.Salary,
    e.Experience_Years,
    e.Hire_Year,
    e.Age_Group,
    e.Hire_Date
FROM employee e
JOIN Dim_Job j 
    ON e.Job_Title = j.Job_Title 
    AND e.Job_Level = j.Job_Level 
    AND e.Department = j.Department
    and e.Work_Mode = j.Work_Mode
JOIN Dim_Performance p 
    ON e.Performance_Rating = p.Performance_Rating
    and e.Status = p.Status
JOIN Dim_Location l 
    ON e.Country = l.Country 
    AND e.City = l.City;

select * from Fact_Employee;

