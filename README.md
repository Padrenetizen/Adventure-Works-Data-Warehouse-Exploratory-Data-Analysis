Title: Adventure Works Data Warehouse & Exploratory Data Analysis

Project Overview: The aim of this project is to build a complete and fully operational data warehouse and to also perform EDA to understand the data.

Architecture: Bronze → Silver → Gold.

Tools: SQL Server 2022, SSMS, SQL, Notes, Draw.io.

Data sources: Adventure works datasets used includes;
dim_account
dim_currency
dim_department_group
dim_geography
dim_customer
dim_date
dim_employee
dim_organization
dim_product_category
dim_product
dim_product_subcategory
dim_promotion.

ETL process:
Extraction Sample:
IF OBJECT_ID ('bronze.dim_product_category', 'U') IS NOT NULL
   DROP TABLE bronze.dim_product_category;
CREATE TABLE bronze.dim_product_category (
prdt_cat_key INT,
prdt_cat_alt_key INT,
eng_prdt_cat_name NVARCHAR(50),
spanish_prdt_cat_name NVARCHAR(50),
french_prdt_cat_name NVARCHAR(50),
);

PRINT '>> Inserting Data Into: bronze.dim_product_category';
SET @start_time = GETDATE();
BULK INSERT bronze.dim_product_category
FROM "C:\Users\paulo\Downloads\adventureworks\dim_product_category(in).csv"
WITH (FIRSTROW = 1,
FIELDTERMINATOR = '|',
TABLOCK,
CODEPAGE = '65001');
SET @end_time = GETDATE();
    PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
    PRINT '---------------';

Cleaned Sample:
SELECT
employee_key,
parent_employee_key,
employee_natid_alt_key,
sales_terr_key,
first_name,
last_name,
title,
hire_date,
birth_date,
login_id,
email_address,
phone,
TRIM(emergency_contact_middle_name),
emergency_contact_name,
emergency_contact_phone,
salaried_flag,
CASE WHEN UPPER(TRIM(gender)) = 'F' THEN 'Female'
     WHEN UPPER(TRIM(gender)) = 'M' THEN 'Male'
     ELSE'n/a'
END AS gender,
ABS(pay_freq),
ABS(base_rate),
ABS(vacation_hrs),
ABS(sick_leave_hrs),
CASE
   WHEN end_date IS NULL THEN 'Current'
   ELSE 'Past'
END AS current_flag,
sales_person_flag,
dept_name,
start_date
FROM bronze.dim_employee;

Exploratory Data Analysis Sample Question
SELECT city,
country,
AVG(base_rate) AS base_rate_by_city
FROM gold.dim_employee
GROUP BY city, country
ORDER BY base_rate_by_city DESC;
-- the cities with the most base rate were found to be Sillery in Canada with an average base rate of 125,
-- Rhodes in Australia with a base rate of 63, Essen & Werne in Germany with a base rate of 60 and 50, and Auburn in the US with a base rate of 48

Data quality checks
The datasets used in the building of this warehouse contained a lot of duplicates, Null values, and invalid data types which made the entire  building process daunting, and time consuming. Also, referential integrity was ensured through out the building of this warehouse.

Limitations
The current Gold tables are reporting structures, and not a transactional fact tables because of their lack of transactional data to create these tables.
