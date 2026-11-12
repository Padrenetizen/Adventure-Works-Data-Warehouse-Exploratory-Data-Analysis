
EXEC bronze.load_bronze;
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
BEGIN TRY
PRINT '====================';
PRINT 'Loading Bronze Layer';
PRINT '====================';
DECLARE @start_time DATETIME;
DECLARE @end_time DATETIME;

IF OBJECT_ID ('bronze.dim_account', 'U') IS NOT NULL
   DROP TABLE bronze.dim_account;
CREATE TABLE bronze.dim_account (
account_key INT,
parent_acct_key INT,
acct_code_alt_key INT,
parent_acct_code_alt_key INT,
acct_description NVARCHAR(50),
acct_type NVARCHAR(50),
operator NVARCHAR(50),
custom_mbers NVARCHAR(255),
value_type NVARCHAR(50),
custom_mber_options NVARCHAR(50));

PRINT '---------------------';
PRINT 'Loading DIM Tables';
PRINT '---------------------';

PRINT '>> Inserting Data Into: bronze.dim_account';
SET @start_time = GETDATE();
BULK INSERT bronze.dim_account
FROM "C:\Users\paulo\Downloads\adventureworks\dim_account(in).csv"
WITH (FIRSTROW = 1,
FIELDTERMINATOR = '|',
TABLOCK,
CODEPAGE = '65001');
SET @end_time = GETDATE();
    PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
    PRINT '---------------';

IF OBJECT_ID ('bronze.dim_currency', 'U') IS NOT NULL
   DROP TABLE bronze.dim_currency;
CREATE TABLE bronze.dim_currency (
currency_key INT,
currency_alt_key NVARCHAR(50),
currency_name NVARCHAR(50));

PRINT '>> Inserting Data Into: bronze.dim_currency';
SET @start_time = GETDATE();
BULK INSERT bronze.dim_currency
FROM "C:\Users\paulo\Downloads\adventureworks\dim_currency(in).csv"
WITH (FIRSTROW = 1,
FIELDTERMINATOR = '|',
TABLOCK,
CODEPAGE = '65001');
SET @end_time = GETDATE();
    PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
    PRINT '---------------';

IF OBJECT_ID ('bronze.dim_department_group', 'U') IS NOT NULL
   DROP TABLE bronze.dim_department_group;
CREATE TABLE bronze.dim_department_group (
dept_grp_key INT,
parent_dept_grp_key INT,
dept_grp_name NVARCHAR(50));

PRINT '>> Inserting Data Into: bronze.dim_department_group';
SET @start_time = GETDATE();
BULK INSERT bronze.dim_department_group
FROM "C:\Users\paulo\Downloads\adventureworks\dim_department_group(in).csv"
WITH (FIRSTROW = 1,
FIELDTERMINATOR = '|',
TABLOCK,
CODEPAGE = '65001');
SET @end_time = GETDATE();
    PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
    PRINT '---------------';

IF OBJECT_ID ('bronze.dim_geography', 'U') IS NOT NULL
   DROP TABLE bronze.dim_geography;
CREATE TABLE bronze.dim_geography (
geography_key INT,
city NVARCHAR(50),
state_prov_code NVARCHAR(50),
state_prov_name NVARCHAR(50),
cntry_region_code NVARCHAR(50),
eng_cntry_region_code NVARCHAR(50),
spanish_cntry_region_code NVARCHAR(50),
french_cntry_region_code NVARCHAR(50),
postal_code NVARCHAR(50),
sales_territory_key NVARCHAR(50));

PRINT '>> Inserting Data Into: bronze.dim_geography';
SET @start_time = GETDATE();
BULK INSERT bronze.dim_geography
FROM "C:\Users\paulo\Downloads\adventureworks\dim_geography(in).csv"
WITH (FIRSTROW = 1,
FIELDTERMINATOR = '|',
TABLOCK,
CODEPAGE = '65001');
SET @end_time = GETDATE();
    PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
    PRINT '---------------';

IF OBJECT_ID ('bronze.dim_customer', 'U') IS NOT NULL
   DROP TABLE bronze.dim_customer;
