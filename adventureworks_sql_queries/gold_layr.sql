USE Adventure_works;

CREATE VIEW gold.dim_account AS
SELECT 'ACCT' + CAST(a.acct_code_alt_key AS VARCHAR(50)) AS acct_id,
a.acct_description,
a.acct_type,
a.value_type,
g.city,
g.state_prov_code,
g.state_prov_name,
g.cntry_region_code AS region_code,
g.eng_cntry_region_code AS country_name,
'EMP' + CAST(e.employee_natid_alt_key AS VARCHAR(50)) AS employee_id
FROM silver.dim_account a
JOIN silver.dim_geography g
ON a.account_key = g.geography_key
JOIN silver.dim_employee e
ON g.geography_key = e.employee_key;

SELECT *
FROM gold.dim_account;

SELECT *
FROM gold.dim_employee;
-- employee
CREATE VIEW gold.dim_employee AS
SELECT 'EMP' + CAST(e.employee_natid_alt_key AS VARCHAR(50)) AS employee_id,
e.first_name,
e.last_name,
e.title,
e.hire_date,
e.birth_date,
e.login_id,
e.email_address,
e.phone,
e.emergency_contact_middle_name,
e.emergency_contact_name,
e.emergency_contact_phone,
e.salaried_flag,
e.gender,
e.pay_freq,
e.base_rate,
e.vacation_hrs,
e.sick_leave_hrs,
e.current_flag,
e.sales_person_flag,
e.dept_name,
e.start_date,
g.city,
g.state_prov_code,
g.state_prov_name,
g.cntry_region_code,
g.eng_cntry_region_code AS country,
CASE
  WHEN e.dept_name = 'Sales' THEN 'Sales & Marketing'
  WHEN e.dept_name = 'Marketing' THEN 'Sales & Marketing'
  WHEN e.dept_name = 'Executive' THEN 'Executive General & Administration'
  WHEN e.dept_name = 'Production' THEN 'Manufacturing'
  WHEN e.dept_name = 'Production Control' THEN 'Manufacturing'
  WHEN e.dept_name = 'Engineering' THEN 'Manufacturing'
  WHEN e.dept_name = 'Purchasing' THEN 'Manufacturing'
  WHEN e.dept_name = 'Shipping and Receiving' THEN 'Inventory Management'
  WHEN e.dept_name = 'Finance' THEN 'Corporate'
  WHEN e.dept_name = 'Document Control' THEN 'Corporate'
  WHEN e.dept_name = 'Finance' THEN 'Corporate'
  WHEN e.dept_name = 'Human Resources' THEN 'Executive General & Administration'
  WHEN e.dept_name = 'Information Services' THEN 'Executive General & Administration'
  WHEN e.dept_name = 'Facilities and Maintenance' THEN 'Inventory Management'
  WHEN e.dept_name = 'Quality Assurance' THEN 'Quality Assurance'
  WHEN e.dept_name = 'Research and Development' THEN 'Research & Development'
  WHEN e.dept_name = 'Tool Design' THEN 'Research & Development'
END AS dept_group
FROM silver.dim_employee e
JOIN silver.dim_geography g
ON e.employee_key = g.geography_key;

-- customer
CREATE VIEW gold.dim_customer AS
SELECT c.customer_alt_key AS customer_id,
c.first_name,
c.last_name,
c.birth_date,
c.marital_status,
c.gender,
c.email_address,
c.yearly_income,
c.total_children,
c.no_children_at_home,
c.eng_edu AS education,
c.eng_occupation AS occupation,
c.house_owner_flag,
c.no_cars_owned,
c.address_line_1,
c.phone,
c.date_first_purchase,
c.commute_distance,
g.city,
g.state_prov_code,
g.state_prov_name,
g.cntry_region_code,
g.eng_cntry_region_code AS country
FROM silver.dim_customer c
JOIN silver.dim_geography g
ON c.geography_key = g.geography_key;

DROP VIEW gold.dim_customer;

SELECT *
FROM gold.dim_customer;

SELECT *
FROM gold.dim_product;

--- product table
CREATE VIEW gold.dim_product AS
SELECT p.prdt_alt_key AS prdt_id,
p.eng_prdt_name AS prdt_name,
s.eng_prdt_sub_cat_name AS prdt_sub_cat_name,
p.standard_cost,
p.finished_goods_flag,
p.colour,
p.safety_stock_level,
p.reorder_point,
p.list_price,
p.size,
p.size_range,
p.wgt,
p.days_manufacture,
p.dealer_price,
p.model_name,
eng_description AS prdt_description
FROM silver.dim_product AS p
LEFT JOIN silver.dim_product_subcategory AS s
    ON p.prdt_subcat_key = s.prdt_sub_cat_key;

SELECT *
FROM silver.dim_product
