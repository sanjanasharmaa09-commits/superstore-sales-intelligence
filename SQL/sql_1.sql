-- ==========================================
-- Superstore Sales Analysis Project
-- Author: Sanjana
-- ==========================================

-- Create and use database
USE sales_db;

-- Check available tables
SHOW TABLES;

-- Verify data imported successfully
SELECT COUNT(*) AS Total_Rows
FROM superstore_clean;

-- ==========================================
-- 1. Overall Business KPIs
-- ==========================================

SELECT
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(Profit),2) AS Total_Profit,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    COUNT(DISTINCT Customer_ID) AS Total_Customers,
    ROUND(AVG(Profit_Margin),2) AS Avg_Profit_Margin
FROM superstore_clean;

-- ==========================================
-- 2. Top 10 Products by Profit
-- ==========================================

SELECT
    Product_Name,
    ROUND(SUM(Profit),2) AS Total_Profit,
    ROUND(SUM(Sales),2) AS Total_Sales,
    COUNT(*) AS Order_Count
FROM superstore_clean
GROUP BY Product_Name
ORDER BY Total_Profit DESC
LIMIT 10;

-- ==========================================
-- 3. Monthly Sales & Profit Trend
-- ==========================================

SELECT
    CONCAT(Order_Year,'-',LPAD(Order_Month,2,'0')) AS Month,
    ROUND(SUM(Sales),2) AS Monthly_Revenue,
    ROUND(SUM(Profit),2) AS Monthly_Profit
FROM superstore_clean
GROUP BY Order_Year, Order_Month
ORDER BY Order_Year, Order_Month;

-- ==========================================
-- 4. Discount Impact Analysis
-- ==========================================

SELECT
    CASE
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount <= 0.20 THEN 'Low (1-20%)'
        WHEN Discount <= 0.40 THEN 'Medium (21-40%)'
        ELSE 'High (>40%)'
    END AS Discount_Level,

    COUNT(*) AS Order_Count,
    ROUND(AVG(Profit),2) AS Avg_Profit,
    ROUND(SUM(Profit),2) AS Total_Profit

FROM superstore_clean
GROUP BY Discount_Level
ORDER BY Avg_Profit DESC;

-- ==========================================
-- 5. Loss Making States
-- ==========================================

SELECT
    State,
    Region,
    ROUND(SUM(Profit),2) AS Total_Profit,
    ROUND(SUM(Sales),2) AS Total_Sales,
    COUNT(*) AS Orders
FROM superstore_clean
GROUP BY State, Region
HAVING SUM(Profit) < 0
ORDER BY Total_Profit ASC;

-- ==========================================
-- 6. Top Customers by Revenue
-- ==========================================

SELECT
    Customer_Name,
    Segment,
    ROUND(SUM(Sales),2) AS Total_Revenue,
    ROUND(SUM(Profit),2) AS Total_Profit,
    COUNT(DISTINCT Order_ID) AS Num_Orders
FROM superstore_clean
GROUP BY Customer_Name, Segment
ORDER BY Total_Revenue DESC
LIMIT 10;

-- ==========================================
-- 7. Shipping Performance Analysis
-- ==========================================

SELECT
    Ship_Mode,
    ROUND(AVG(Shipping_Days),1) AS Avg_Ship_Days,
    ROUND(SUM(Profit),2) AS Total_Profit,
    COUNT(*) AS Orders
FROM superstore_clean
GROUP BY Ship_Mode
ORDER BY Avg_Ship_Days;

-- ==========================================
-- 8. Category & Sub-Category Analysis
-- ==========================================

SELECT
    Category,
    `Sub-Category`,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(Profit),2) AS Total_Profit,
    ROUND(AVG(Profit_Margin),2) AS Avg_Margin_Pct
FROM superstore_clean
GROUP BY Category, `Sub-Category`
ORDER BY Total_Profit DESC; 

-- ==========================================
-- 9. Top 5 States by Sales
-- ==========================================

SELECT
    State,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM superstore_clean
GROUP BY State
ORDER BY Total_Sales DESC
LIMIT 5;

-- ==========================================
-- 10. Regional Performance Analysis
-- ==========================================

SELECT
    Region,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(Profit),2) AS Total_Profit,
    COUNT(*) AS Orders
FROM superstore_clean
GROUP BY Region
ORDER BY Total_Profit DESC;

-- ==========================================
-- 11. Most Profitable Categories
-- ==========================================

SELECT
    Category,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(Profit),2) AS Total_Profit
FROM superstore_clean
GROUP BY Category
ORDER BY Total_Profit DESC;

-- ==========================================
-- 12. Top 10 Most Profitable Orders
-- ==========================================

SELECT
    Order_ID,
    Customer_Name,
    ROUND(Sales,2) AS Sales,
    ROUND(Profit,2) AS Profit
FROM superstore_clean
ORDER BY Profit DESC
LIMIT 10;
DESCRIBE superstore_clean;
-- ==========================================
-- End of Project
-- ==========================================
