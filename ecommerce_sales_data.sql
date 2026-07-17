create database ecommerce;
use ecommerce;
CREATE TABLE orders(
    order_id VARCHAR(20) PRIMARY KEY,
    order_date DATE,
    customer_name VARCHAR(100),
    state VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE order_details (
    order_id VARCHAR(20) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    profit DECIMAL(10,2),
    quantity INT NOT NULL,
    category VARCHAR(50) NOT NULL,
    sub_category VARCHAR(50) NOT NULL,

    CONSTRAINT fk_order_details
    FOREIGN KEY (order_id)
    REFERENCES orders(order_id)
);

CREATE TABLE sales_target (
    month_of_order_date VARCHAR(20) NOT NULL,
    category VARCHAR(50) NOT NULL,
    target DECIMAL(12,2) NOT NULL
);

select * from sales_target;
select * from orders ;
select * from order_details;

-- OVERALL BUSSINESS PERFORMANCE
-- Total sales, total profit, aur total orders ?
-- Average order value (AOV) ?

select sum(amount) as total_sales ,
sum(profit ) as profit ,
count(order_id) as total_order ,
sum(quantity) as total_quantity from order_details;
-- 431502.00	23955.00	1500	5615

select round(sum(amount)/count(distinct order_id),2) as total from order_details; -- 863


-- * Which category generates the highest sales?

select category , sum(amount) as highest_sale from order_details 
group by category order by highest_sale desc limit 1;

-- highest sale generate is electronic

-- which category more profitable as gross margin

select category ,concat(round((sum(profit)/sum(amount))*100,2),'%')  as margin_profit from order_details
group by category order by margin_profit desc limit 1; -- clothing is more profitable in gross margin

-- which sub-category in loss
select sub_category , sum(profit) as total from order_details
group by sub_category having sum(profit) < 0 order by total asc; 

-- tables and electronics make a loss

-- Top 5 states kaunse hain sales ke hisaab se?

select orders.state , sum(order_details.amount) as total from orders
inner join order_details on order_details.order_id = orders.order_id
group by orders.state order by total desc limit 5 ;  

-- mp , up,delhi,maharasthra,rajasthan

select * from sales_target;
-- Whether each category achieved its monthly sales target
SELECT 
    od.category, 
    SUM(od.amount) AS actual_sales, 
    st.month_of_order_date, 
    st.target,
    CASE
        WHEN SUM(od.amount) >= st.target THEN 'Target Achieved'
        ELSE 'Target Not Achieved'
    END AS status
FROM order_details od
INNER JOIN sales_target st ON st.category = od.category
GROUP BY od.category, st.month_of_order_date, st.target;

-- Result: All categories achieved their monthly sales target

-- Month-wise sales trend  — which month is best aur worst?

-- Highest Sales Month
SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    SUM(od.amount) AS total_sales
FROM orders o
JOIN order_details od 
    ON o.order_id = od.order_id
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY total_sales DESC
LIMIT 1;

-- Lowest Sales Month
SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    SUM(od.amount) AS total_sales
FROM orders o
JOIN order_details od 
    ON o.order_id = od.order_id
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY total_sales ASC
LIMIT 1;

-- january make higest sale but july make lowest sale

-- who is top 5 customers which placed more orders?

select orders.customer_name , orders.order_id,count(order_details.quantity) as total
from orders inner join order_details on orders.order_id = order_details.order_id
group by orders.order_id order by total desc limit 5;

-- which categories is High sales but low profit (mismatch check)?

WITH category_summary AS (
    SELECT 
        category,
        SUM(amount) AS total_sales,
        SUM(profit) AS total_profit,
        ROUND((SUM(profit) / SUM(amount)) * 100, 2) AS profit_margin_percent
    FROM order_details 
    GROUP BY category
)
SELECT * 
FROM category_summary 
WHERE total_sales > (SELECT AVG(total_sales) FROM category_summary)
  AND profit_margin_percent < (SELECT AVG(profit_margin_percent) FROM category_summary)
ORDER BY total_sales DESC;
-- Result: Electronics has high sales volume but a comparatively low profit margin

-- which state give highest profit vs lowest profit?

select orders.state , sum(order_details.profit) as profit from orders 
 join order_details on order_details.order_id=orders.order_id
 group by orders.state order by profit desc limit 1; 
 
 select orders.state , sum(order_details.profit) as profit from orders 
 join order_details on order_details.order_id=orders.order_id
 group by orders.state order by profit ; 
 
--  maharastra give more profit and jammu kashmir has low profit




