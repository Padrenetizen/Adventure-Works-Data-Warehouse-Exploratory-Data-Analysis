**Title**: Adventure Works Data Warehouse \& Exploratory Data Analysis

**Project Overview**: The aim of this project is to build a complete and fully  operational data warehouse.

**Architecture**: Bronze → Silver → Gold.

Tools: SQL Server 2022, SSMS, SQL, Notes, Draw.io.

\- Data sources: Adventure works datasets used includes;

1. dim\_account
2. dim\_currency
3. dim\_department\_group
4. dim\_geography
5. dim\_customer
6. dim\_date
7. dim\_employee
8. dim\_organization
9. dim\_product\_category
10. dim\_product
11. dim\_product\_subcategory
12. dim\_promotion.



ETL process:

Extraction Sample:

IF OBJECT\_ID ('bronze.dim\_product\_category', 'U') IS NOT NULL

&#x20;  DROP TABLE bronze.dim\_product\_category;

CREATE TABLE bronze.dim\_product\_category (

prdt\_cat\_key INT,

prdt\_cat\_alt\_key INT,

eng\_prdt\_cat\_name NVARCHAR(50),

spanish\_prdt\_cat\_name NVARCHAR(50),

french\_prdt\_cat\_name NVARCHAR(50),

);



PRINT '>> Inserting Data Into: bronze.dim\_product\_category';

SET @start\_time = GETDATE();

BULK INSERT bronze.dim\_product\_category

FROM "C:\\Users\\paulo\\Downloads\\adventureworks\\dim\_product\_category(in).csv"

WITH (FIRSTROW = 1,

FIELDTERMINATOR = '|',

TABLOCK,

CODEPAGE = '65001');

SET @end\_time = GETDATE();

&#x20;   PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start\_time, @end\_time) AS NVARCHAR) + 'seconds';

&#x20;   PRINT '---------------';



**Cleaned Sample:**

SELECT

employee\_key,

parent\_employee\_key,

employee\_natid\_alt\_key,

sales\_terr\_key,

first\_name,

last\_name,

title,

hire\_date,

birth\_date,

login\_id,

email\_address,

phone,

TRIM(emergency\_contact\_middle\_name),

emergency\_contact\_name,

emergency\_contact\_phone,

salaried\_flag,

CASE WHEN UPPER(TRIM(gender)) = 'F' THEN 'Female'

&#x20;    WHEN UPPER(TRIM(gender)) = 'M' THEN 'Male'

&#x20;    ELSE'n/a'

END AS gender,

ABS(pay\_freq),

ABS(base\_rate),

ABS(vacation\_hrs),

ABS(sick\_leave\_hrs),

CASE

&#x20;  WHEN end\_date IS NULL THEN 'Current'

&#x20;  ELSE 'Past'

END AS current\_flag,

sales\_person\_flag,

dept\_name,

start\_date

FROM bronze.dim\_employee;



**Data quality checks**

**T**he datasets used in the building of this warehouse contained a lot of duplicates, Null values, and invalid data types which made the entire  building process daunting, and time consuming. Also, referential integrity was ensured through out the building of this warehouse.



**Limitations**

The current Gold tables are reporting structures, and not a transactional fact tables because of their lack of transactional data to create these tables.

