USE Adventure_works;

-- account type by city 
SELECT acct_type,
COUNT(acct_id) AS account_count,
city,
country_name
FROM gold.dim_account
GROUP BY acct_type, country_name, city
ORDER BY account_count DESC;
-- it was found that the 3 top cities with the most accounts with 4 
-- at the top 2 cities and 3 in the 3rd city

-- active employees
SELECT COUNT(employee_id) AS employee_count
FROM gold.dim_employee
WHERE current_flag = 'current';

-- top 5 median base rate by city
SELECT city,
country,
AVG(base_rate) AS base_rate_by_city
FROM gold.dim_employee
GROUP BY city, country
ORDER BY base_rate_by_city DESC;
-- the cities with the most base rate were found to be Sillery in Canada with an average base rate of 125,
-- Rhodes in Australia with a base rate of 63, Essen & Werne in Germany with a base rate of 60 and 50, and Auburn in the US with a base rate of 48

-- least 5 median base rate by city
SELECT city,
country,
AVG(base_rate) AS base_rate_by_city
FROM gold.dim_employee
GROUP BY city, country
ORDER BY base_rate_by_city ASC;
-- the cities with the least base rate were found to be East brisbane, Geelong, Melbourne,
-- Melton, Rokhampton with an average base rase of 9, and they were all cities in Australia

-- employees by dept group
SELECT COUNT(employee_id) AS employee_count,
dept_group
FROM gold.dim_employee
GROUP BY dept_group
ORDER BY employee_count DESC;
-- 69.7% of employees belong to the Manufacturing department,and while 29.3% of the remaining employees belong to the other remaining 6 department groups

-- median base rate by job role
SELECT title,
SUM(base_rate) AS base_rate_by_role
FROM gold.dim_employee
GROUP BY title
ORDER BY base_rate_by_role DESC;
-- it was found that the top paying role at this company is the role of Production Technician

-- active employees by country
SELECT COUNT(employee_id) AS employee_count,
country
FROM gold.dim_employee
WHERE current_flag = 'current'
GROUP BY country
ORDER BY employee_count DESC;
-- the country with the most workers was found to be Canada, and the country with the least workers was found to be the US

-- past employees dept count
SELECT COUNT(employee_id) AS employee_count,
dept_name
FROM gold.dim_employee
WHERE current_flag = 'Past'
GROUP BY dept_name
ORDER BY employee_count DESC;
-- 2 employees left the purchasing department, and 1 each in the tool design, executive, marketing, production control department

-- top 5 earning household by children count
SELECT TOP 5 first_name,
last_name,
gender,
country,
SUM(total_children) AS total_kids
FROM gold.dim_customer
WHERE total_children > 0
GROUP BY first_name, last_name, gender, country
ORDER BY total_kids DESC;

-- the top 3 housholds were from the US with a total number of 8 kids in the top 2 households, and 7 in the 3rd household,
-- and while the bottom 2 were from Australia with a total number of 7 kids in the 4th household, and 6 in the 5th household

SELECT *
FROM gold.dim_customer;
-- home ownership by marital status
SELECT TOP 10 first_name,
last_name,
marital_status,
country,
SUM(house_owner_flag) AS house_owner
FROM gold.dim_customer
WHERE house_owner_flag > 0
GROUP BY first_name, last_name, marital_status, country
ORDER BY house_owner DESC;
-- it was observed that in all our branches around the world, married couples tend to have more than 1 houses, 
-- it was also observed that it's not very common for single workers to own more than 1 house

-- car ownership by comuting distance
SELECT commute_distance,
SUM(no_cars_owned) AS cars
FROM gold.dim_customer
GROUP BY commute_distance
ORDER BY cars DESC;

-- car ownership by state province
SELECT commute_distance,
state_prov_name,
SUM(no_cars_owned) AS cars
FROM gold.dim_customer
GROUP BY commute_distance, state_prov_name
ORDER BY cars DESC;
-- it was found that employees that worked at companies that were located in big cities, 
-- had to own cars to commute to work with the largest number of car ownrs being carlifornians with the total of 1581 cars

-- salary by province
SELECT TOP 10 first_name,
last_name,
gender,
country,
SUM(yearly_income) AS total_income
FROM gold.dim_customer
WHERE house_owner_flag = '1'
GROUP BY first_name, last_name, gender, country
ORDER BY total_income DESC;
-- women earned more than men with the top 1 being Julia Hall earning £220,000 in the UK

SELECT TOP 10 first_name,
last_name,
gender,
country,
SUM(yearly_income) AS total_income
FROM gold.dim_customer
WHERE house_owner_flag = '1'
GROUP BY first_name, last_name, gender, country
ORDER BY total_income ASC;
-- it was found that men earned lesser than women with the least earning male being Aaron Allen with a total income of $10,000 CAD

SELECT *
FROM gold.dim_customer;

-- top 10 reordered product
SELECT TOP 10 prdt_name,
COUNT(reorder_point) AS total_orders
FROM gold.dim_product
GROUP BY prdt_name
ORDER BY total_orders DESC;
-- all top 10 products had a total no of 3 reorders each

-- cost and list price by product name
SELECT  TOP 10 prdt_name,
SUM(standard_cost) AS total_cost,
SUM(list_price) AS total_price
FROM gold.dim_product
GROUP BY prdt_name
ORDER BY total_cost DESC, total_price DESC;