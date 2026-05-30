CREATE TABLE bike_sales_india (
    sale_id INTEGER,
    sale_date DATE,
    city VARCHAR(50),
    state VARCHAR(50),
    brand VARCHAR(50),
    model VARCHAR(100),
    customer_age NUMERIC,
    gender VARCHAR(10),
    payment_mode VARCHAR(20),
    ex_showroom_price INTEGER,
    discount NUMERIC,
    final_price INTEGER,
    quantity INTEGER,
    revenue BIGINT
);

select*from bike_sales_india

COPY bike_sales_india (
    sale_id,
    sale_date,
    city,
    state,
    brand,
    model,
    customer_age,
    gender,
    payment_mode,
    ex_showroom_price,
    discount,
    final_price,
    quantity,
    revenue
)
FROM 'E:/cleaned_Bike_data.csv'
DELIMITER ','
CSV HEADER;

-- 1) Find Total Revenue in bike_sales_india ?

SELECT SUM(revenue) AS total_revenue
FROM bike_sales_india;

-- 2) Find revenue for all Brands & highest revenue brand ?

SELECT brand,
       SUM(revenue) AS revenue
FROM bike_sales_india
GROUP BY brand
ORDER BY revenue DESC;

-- 3) Find total bikes sold by city & the top selling city

SELECT city,
       SUM(quantity) AS bikes_sold
FROM bike_sales_india
GROUP BY city
ORDER BY bikes_sold DESC;

-- 4) Show only brands who has revenue > 50 million

SELECT brand,
       SUM(revenue) AS revenue
FROM bike_sales_india
GROUP BY brand
HAVING SUM(revenue) > 50000000;

-- 5) Rank Brands by their revenue ?

SELECT brand,
       SUM(revenue) AS revenue,
       DENSE_RANK() OVER(
           ORDER BY SUM(revenue) DESC
       ) AS rank_no
FROM bike_sales_india
GROUP BY brand;

-- 6) Show brand with fourth highest revenue ?

SELECT *
FROM (
    SELECT brand,
           SUM(revenue) AS revenue,
           DENSE_RANK() OVER(
               ORDER BY SUM(revenue) DESC
           ) AS rnk
    FROM bike_sales_india
    GROUP BY brand
) t
WHERE rnk = 4;

-- 7) find total sales by each & every payment method 

SELECT payment_mode,
       COUNT(*) AS total_sales
FROM bike_sales_india
GROUP BY payment_mode;