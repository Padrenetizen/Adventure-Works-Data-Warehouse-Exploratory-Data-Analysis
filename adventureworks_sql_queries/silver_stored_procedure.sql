USE Adventure_works;

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
BEGIN TRY
PRINT '====================';
PRINT 'Loading Silver Layer';
PRINT '====================';
DECLARE @start_time DATETIME, @end_time DATETIME,@batch_start_time DATETIME,
        @batch_end_time DATETIME;
SET @batch_start_time = GETDATE()

IF OBJECT_ID ('silver.dim_account', 'U') IS NOT NULL
   DROP TABLE silver.dim_account;
CREATE TABLE silver.dim_account (
account_key INT,
parent_acct_key INT,
acct_code_alt_key INT,
parent_acct_code_alt_key INT,
acct_description NVARCHAR(50),
acct_type NVARCHAR(50),
value_type NVARCHAR(50));

PRINT '---------------------';
PRINT 'Loading Silver DIM Tables';
PRINT '---------------------';

PRINT '>> Inserting Data Into: silver.dim_account';
SET @start_time = GETDATE();
INSERT INTO silver.dim_account(
account_key,
parent_acct_key,
acct_code_alt_key,
parent_acct_code_alt_key,
acct_description,
acct_type,
value_type)
SELECT account_key,
parent_acct_key,
acct_code_alt_key,
parent_acct_code_alt_key,
acct_description,
acct_type,
value_type
FROM bronze.dim_account;
SET @end_time = GETDATE();
    PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
    PRINT '---------------';

IF OBJECT_ID ('silver.dim_currency', 'U') IS NOT NULL
   DROP TABLE silver.dim_currency;
CREATE TABLE silver.dim_currency (
currency_key INT,
currency_alt_key NVARCHAR(50),
currency_name NVARCHAR(50));

PRINT '>> Inserting Data Into: silver.dim_currency';
SET @start_time = GETDATE();
INSERT INTO silver.dim_currency(
currency_key,
currency_alt_key,
currency_name)
SELECT *
FROM bronze.dim_currency;
SET @end_time = GETDATE();
    PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
    PRINT '---------------';

IF OBJECT_ID ('silver.dim_department_group', 'U') IS NOT NULL
   DROP TABLE silver.dim_department_group;
CREATE TABLE silver.dim_department_group (
dept_grp_key INT,
dept_grp_name NVARCHAR(50));

PRINT '>> Inserting Data Into: silver.dim_department_group';
SET @start_time = GETDATE();
INSERT INTO silver.dim_department_group(
dept_grp_key,
dept_grp_name)
SELECT dept_grp_key,
dept_grp_name
FROM bronze.dim_department_group;
SET @end_time = GETDATE();
    PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
    PRINT '---------------';

IF OBJECT_ID ('silver.dim_geography', 'U') IS NOT NULL
   DROP TABLE silver.dim_geography;
CREATE TABLE silver.dim_geography (
geography_key INT,
city NVARCHAR(50),
state_prov_code NVARCHAR(50),
state_prov_name NVARCHAR(50),
cntry_region_code NVARCHAR(50),
eng_cntry_region_code NVARCHAR(50),
pstal_code NVARCHAR(50),
sales_terr_key NVARCHAR(50));

PRINT '>> Inserting Data Into: silver.dim_geography';
SET @start_time = GETDATE();
INSERT INTO silver.dim_geography(geography_key,
city,
state_prov_code,
state_prov_name,
cntry_region_code,
eng_cntry_region_code,
pstal_code,
sales_terr_key)
SELECT 
geography_key,
city,
state_prov_code,
state_prov_name,
cntry_region_code,
eng_cntry_region_code,
LEFT(terr, CHARINDEX('|', terr) -1) AS pstal_code,
SUBSTRING(terr, CHARINDEX('|', terr) +1,
LEN(terr)) AS sales_terr_key
FROM bronze.dim_geography;
SET @end_time = GETDATE();
    PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
    PRINT '---------------';

IF OBJECT_ID ('silver.dim_customer', 'U') IS NOT NULL
   DROP TABLE silver.dim_customer;
CREATE TABLE silver.dim_customer (
customer_key INT,
geography_key INT,
customer_alt_key NVARCHAR(50),
first_name NVARCHAR(50),
last_name NVARCHAR(50),
birth_date DATE,
marital_status NVARCHAR(50),
gender NVARCHAR(50),
email_address NVARCHAR(50),
yearly_income INT,
total_children INT,
no_children_at_home INT,
eng_edu NVARCHAR(50),
eng_occupation NVARCHAR(50),
house_owner_flag INT,
no_cars_owned INT,
address_line_1 NVARCHAR(50),
phone NVARCHAR(50),
date_first_purchase DATE,
commute_distance NVARCHAR(50));

