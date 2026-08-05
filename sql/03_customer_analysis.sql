/*==============================================================================
PROJECT      : Revenue Leakage Analysis
FILE         : 03_customer_analysis.sql

QUERY 1
Top Customers by Sales

Business Question
-----------------
Who are the company's highest-value customers?

Business Value
--------------
Identifies customers generating the highest revenue to support
customer retention, loyalty programs, and targeted marketing.

==============================================================================*/

.headers on
.mode box

SELECT

    CustomerID,

    COUNT(DISTINCT Invoice) AS Orders,

    ROUND(
        SUM(Revenue),
        2
    ) AS Total_Sales,

    ROUND(
        SUM(Revenue) * 1.0 /
        COUNT(DISTINCT Invoice),
        2
    ) AS Average_Order_Value,

   RANK() OVER (
    ORDER BY SUM(Revenue) DESC
) AS Customer_Revenue_Rank

FROM online_retail

WHERE Invoice NOT LIKE 'C%'
  AND CustomerID <> ''
  AND CustomerID <> 'Customer ID'

GROUP BY CustomerID

ORDER BY Customer_Revenue_Rank

LIMIT 15;


/*==============================================================================
QUERY 2
Customer Segmentation by Revenue

Business Question
-----------------
How can customers be grouped based on their total purchase value?

Business Value
--------------
Segments customers into business-friendly categories to support
marketing campaigns, loyalty programs, and retention strategies.

==============================================================================*/

.headers on
.mode box

WITH CustomerSales AS (

    SELECT
        CustomerID,
        ROUND(SUM(Revenue),2) AS Total_Sales
    FROM online_retail
    WHERE Invoice NOT LIKE 'C%'
      AND CustomerID <> ''
      AND CustomerID <> 'Customer ID'
    GROUP BY CustomerID

),

Segments AS (

    SELECT
        CustomerID,
        Total_Sales,

        CASE
            WHEN Total_Sales >= 100000 THEN 'Platinum'
            WHEN Total_Sales >= 50000 THEN 'Gold'
            WHEN Total_Sales >= 10000 THEN 'Silver'
            ELSE 'Bronze'
        END AS Customer_Segment

    FROM CustomerSales

)

SELECT

    Customer_Segment,
    COUNT(*) AS Customers,
    ROUND(AVG(Total_Sales),2) AS Avg_Sales

FROM Segments

GROUP BY Customer_Segment

ORDER BY Avg_Sales DESC;