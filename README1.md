# HR Analytics — End-to-End Workforce Attrition Project

![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)
![DAX](https://img.shields.io/badge/DAX-185FA5?style=for-the-badge)
![Star Schema](https://img.shields.io/badge/Star%20Schema-1E3C73?style=for-the-badge)

> **296 employees left this organization every single day. The data revealed it wasn't a hiring problem — it was a structural one.**

---

## 📌 Project Overview

A full end-to-end HR analytics project analyzing a workforce of **1,048,575 employees** across **5 departments** and **7 countries** to identify the root causes of employee attrition and deliver executive-level recommendations.

**Complete workflow:**

```
CSV Files → SQL Server → Data Cleaning & Validation → Exploratory SQL Analysis
→ Star Schema Modeling → DAX Development (27 measures)
→ Interactive Power BI Dashboard → Executive Recommendations
```

---

## 🎯 Business Problem

The organization was experiencing a **10.3% overall attrition rate** — but leadership didn't know:
- **Who** was leaving
- **Why** they were leaving
- **When** in their tenure the decision was being made
- **What** it was costing the business

This project answers all four questions with data.

---

## 🔍 Key Findings

| Finding | Detail |
|---|---|
| **Junior Attrition Crisis** | 16.6% — more than double the company average of 10.3% |
| **Early-Career Gap** | 67.1% of all leavers exit within their first 4 years |
| **Pay-for-Performance Failure** | Only $7.42 salary gap between Excellent and Needs Improvement performers |
| **HR Paradox** | Highest attrition (12%) + lowest avg salary ($74.6K) — the retention team can't retain itself |
| **Structural, Not Geographic** | All 7 countries within ±0.2% of each other — geography explains nothing |
| **High Risk Exposure** | 58,789 active employees currently rated Needs Improvement |
| **Flight Risk** | 20,479 active Junior employees with low performance |

---

## 💰 Business Impact

- Junior attrition costs an estimated **$1.67B/year** in replacement (conservative · 50% of salary)
- Factoring in onboarding and productivity loss: **$3.3B–$5B annually**
- **1% reduction in attrition = 10,486 employees retained = ~$473M in annual savings**
- 58,789 high-risk employees represent a **$2.65B potential exposure**

---

## 📊 Dashboard

### Page 1 — Overview
![Overview](<img width="633" height="362" alt="1" src="https://github.com/user-attachments/assets/08433d1d-8c3b-4998-8064-9740f401c291" />
)

### Page 2 — Attrition Analysis
![Attrition](<img width="637" height="354" alt="2" src="https://github.com/user-attachments/assets/289fec40-61b2-49c3-ad88-25eaa576dabf" />
)

### Page 3 — Salary & Performance
![Salary & Performance](<img width="634" height="356" alt="3" src="https://github.com/user-attachments/assets/6716563e-ec3e-4eb1-bd17-973dbb00d43f" />
)

### Page 4 — Deep Dive: Root Cause Analysis
![Deep Dive](<img width="634" height="356" alt="3" src="https://github.com/user-attachments/assets/5668ddd4-ebb7-43b4-a0fc-167930251d34" />
)

### Data Model — Star Schema
![Data Model](<img width="503" height="379" alt="5" src="https://github.com/user-attachments/assets/efa3ee90-7ad8-4cdb-805d-709730e61704" />
)

---

## 🛠 Technical Stack

| Tool | Usage |
|---|---|
| **SQL Server** | Data ingestion, cleaning, validation, exploratory analysis, star schema design |
| **Power BI Desktop** | Star schema modeling, DAX measures, interactive 4-page dashboard |
| **DAX** | 27 measures across 5 display folders |
| **Star Schema** | Fact_Employee + 4 dimension tables |

---

## 🗄 Data Model

```
Fact_Employee (1,048,575 rows)
    ├── Dim_Job          [Job_Title, Job_Level, Department, Work_Mode]
    ├── Dim_Performance  [Performance_Rating, Status]
    ├── Dim_Employee     [Full_Name, Age, Age_Group, Experience_Years]
    └── Dim_Location     [Country, City]
```

All relationships: **Many-to-One · Single Direction · Active**

---

## 📐 DAX Measures (27 total)

| Folder | Measures |
|---|---|
| 1. Core Counts | Total Employee, Active Employee, Total Leavers, High Risk Employees, Early Attrition Employees, Flight Risk Employees |
| 2. Attrition & Retention | Attrition Rate, Retention Rate, Junior Attrition Rate, Early Attrition Rate, Dept Attrition vs Company, Early Attrition by Hire Year, Resigned Rate |
| 3. Performance | Excellent Rate, Needs Improvement Rate, High Risk Rate, Top Performer Retention |
| 4. Salary & Compensation | Avg Salary, Salary Gap, Avg Tenure (Leavers) |
| 5. Labels & Display | Leavers Label, Active Label, High Risk Label, Excellent Employees Label, Salary Gap Label |

---

## 🗂 SQL Analysis

The full SQL script is available in [`Final_HR_Project.sql`](Final_HR_Project.sql)

Key queries include:

```sql
-- Workforce Overview with Attrition Rate
WITH Workforce_Overview AS (
    SELECT
        COUNT(*) AS Total_Employees,
        COUNT(CASE WHEN Status = 'ACTIVE' THEN 1 END) AS Active_Employees,
        COUNT(CASE WHEN Status != 'ACTIVE' THEN 1 END) AS Total_Leavers,
        COUNT(CASE WHEN Status = 'RESIGNED' THEN 1 END) AS Resigned_Employees
    FROM employee
)
SELECT *, ROUND(Total_Leavers * 1.0 / Total_Employees * 100, 2) AS Attrition_Rate
FROM Workforce_Overview;
```

```sql
-- Attrition by Job Level
SELECT
    Job_Level,
    COUNT(*) AS Total_Employees,
    ROUND(AVG(Salary), 2) AS Avg_Salary,
    ROUND(COUNT(CASE WHEN Status != 'ACTIVE' THEN 1 END) * 1.0 / COUNT(*) * 100, 2) AS Attrition_Rate
FROM employee
GROUP BY Job_Level
ORDER BY Avg_Salary DESC;
```

```sql
-- Star Schema: Fact_Employee view
CREATE VIEW Fact_Employee AS
SELECT
    e.Employee_ID, j.Job_ID, p.Performance_ID, l.Location_ID,
    e.Salary, e.Experience_Years, e.Hire_Year, e.Age_Group, e.Hire_Date
FROM employee e
JOIN Dim_Job j ON e.Job_Title = j.Job_Title AND e.Job_Level = j.Job_Level
    AND e.Department = j.Department AND e.Work_Mode = j.Work_Mode
JOIN Dim_Performance p ON e.Performance_Rating = p.Performance_Rating AND e.Status = p.Status
JOIN Dim_Location l ON e.Country = l.Country AND e.City = l.City;
```

---

## ✅ Executive Recommendations

1. **Redesign Junior compensation bands** — every $1 invested saves $5+ in replacement costs
2. **Launch early-tenure retention program** targeting the first 3 years — where 67% of attrition is concentrated
3. **Fix pay-for-performance** — $7.42 gap between top and bottom performers creates zero incentive
4. **HR department emergency review** — highest attrition + lowest salary = the retention team needs saving first
5. **Replicate IT retention practices** (lowest attrition at 9.1%) across high-risk departments

---

## 📁 Repository Structure

```
HR-Analytics-End-to-End-Project/
│
├── screenshots/
│   ├── 01_overview.png
│   ├── 02_attrition.png
│   ├── 03_salary_performance.png
│   ├── 04_deep_dive.png
│   └── 05_data_model.png
│
├── Final_HR_Project.sql
└── README.md
```

---

## 🔗 Connect

**Fares Mubarak** — Data Analyst

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/fares-mubarak)
[![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/Fares-Mubarak)
[![Portfolio](https://img.shields.io/badge/Portfolio-1E3C73?style=for-the-badge)](https://fares-mubarak.super.site)

---

*Built to demonstrate end-to-end analytical thinking — from raw data to executive decision support.*