CREATE TABLE bronze.dim_customer (
customer_key INT,
geography_key INT,
customer_alt_key NVARCHAR(50),
title NVARCHAR(50),
first_name NVARCHAR(50),
middle_name NVARCHAR(50),
last_name NVARCHAR(50),
name_style NVARCHAR(50),
birth_date DATE,
marital_status NVARCHAR(50),
suffix NVARCHAR(50),
gender NVARCHAR(50),
email_address NVARCHAR(50),
yearly_income NVARCHAR(50),
total_children INT,
no_children_at_home INT,
eng_edu NVARCHAR(50),
spanish_edu NVARCHAR(50),
french_edu NVARCHAR(50),
eng_occupation NVARCHAR(50),
spanish_occupation NVARCHAR(50),
french_occupation NVARCHAR(50),
house_owner_flag NVARCHAR(50),
no_cars_owned INT,
address_line_1 NVARCHAR(50),
address_line_2 NVARCHAR(50),
phone NVARCHAR(50),
date_first_purchase DATE,
commute_distance NVARCHAR(50));

PRINT '>> Inserting Data Into: bronze.dim_customer';
SET @start_time = GETDATE();
BULK INSERT bronze.dim_customer
FROM "C:\Users\paulo\Downloads\adventureworks\dim_customer(in).csv"
WITH (FIRSTROW = 1,
FIELDTERMINATOR = '|',
TABLOCK,
CODEPAGE = '65001');
SET @end_time = GETDATE();
    PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
    PRINT '---------------';

IF OBJECT_ID ('bronze.dim_date', 'U') IS NOT NULL
   DROP TABLE bronze.dim_date;
CREATE TABLE bronze.dim_date (
date_key INT,
full_date_alt_key DATE,
day_no_of_week INT,
eng_day_name_week NVARCHAR(50),
spanish_day_name_week NVARCHAR(50),
french_day_name_week NVARCHAR(50),
day_no_month INT,
day_no_year INT,
week_no_year INT,
eng_month_name NVARCHAR(50),
spanish_month_name NVARCHAR(50),
french_month_name NVARCHAR(50),
month_no_year INT,
calendar_quarter INT,
calendar_year INT,
calendar_semester INT,
fiscal_quarter INT,
fiscal_year INT,
fiscal_semester INT);

PRINT '>> Inserting Data Into: bronze.dim_date';
SET @start_time = GETDATE();
BULK INSERT bronze.dim_date
FROM "C:\Users\paulo\Downloads\adventureworks\dim_date(in).csv"
WITH (FIRSTROW = 1,
FIELDTERMINATOR = '|',
TABLOCK,
CODEPAGE = '65001');
SET @end_time = GETDATE();
    PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
    PRINT '---------------';

IF OBJECT_ID ('bronze.dim_employee', 'U') IS NOT NULL
   DROP TABLE bronze.dim_employee;
CREATE TABLE bronze.dim_employee (
employee_key INT,
parent_employee_key INT,
employee_natid_alt_key NVARCHAR(50),
parent_employee_natid_alt_key NVARCHAR(50),
sales_terr_key INT,
first_name NVARCHAR(50),
last_name NVARCHAR(50),
middle_name NVARCHAR(50),
name_style NVARCHAR(50),
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
pay_freq NVARCHAR(50),
base_rate NVARCHAR(50),
vacation_hrs NVARCHAR(50),
sick_leave_hrs INT,
current_flag NVARCHAR(50),
sales_person_flag NVARCHAR(50),
dept_name NVARCHAR(50),
start_date NVARCHAR(50),
end_date NVARCHAR(50),
status NVARCHAR(50));

PRINT '>> Inserting Data Into: bronze.dim_employee';
SET @start_time = GETDATE();
BULK INSERT bronze.dim_employee
FROM "C:\Users\paulo\Downloads\adventureworks\dim_employee_fixed.csv"
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 1,
    FIELDQUOTE = '"',
    FIELDTERMINATOR = '|',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    TABLOCK
);
SET @end_time = GETDATE();
    PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
    PRINT '---------------';

IF OBJECT_ID ('bronze.dim_organization', 'U') IS NOT NULL
   DROP TABLE bronze.dim_organization;
CREATE TABLE bronze.dim_organization (
organization_key INT,
parent_organization_key INT,
percent_ownership NVARCHAR(50),
organization_name NVARCHAR(50),
currency_key INT);