PRINT '>> Inserting Data Into: silver.dim_customer';
SET @start_time = GETDATE();
INSERT INTO silver.dim_customer(
customer_key,
geography_key,
customer_alt_key,
first_name,
last_name,
birth_date,
marital_status,
gender,
email_address,
yearly_income,
total_children,
no_children_at_home,
eng_edu,
eng_occupation,
house_owner_flag,
no_cars_owned,
address_line_1,
phone,
date_first_purchase,
commute_distance)
SELECT 
customer_key,
geography_key,
customer_alt_key,
first_name,
last_name,
birth_date,
CASE WHEN UPPER(TRIM(marital_status)) = 'S' THEN 'Single'
     WHEN UPPER(TRIM(marital_status)) = 'M' THEN 'Married'
     ELSE'n/a'
END AS marital_status,
CASE WHEN UPPER(TRIM(gender)) = 'F' THEN 'Female'
     WHEN UPPER(TRIM(gender)) = 'M' THEN 'Male'
     ELSE'n/a'
END AS gender,
email_address,
ABS(yearly_income) AS yearly_income,
ABS(total_children) AS total_children,
ABS(no_children_at_home) AS no_children_at_home,
eng_edu,
eng_occupation,
ABS(house_owner_flag) AS house_owner_flag,
ABS(no_cars_owned) AS no_cars_owned,
address_line_1,
phone,
date_first_purchase,
commute_distance
FROM bronze.dim_customer;
SET @end_time = GETDATE();
    PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
    PRINT '---------------';

IF OBJECT_ID ('silver.dim_date', 'U') IS NOT NULL
   DROP TABLE silver.dim_date;
CREATE TABLE silver.dim_date (
date_key INT,
full_date_alt_key DATE,
day_no_of_week INT,
eng_day_name_week NVARCHAR(50),
day_no_month INT,
day_no_year INT,
week_no_year INT,
eng_month_name NVARCHAR(50),
month_no_year INT,
calendar_quarter INT,
calendar_year INT,
calendar_semester INT,
fiscal_quarter INT,
fiscal_year INT,
fiscal_semester INT);

PRINT '>> Inserting Data Into: silver.dim_date';
SET @start_time = GETDATE();
INSERT INTO silver.dim_date(date_key,
full_date_alt_key,
day_no_of_week,
eng_day_name_week,
day_no_month,
day_no_year,
week_no_year,
eng_month_name,
month_no_year,
calendar_quarter,
calendar_year,
calendar_semester,
fiscal_quarter,
fiscal_year,
fiscal_semester)
SELECT ROW_NUMBER() OVER(ORDER BY date_key ASC) AS date_key,
full_date_alt_key,
day_no_of_week,
eng_day_name_week,
day_no_month,
day_no_year,
week_no_year,
eng_month_name,
month_no_year,
calendar_quarter,
calendar_year,
calendar_semester,
fiscal_quarter,
fiscal_year,
fiscal_semester
FROM bronze.dim_date;
SET @end_time = GETDATE();
    PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
    PRINT '---------------';

IF OBJECT_ID ('silver.dim_employee', 'U') IS NOT NULL
   DROP TABLE silver.dim_employee;
CREATE TABLE silver.dim_employee (
employee_key INT,
parent_employee_key INT,
employee_natid_alt_key NVARCHAR(50),
sales_terr_key INT,
first_name NVARCHAR(50),
last_name NVARCHAR(50),
title NVARCHAR(50),
hire_date DATE,
birth_date DATE,
login_id NVARCHAR(50),
email_address NVARCHAR(50),
phone NVARCHAR(50),
emergency_contact_middle_name NVARCHAR(50),
emergency_contact_name NVARCHAR(50),
emergency_contact_phone NVARCHAR(50),
salaried_flag NVARCHAR(50),
gender NVARCHAR(50),
pay_freq INT,
base_rate INT,
vacation_hrs INT,
sick_leave_hrs INT,
current_flag NVARCHAR(50),
sales_person_flag NVARCHAR(50),
dept_name NVARCHAR(50),
start_date NVARCHAR(50));

PRINT '>> Inserting Data Into: silver.dim_employee';
SET @start_time = GETDATE();
INSERT INTO silver.dim_employee(
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
emergency_contact_middle_name,
emergency_contact_name,
emergency_contact_phone,
salaried_flag,
gender,
pay_freq,
base_rate,
vacation_hrs,
sick_leave_hrs,
current_flag,
sales_person_flag,
dept_name,
start_date)
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
SET @end_time = GETDATE();
    PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
    PRINT '---------------';

IF OBJECT_ID ('silver.dim_organization', 'U') IS NOT NULL
   DROP TABLE silver.dim_organization;
CREATE TABLE silver.dim_organization (
organization_key INT,
percent_ownership NVARCHAR(50),
organization_name NVARCHAR(50),
currency_key INT);

PRINT '>> Inserting Data Into: silver.dim_organization';
SET @start_time = GETDATE();
INSERT INTO silver.dim_organization(
organization_key,
percent_ownership,
organization_name,
currency_key)
SELECT organization_key,
percent_ownership,
organization_name,
currency_key
FROM bronze.dim_organization;
SET @end_time = GETDATE();
    PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
    PRINT '---------------';

