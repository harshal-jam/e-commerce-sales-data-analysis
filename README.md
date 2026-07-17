# E-commerce Sales Analysis (India) — SQL Project

## Objective
To analyze sales, profit, and target performance across product categories, regions, and time periods using SQL, and generate actionable business insights and recommendations.

## Dataset
The dataset consists of three relational tables based on Indian e-commerce order data:

- **orders** — order ID, order date, customer name, state, city
- **order_details** — order ID, amount, profit, quantity, category, sub-category
- **sales_target** — category, month, target amount

Dataset size: 1,500 orders | 5,615 units sold

## Tools Used
MySQL

## Project Workflow
1. Designed the relational schema and created tables with primary/foreign key relationships
2. Loaded and inspected the data for consistency
3. Defined key business questions
4. Wrote SQL queries to answer each question
5. Interpreted results into business insights and recommendations

## Key Business Questions Solved
1. What are the total sales, profit, orders, and average order value?
2. Which category generates the highest sales and profit margin?
3. Which sub-categories are operating at a loss?
4. Which states generate the highest sales and profit?
5. What is the monthly sales trend (best and worst months)?
6. Did each category achieve its monthly sales target?
7. Who are the top customers by order volume?
8. Which categories have high sales but low profit margins (mismatch analysis)?

## Key Insights
- Total Sales: ₹4,31,502 | Total Profit: ₹23,955 | Average Order Value: ₹863
- Electronics generates the highest sales but has a comparatively low profit margin
- Clothing has the highest profit margin among all categories
- Tables and certain Electronics sub-categories are operating at a loss
- Top 5 states by sales: Madhya Pradesh, Uttar Pradesh, Delhi, Maharashtra, Rajasthan
- Maharashtra delivers the highest profit; Jammu & Kashmir has the lowest
- January recorded the highest sales; July recorded the lowest
- All product categories achieved their assigned monthly sales targets

## Recommendation
The business should review its pricing and discounting strategy for Electronics, since high sales volume is not translating into proportional profit. Marketing investment could be increased in high-margin categories like Clothing, and strategies used in high-profit states like Maharashtra could be studied and applied to lower-performing regions.

## Files in this Repository
- `ecommerce_sales_analysis.sql` — All SQL queries used in the analysis
- `List_of_Orders.csv` — Order-level data
- `Order_Details.csv` — Order details data (amount, profit, category)
- `Sales_Target.csv` — Monthly sales targets by category

## Limitations
- Customer repeat-purchase behavior could not be fully analyzed due to limited historical data
- Target achievement was evaluated at an aggregate level and may not reflect month-by-month granularity for every category
