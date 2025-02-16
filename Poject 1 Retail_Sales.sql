-- Create TABLE 
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
	(
		transactions_id INT PRIMARY KEY,
		sale_date DATE,
		sale_time TIME,
		customer_id INT,
		gender VARCHAR(15),
		age INT,
		category VARCHAR(15),
		quantiy INT,
		price_per_unit FLOAT,
		cogs FLOAT,
		total_sale FLOAT
	)
SELECT * FROM retail_sales

SELECT count(*) FROM retail_sales

--Data Cleaning
SELECT * FROM retail_sales 
WHERE 
	transactions_id IS NULL
	OR 
	sale_date IS NULL
	OR
	sale_time IS NULL 
	OR
	customer_id IS NULL 
	OR
	gender IS NULL 
	OR
	age IS NULL 
	OR
	category IS NULL 
	OR
	quantiy IS NULL 
	OR
	price_per_unit IS NULL 
	OR
	cogs IS NULL 
	OR
	total_sale IS NULL;

DELETE FROM retail_sales 
WHERE 
	transactions_id IS NULL
	OR 
	sale_date IS NULL
	OR
	sale_time IS NULL 
	OR
	customer_id IS NULL 
	OR
	gender IS NULL 
	OR
	age IS NULL 
	OR
	category IS NULL 
	OR
	quantiy IS NULL 
	OR
	price_per_unit IS NULL 
	OR
	cogs IS NULL 
	OR
	total_sale IS NULL;

--Data Exploration

--How many sales we have? 
SELECT COUNT(*) AS Total_Sales 
FROM retail_sales

--How many customer we have?
SELECT COUNT(DISTINCT(customer_id)) AS Total_customer 
FROM retail_sales 

SELECT DISTINCT category FROm retail_sales

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT * FROM retail_sales 
WHERE sale_date = '2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than or equal to 4 in the month of Nov-2022

SELECT * FROM retail_sales
WHERE category = 'Clothing' 
AND TO_CHAR(sale_date,'YYYY-MM') = '2022-11' 
AND quantiy >= 4

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT category,sum(total_sale) AS Toatal_sales 
FROM retail_sales 
GROUP BY category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT round(avg(age),2) AS Average_age,category
FROM retail_sales 
WHERE category = 'Beauty'
GROUP BY category

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * FROM retail_sales 
WHERE total_sale > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT count(transactions_id) As total_transactions,gender,category 
FROM retail_sales 
GROUP BY gender,category

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT round(avg(total_sale)::numeric,2) AS Average_sale,EXTRACT(month FROM sale_date) AS month
FROM retail_sales 
GROUP BY month
ORDER BY 1 DESC limit 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT customer_id,SUM(total_sale) AS Total_sale
FROM retail_sales 
GROUP BY customer_id
ORDER BY total_sale DESC limit 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT count(DISTINCT(customer_id)) AS Customer_ID,category 
FROM retail_sales 
GROUP BY category

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

SELECT 
    COUNT(transactions_id) AS total_transactions,
    CASE 
        WHEN DATE_PART('hour', sale_time) < 12 THEN 'Morning'
        WHEN DATE_PART('hour', sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day
FROM retail_sales
GROUP BY time_of_day
ORDER BY total_transactions DESC;

--END OF PROJECT


