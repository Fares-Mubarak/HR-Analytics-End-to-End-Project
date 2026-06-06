# HR Analytics — End-to-End Workforce Attrition Project

![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)
![DAX](https://img.shields.io/badge/DAX-185FA5?style=for-the-badge)
![Star Schema](https://img.shields.io/badge/Star%20Schema-1E3C73?style=for-the-badge)

> **296 employees left this organization every single day. The data revealed it wasn't a hiring problem — it was a structural one.**

---

## 📌 Project Overview

A full end-to-end HR analytics project analyzing a workforce of **1,048,575 employees** across **5 departments** and **7 countries** to identify the root causes of employee attrition and deliver executive-level recommendations.

The project covers the complete data analytics workflow:

**CSV Files → SQL Server → Data Cleaning & Validation → Exploratory SQL Analysis → Star Schema Modeling → DAX Development → Interactive Power BI Dashboard → Statistical Analysis → Executive Recommendations**

---

## 🎯 Business Problem

The organization was experiencing a **10.3% overall attrition rate** — but the leadership team didn't know:
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
| **Flight Risk** | 20,479 active Junior employees with low performance — immediate risk segment |

---

## 💰 Business Impact

- Junior attrition costs an estimated **$1.67B/year** in replacement (conservative)
- Factoring in onboarding and productivity loss: **$3.3B–$5B annually**
- A **1% reduction in attrition = 10,486 employees retained = ~$473M in annual savings**
- 58,789 high-risk employees represent a **$2.65B potential exposure**

---

## 🛠 Technical Stack

| Tool | Usage |
|---|---|
| **SQL Server** | Data ingestion, cleaning, validation, exploratory analysis |
| **Power BI Desktop** | Star schema modeling, DAX measures, interactive dashboard |
| **DAX** | 27 measures covering attrition, retention, salary, performance, risk |
| **Star Schema** | Fact_Employee + 4 dimension tables (Dim_Job, Dim_Performance, Dim_Employee, Dim_Location) |
| **Statistical Analysis** | Chi-square tests, Z-tests, Pearson correlation, Linear regression |

---

## 📊 Data Model

```
Fact_Employee (1,048,575 rows)
    ├── Dim_Job          [Job_Title, Job_Level, Department, Work_Mode]
    ├── Dim_Performance  [Performance_Rating, Status]
    ├── Dim_Employee     [Full_Name, Age, Experience_Years]
    └── Dim_Location     [Country, City]
```

- All relationships: **Many-to-One**, **Single Direction**, **Active**
- No snowflaking — pure star schema for optimal query performance

---

## 📐 DAX Measures (27 total)

Organized into 5 display folders:

| Folder | Measures |
|---|---|
| 1. Core Counts | Total Employee, Active Employee, Total Leavers, High Risk Employees, Early Attrition Employees, Flight Risk Employees |
| 2. Attrition & Retention | Attrition Rate, Retention Rate, Junior Attrition Rate, Early Attrition Rate, Dept Attrition vs Company, Resigned Rate |
| 3. Performance | Excellent Rate, Needs Improvement Rate, High Risk Rate, Top Performer Retention |
| 4. Salary & Compensation | Avg Salary, Salary Gap, Avg Tenure (Leavers) |
| 5. Labels & Display | Leavers Label, Active Label, High Risk Label, Excellent Employees Label |

---

## 📋 Dashboard Pages

### Page 1 — Overview
Executive summary with 4 KPI cards, department breakdown, attrition by job level, salary vs performance, and work mode distribution.

### Page 2 — Attrition Analysis
Attrition trend by hire year (2008–2026), department × job level heatmap, exit type breakdown (77.6% resigned), and key insight callouts.

### Page 3 — Salary & Performance Analysis
Compensation structure by department and job level, performance distribution, pay-for-performance gap analysis.

### Page 4 — Deep Dive: Root Cause Analysis
Interactive filters (Department, Job Level, Performance, Work Mode), country-level breakdown, business impact, critical findings, and executive recommendations.

---

## 📈 Statistical Validation

| Test | Result | Interpretation |
|---|---|---|
| Chi-square (Department) | p = 9.89e-216 | Dept differences are real, not random |
| Chi-square (Job Level) | p ≈ 0 | Level differences are statistically proven |
| Z-test (Junior vs Rest) | Z = 164, p ≈ 0 | Junior crisis is not chance — 99.9% confidence |
| Pearson r (Salary vs Attrition) | r = −0.98 | Strong inverse correlation — lower new-hire salary = higher attrition |
| Linear Regression (Trend) | R² = 0.82 | 82% of attrition variance explained by time alone |
| Projected 2027 attrition | 13.2% | If no intervention is made |

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
├── SQL/
│   ├── 01_data_cleaning.sql
│   ├── 02_exploratory_analysis.sql
│   └── 03_workforce_queries.sql
│
├── Screenshots/
│   ├── 01_overview.png
│   ├── 02_attrition.png
│   ├── 03_salary_performance.png
│   └── 04_deep_dive.png
│
├── HR_Dashboard.pbix
└── README.md
```

---

## 🔗 Connect

**Fares Mubarak** — Data Analyst

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/fares-mubarak)
[![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/Fares-Mubarak)
[![Portfolio](https://img.shields.io/badge/Portfolio-1E3C73?style=for-the-badge)](https://fares-mubarak.super.site)

---

*This project was built as part of a data analytics portfolio to demonstrate end-to-end analytical thinking — from raw data to executive decision support.*