PRINT '>> Inserting Data Into: bronze.dim_organization';
SET @start_time = GETDATE();
BULK INSERT bronze.dim_organization
FROM "C:\Users\paulo\Downloads\adventureworks\dim_organization(in).csv"
WITH (FIRSTROW = 1,
FIELDTERMINATOR = '|',
TABLOCK,
CODEPAGE = '65001');
SET @end_time = GETDATE();
    PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
    PRINT '---------------';

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

IF OBJECT_ID ('bronze.dim_product', 'U') IS NOT NULL
   DROP TABLE bronze.dim_product;
CREATE TABLE bronze.dim_product (
prdt_key NVARCHAR(255),
prdt_alt_key NVARCHAR(50),
prdt_subcat_key NVARCHAR(255),
wgt_unit_measure_code NVARCHAR(50),
size_unit_measure_code NVARCHAR(50),
eng_prdt_name NVARCHAR(50),
spanish_prdt_name NVARCHAR(50),
french_prdt_name NVARCHAR(50),
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
prdt_line NVARCHAR(50),
dealer_price NVARCHAR(50),
class NVARCHAR(50),
style NVARCHAR(50),
model_name NVARCHAR(50),
large_photo VARCHAR(MAX),
eng_description NVARCHAR(MAX),
french_description NVARCHAR(MAX),
chinese_description NVARCHAR(MAX),
arabic_description NVARCHAR(MAX),
hebrew_description NVARCHAR(MAX),
thai_description NVARCHAR(MAX),
german_description NVARCHAR(MAX),
japanese_description NVARCHAR(MAX),
turkish_description NVARCHAR(MAX),
start_date NVARCHAR(MAX),
end_date NVARCHAR(MAX),
status NVARCHAR(MAX)
);

PRINT '>> Inserting Data Into: bronze.dim_product';
SET @start_time = GETDATE();
BULK INSERT bronze.dim_product
FROM 'C:\Users\paulo\Downloads\adventureworks\dim_product_import_ready.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    TABLOCK
);
SET @end_time = GETDATE();
    PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
    PRINT '---------------';

IF OBJECT_ID ('bronze.dim_product_subcategory', 'U') IS NOT NULL
   DROP TABLE bronze.dim_product_subcategory;
CREATE TABLE bronze.dim_product_subcategory (
prdt_sub_cat_key INT,
prdt_sub_cat_alt_key INT,
eng_prdt_sub_cat_name NVARCHAR(50),
spanish_prdt_sub_cat_name NVARCHAR(50),
french_prdt_sub_cat_name NVARCHAR(50),
prdt_cat_key INT
);

PRINT '>> Inserting Data Into: bronze.dim_product_subcategory';
SET @start_time = GETDATE();
BULK INSERT bronze.dim_product_subcategory
FROM "C:\Users\paulo\Downloads\adventureworks\dim_product_subcategory 1(in).csv"
WITH (FIRSTROW = 1,
FIELDTERMINATOR = '|',
TABLOCK,
CODEPAGE = '65001');
SET @end_time = GETDATE();
    PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
    PRINT '---------------';

IF OBJECT_ID ('bronze.dim_promotion', 'U') IS NOT NULL
   DROP TABLE bronze.dim_promotion;
CREATE TABLE bronze.dim_promotion (
promotion_key INT,
promotion_alt_key INT,
eng_promotion_name NVARCHAR(50),
spanish_promotion_name NVARCHAR(255),
french_promotion_name NVARCHAR(50),
discount_pct NVARCHAR(50),
eng_promotion_type NVARCHAR(50),
spanish_promotion_type NVARCHAR(50),
french_promotion_type NVARCHAR(50),
eng_promotion_cat NVARCHAR(50),
spanish_promotion_cat NVARCHAR(50),
french_promotion_cat NVARCHAR(50),
start_date DATETIME,
end_date DATETIME,
min_qty INT,
max_qty NVARCHAR(50));

PRINT '>> Inserting Data Into: bronze.dim_promotion';
SET @start_time = GETDATE();
BULK INSERT bronze.dim_promotion
FROM "C:\Users\paulo\Downloads\adventureworks\dim_promotion(in).csv"
WITH (FIRSTROW = 1,
FIELDTERMINATOR = '|',
TABLOCK,
CODEPAGE = '65001');
SET @end_time = GETDATE();
    PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
    PRINT '---------------';
END TRY
BEGIN CATCH
   PRINT '==============='
   PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
   PRINT 'Error Message' + ERROR_MESSAGE();
   PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
   PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
   PRINT '==============='
END CATCH
END;