/*==============================================================================
PROJECT      : Revenue Leakage Analysis

FILE         : 01_executive_kpis.sql

AUTHOR       : Prabudha Darabare

DESCRIPTION  :
Executive dashboard KPIs used for business performance reporting.

TABLE USED   :
online_retail

==============================================================================*/

.headers on
.mode box

WITH Sales AS (
    SELECT SUM(Revenue) AS Total_Sales
    FROM online_retail
    WHERE Invoice NOT LIKE 'C%'
),
Returns AS (
    SELECT ABS(SUM(Revenue)) AS Revenue_Lost
    FROM online_retail
    WHERE Invoice LIKE 'C%'
),
Customers AS (
    SELECT COUNT(DISTINCT CustomerID) AS Total_Customers
    FROM online_retail
    WHERE Invoice NOT LIKE 'C%'
      AND CustomerID <> ''
),
Orders AS (
    SELECT COUNT(DISTINCT Invoice) AS Total_Orders
    FROM online_retail
    WHERE Invoice NOT LIKE 'C%'
)

SELECT
    ROUND(Sales.Total_Sales, 2) AS Total_Sales,
    ROUND(Returns.Revenue_Lost, 2) AS Revenue_Lost,
    ROUND(Returns.Revenue_Lost * 100.0 / Sales.Total_Sales, 2) AS Revenue_Leakage_Percentage,
    Customers.Total_Customers,
    Orders.Total_Orders,
    ROUND(Sales.Total_Sales / Orders.Total_Orders, 2) AS Average_Order_Value
FROM Sales
CROSS JOIN Returns
CROSS JOIN Customers
CROSS JOIN Orders;