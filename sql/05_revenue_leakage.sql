/*==============================================================================
Revenue Leakage Analysis
File: 05_revenue_leakage.sql

Business Goal
-------------
Analyze revenue lost due to customer returns and identify:
1. Countries with highest revenue leakage
2. Customers with highest returns
3. Products causing the greatest revenue loss
4. Executive KPI summary
==============================================================================*/

.headers on
.mode box

/*==============================================================================
Query 1: Revenue Leakage by Country
==============================================================================*/

SELECT

    Country,

    COUNT(DISTINCT Invoice) AS Return_Orders,

    ROUND(ABS(SUM(Revenue)), 2) AS Revenue_Lost,

    ROUND(AVG(ABS(Revenue)), 2) AS Avg_Return_Value,

    ROUND(MAX(ABS(Revenue)), 2) AS Largest_Return

FROM online_retail

WHERE Invoice LIKE 'C%'
  AND Country <> ''

GROUP BY Country

ORDER BY Revenue_Lost DESC

LIMIT 15;


/*==============================================================================
Query 2: Customers with Highest Revenue Leakage
==============================================================================*/

SELECT

    CustomerID,

    COUNT(DISTINCT Invoice) AS Returned_Orders,

    ROUND(ABS(SUM(Revenue)), 2) AS Revenue_Lost,

    ROUND(AVG(ABS(Revenue)), 2) AS Avg_Return_Value,

    ROUND(MAX(ABS(Revenue)), 2) AS Largest_Return

FROM online_retail

WHERE Invoice LIKE 'C%'
  AND CustomerID <> ''

GROUP BY CustomerID

ORDER BY Revenue_Lost DESC

LIMIT 15;


/*==============================================================================
Query 3: Products with Highest Revenue Leakage
==============================================================================*/

SELECT

    Description,

    COUNT(*) AS Returned_Items,

    ROUND(ABS(SUM(Revenue)), 2) AS Revenue_Lost,

    ROUND(AVG(ABS(Revenue)), 2) AS Avg_Return_Value,

    ROUND(MAX(ABS(Revenue)), 2) AS Largest_Return

FROM online_retail

WHERE Invoice LIKE 'C%'
  AND Description <> ''

GROUP BY Description

ORDER BY Revenue_Lost DESC

LIMIT 15;


/*==============================================================================
Query 4: Executive Revenue Leakage Summary
==============================================================================*/

SELECT

    ROUND(
        (
            SELECT SUM(Revenue)
            FROM online_retail
            WHERE Invoice NOT LIKE 'C%'
        ),
        2
    ) AS Total_Sales,

    ROUND(
        ABS(
            (
                SELECT SUM(Revenue)
                FROM online_retail
                WHERE Invoice LIKE 'C%'
            )
        ),
        2
    ) AS Revenue_Lost,

    ROUND(
        ABS(
            (
                SELECT SUM(Revenue)
                FROM online_retail
                WHERE Invoice LIKE 'C%'
            )
        ) * 100.0 /
        (
            SELECT SUM(Revenue)
            FROM online_retail
            WHERE Invoice NOT LIKE 'C%'
        ),
        2
    ) AS Revenue_Leakage_Percentage,

    (
        SELECT COUNT(DISTINCT Invoice)
        FROM online_retail
        WHERE Invoice NOT LIKE 'C%'
    ) AS Completed_Orders,

    (
        SELECT COUNT(DISTINCT Invoice)
        FROM online_retail
        WHERE Invoice LIKE 'C%'
    ) AS Returned_Orders,

    ROUND(
        (
            SELECT COUNT(DISTINCT Invoice)
            FROM online_retail
            WHERE Invoice LIKE 'C%'
        ) * 100.0 /
        (
            SELECT COUNT(DISTINCT Invoice)
            FROM online_retail
            WHERE Invoice NOT LIKE 'C%'
        ),
        2
    ) AS Return_Order_Percentage;