IF OBJECT_ID ('silver.dim_product_category', 'U') IS NOT NULL
   DROP TABLE silver.dim_product_category;
CREATE TABLE silver.dim_product_category (
prdt_cat_key INT,
prdt_cat_alt_key INT,
eng_prdt_cat_name NVARCHAR(50)
);

PRINT '>> Inserting Data Into: silver.dim_product_category';
SET @start_time = GETDATE();
INSERT INTO silver.dim_product_category(
prdt_cat_key,
prdt_cat_alt_key,
eng_prdt_cat_name)
SELECT prdt_cat_key,
prdt_cat_alt_key,
eng_prdt_cat_name
FROM bronze.dim_product_category;
SET @end_time = GETDATE();
    PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
    PRINT '---------------';

IF OBJECT_ID ('silver.dim_product', 'U') IS NOT NULL
   DROP TABLE silver.dim_product;
CREATE TABLE silver.dim_product (
prdt_key INT,
prdt_alt_key NVARCHAR(50),
prdt_subcat_key INT,
eng_prdt_name NVARCHAR(50),
standard_cost NVARCHAR(50),
finished_goods_flag NVARCHAR(50),
colour NVARCHAR(50),
safety_stock_level NVARCHAR(50),
reorder_point INT,
list_price NVARCHAR(50),
size NVARCHAR(50),
size_range NVARCHAR(50),
wgt NVARCHAR(50),
days_manufacture INT,
dealer_price NVARCHAR(50),
model_name NVARCHAR(50),
eng_description NVARCHAR(255)
);

PRINT '>> Inserting Data Into: silver.dim_product';
SET @start_time = GETDATE();
INSERT INTO silver.dim_product(
prdt_key,
prdt_alt_key,
prdt_subcat_key,
eng_prdt_name,
standard_cost,
finished_goods_flag,
colour,
safety_stock_level,
reorder_point,
list_price,
size,
size_range,
wgt,
days_manufacture,
dealer_price,
model_name,
eng_description)
SELECT
ROW_NUMBER() OVER(ORDER BY prdt_key ASC) AS prdt_key,
prdt_alt_key,
prdt_subcat_key,
eng_prdt_name,
standard_cost,
finished_goods_flag,
colour,
safety_stock_level,
reorder_point,
list_price,
size,
size_range,
wgt,
days_manufacture,
dealer_price,
model_name,
eng_description
FROM bronze.dim_product;
SET @end_time = GETDATE();
    PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
    PRINT '---------------';

IF OBJECT_ID ('silver.dim_product_subcategory', 'U') IS NOT NULL
   DROP TABLE silver.dim_product_subcategory;
CREATE TABLE silver.dim_product_subcategory (
prdt_sub_cat_key NVARCHAR(50),
prdt_sub_cat_alt_key NVARCHAR(50),
eng_prdt_sub_cat_name NVARCHAR(50),
prdt_cat_key NVARCHAR(50),
);

PRINT '>> Inserting Data Into: silver.dim_product_subcategory';
SET @start_time = GETDATE();
INSERT INTO silver.dim_product_subcategory(
prdt_sub_cat_key,
prdt_sub_cat_alt_key,
eng_prdt_sub_cat_name,
prdt_cat_key)
SELECT
prdt_sub_cat_key,
prdt_sub_cat_alt_key,
eng_prdt_sub_cat_name,
prdt_cat_key
FROM bronze.dim_product_subcategory;
SET @end_time = GETDATE();
    PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
    PRINT '---------------';

IF OBJECT_ID ('silver.dim_promotion', 'U') IS NOT NULL
   DROP TABLE silver.dim_promotion;
CREATE TABLE silver.dim_promotion (
promotion_key INT,
promotion_alt_key INT,
eng_promotion_name NVARCHAR(50),
discount_pct NVARCHAR(50),
eng_promotion_type NVARCHAR(50),
eng_promotion_cat NVARCHAR(50),
start_date DATETIME,
end_date DATETIME,
min_qty INT,
max_qty NVARCHAR(50));

PRINT '>> Inserting Data Into: silver.dim_promotion';
SET @start_time = GETDATE();
INSERT INTO silver.dim_promotion(
promotion_key,
promotion_alt_key,
eng_promotion_name,
discount_pct,
eng_promotion_type,
eng_promotion_cat,
start_date,
end_date,
min_qty,
max_qty)
SELECT promotion_key,
promotion_alt_key,
eng_promotion_name,
discount_pct,
eng_promotion_type,
eng_promotion_cat,
start_date,
end_date,
min_qty,
max_qty
FROM bronze.dim_promotion;
SET @end_time = GETDATE();
    PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
    PRINT '---------------';
SET @batch_end_time = GETDATE()
END TRY
BEGIN CATCH
   PRINT '==============='
   PRINT 'ERROR OCCURED DURING LOADING SILVER LAYER'
   PRINT 'Error Message' + ERROR_MESSAGE();
   PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
   PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
   PRINT '==============='
END CATCH
END