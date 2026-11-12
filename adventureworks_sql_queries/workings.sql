USE Adventure_works;
EXEC bronze.load_bronze;
EXEC silver.load_silver;


SELECT *
FROM bronze.dim_account
WHERE acct_description = 'Balance Sheet';
-- acct key prent acct key 1, 2, 3

SELECT *
FROM silver.dim_account a
JOIN silver.dim_account b
 ON a.acct_type = b.acct_type
 WHERE a.acct_type IS NULL AND b.acct_type IS NOT NULL;

SELECT account_key,
COUNT(*)
FROM bronze.dim_account
GROUP BY account_key
HAVING COUNT(*) > 1;

SELECT *
FROM bronze.dim_department_group;

SELECT DISTINCT custom_mbers
FROM bronze.dim_account;

SELECT *
FROM bronze.dim_currency;
-- currency key 1, 2, 3

SELECT *
FROM bronze.dim_department_group;
-- dept grp key

ALTER TABLE bronze.dim_geography
ADD terr NVARCHAR(50);

UPDATE bronze.dim_geography
SET terr = CONCAT(postal_code, '', sales_territory_key);

SELECT geography_key,
COUNT(*)
FROM bronze.dim_geography
GROUP BY geography_key
HAVING COUNT(*) > 1;

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
-- geo key

SELECT *
FROM silver.dim_geography;

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
commute_distance
FROM bronze.dim_customer;

SELECT *
FROM silver.dim_customer;

SELECT customer_key,
COUNT(*)
FROM bronze.dim_customer
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- customer key, alt key [customer id]
-- geo key
SELECT DISTINCT suffix
FROM bronze.dim_customer;

SELECT RIGHT(date_key,1)
FROM bronze.dim_date;

SELECT date_key,
COUNT(*)
FROM bronze.dim_date
GROUP BY date_key
HAVING COUNT(*) > 1;
-- date key, and alt key[real date]

SELECT *
FROM silver.dim_date;

SELECT employee_key,
COUNT(*)
FROM bronze.dim_employee
GROUP BY employee_key
HAVING COUNT(*) > 1;

SELECT DISTINCT end_date
FROM silver.dim_employee;

SELECT *
FROM silver.dim_employee;

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
emergency_contact_middle_name,
emergency_contact_name,
emergency_contact_phone,
salaried_flag,
CASE WHEN UPPER(TRIM(gender)) = 'F' THEN 'Female'
     WHEN UPPER(TRIM(gender)) = 'M' THEN 'Male'
     ELSE'n/a'
END AS gender,
pay_freq,
base_rate,
vacation_hrs,
sick_leave_hrs,
current_flag,
sales_person_flag,
dept_name,
start_date,
end_date,
status
FROM bronze.dim_employee;

-- remake employee key
-- prnt emp key, emp natid key, sales terr key

SELECT *
FROM silver.dim_organization;
-- org key, prnt org key

SELECT *
FROM silver.dim_product_category;
-- prd cat key, prd cat alt key

SELECT *
FROM silver.dim_product;

SELECT
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
eng_description
FROM bronze.dim_product;
-- prdt key, prd subcat key

SELECT *
FROM bronze.dim_product;

SELECT *
FROM silver.dim_product
WHERE prdt_key IS NULL;

SELECT *
FROM silver.dim_product_subcategory;
-- prdt key, prd subcat key

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

SELECT *
FROM silver.dim_promotion;
-- promo key, promo alt key