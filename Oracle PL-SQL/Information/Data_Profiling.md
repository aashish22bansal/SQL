# Data Profiling

## What is Data Profiling? 
Data Profiling in the context of PL/SQL (or any database, including Oracle) refers to the process of examining the data available in a database and collecting statistics or summaries to understand its structure, quality, and content. It is a key step in data quality assessment, ETL design, and database auditing.


---

## 🔍 What is Data Profiling in PL/SQL?

In PL/SQL, Data Profiling involves writing SQL/PLSQL code to analyze data characteristics, such as:

|Profiling Aspect|	Description|
|---|---|
|**Value Distribution**|	Frequency of each unique value (helps detect outliers or dominant categories)|
|**Null Values**|	Count or % of nulls in each column|
|**Min/Max Values	**|Detect range of values for numeric/date columns|
|**Pattern Recognition**|	Detect common data formats or inconsistent patterns using `REGEXP_LIKE`|
|**Data Type Mismatches**|	Actual content vs declared data type|
|**Uniqueness	**!|Count of distinct values — helps detect primary key candidates|
|**Dependency Analysis**|One column determining another (functional dependency check)|
|**Duplicates**|	Detect duplicate records
Length Checks	Analyze lengths of string values|



---

## 🛠️ Common PL/SQL/SQL Tasks for Data Profiling

Here are examples of what you can do in PL/SQL for profiling:

### 1. Null Check

SELECT COUNT(*) AS null_count
FROM employees
WHERE email IS NULL;

### 2. Value Frequency

SELECT department_id, COUNT(*) AS count
FROM employees
GROUP BY department_id
ORDER BY count DESC;

### 3. Distinct Count

SELECT COUNT(DISTINCT job_id) AS distinct_jobs
FROM employees;

### 4. Min/Max Values

SELECT MIN(hire_date), MAX(hire_date)
FROM employees;

### 5. Data Length Profile

SELECT LENGTH(email) AS email_length, COUNT(*)
FROM employees
GROUP BY LENGTH(email)
ORDER BY email_length;

### 6. Pattern Check (e.g., valid email)

SELECT email
FROM employees
WHERE NOT REGEXP_LIKE(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');


---

## 📦 Why Perform Data Profiling in PL/SQL?

* ✅ Validate data quality before loading into target systems (ETL)
* ✅ Detect anomalies, invalid formats, and missing values
* ✅ Understand legacy or unfamiliar datasets
* ✅ Prepare metadata or documentation
* ✅ Suggest transformations for cleansing and enrichment



---

## 🚀 Tip: Automating Data Profiling

You can write a PL/SQL procedure that dynamically loops over columns of a table and generates profiling statistics using DBMS_SQL or EXECUTE IMMEDIATE. This is useful for reusable, automated profiling tools.

