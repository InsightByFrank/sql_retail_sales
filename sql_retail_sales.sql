-- 1. Start fresh (removes the old incomplete data)
DROP DATABASE IF EXISTS `Retail_table`;
CREATE DATABASE `Retail_table`;
USE `Retail_table`;

CREATE TABLE Retail (
    transactions_id INT,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(25),
    quantiy INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale INT
);

-- 2. Allow MySQL to read a file from your computer (one-time per session)
SET GLOBAL local_infile = 1;

-- 3. Import the CSV properly, keeping blank cells as NULL instead of dropping rows
LOAD DATA LOCAL INFILE 'C:/Users/BLESSETH/Downloads/SQL - Retail Sales Analysis_utf .csv'
INTO TABLE Retail
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@transactions_id, @sale_date, @sale_time, @customer_id, @gender, @age,
 @category, @quantiy, @price_per_unit, @cogs, @total_sale)
SET
  transactions_id = NULLIF(@transactions_id, ''),
  sale_date       = NULLIF(@sale_date, ''),
  sale_time       = NULLIF(@sale_time, ''),
  customer_id     = NULLIF(@customer_id, ''),
  gender          = NULLIF(@gender, ''),
  age             = NULLIF(@age, ''),
  category        = NULLIF(@category, ''),
  quantiy         = NULLIF(@quantiy, ''),
  price_per_unit  = NULLIF(@price_per_unit, ''),
  cogs            = NULLIF(@cogs, ''),
  total_sale      = NULLIF(@total_sale, '');

-- CHECKING FOR NULL VALUES
SELECT *
FROM Retail
WHERE 
	tranSactions_id IS NULL
    OR
    sale_date IS NULL 
    OR 
    sale_time IS NULL
    OR
    customer_id IS NULL
    OR
    gender IS NULL
	OR 
    category IS NULL 
    OR
    quantiy IS NULL
    OR
    price_per_unit IS  NULL
    OR 
    cogs IS NULL
    OR 
    total_sale IS NULL;

DELETE 
FROM retail_table.retail
WHERE 
	tranSactions_id IS NULL
    OR
    sale_date IS NULL 
    OR 
    sale_time IS NULL
    OR
    customer_id IS NULL
    OR
    gender IS NULL
	OR 
    category IS NULL 
    OR
    quantiy IS NULL
    OR
    price_per_unit IS  NULL
    OR 
    cogs IS NULL
    OR 
    total_sale IS NULL;
    
SELECT COUNT(*) AS Total_No
FROM retail_table.retail;

-- Data Exploration

-- How many sales do we have 
 Select COUNT(*) AS Total_Sales
FROM retail_table.retail;

-- How many unique customers do we have
 Select COUNT(DISTINCT(customer_id)) AS Total_Customers
FROM retail_table.retail;

-- Data Analysis, Business Question and Answers

-- Write an sql query to retrive all column from the year 2022-11-05
SELECT * 
FROM retail_table.retail
WHERE sale_date = '2022-11-05';

-- Write an sql query to retrieve all transaction where category is 'Clothing' and the quantity sold more than 10 in the month of Nov-2022
SELECT *
FROM retail_table.retail
WHERE 
    category = 'Clothing'
    AND
    sale_date >= '2022-11-01' AND sale_date < '2022-12-01'
    AND
    quantiy >= 4;

-- Write an sql query to calculate the sales for each category 
SELECT category, sum(total_sale) as Total_Sales, count(*) as Total_Orders
FROM retail_table.retail
GROUP BY category
ORDER BY Total_Sales Desc;

-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
SELECT ROUND(Avg(age),2) as Avg_Age
FROM retail_table.retail
WHERE category = 'Beauty';

-- Write a SQL query to find all transactions where the total_sale is greater than 1000.:
SELECT *
FROM retail_table.retail
where total_sale > 1000;

-- Write a SQL query to find the total number 	of transactions (transaction_id) made by each gender in each category.:
SELECT gender, category, count(*) as Total_Transactions
FROM retail_table.retail
GROUP BY gender, category
ORDER BY gender ASC;

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT * FROM
(SELECT
	YEAR(sale_date) as Years,
    month(sale_date) as Months,
    AVG(total_sale) as Avg_Total_Sales,
    RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS Ranks
FROM retail_table.retail
GROUP BY Years, Months) AS t1
WHERE ranks = 1;
-- Write a SQL query to find the top 5 customers based on the highest total sales:
SELECT 
	customer_id,
	sum(total_sale) as Total_Sales
FROM retail_table.retail
GROUP BY customer_id
ORDER BY Total_Sales Desc
LIMIT 5 ;


-- Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_table.retail
GROUP BY category;

-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_table.Retail
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift;
    


