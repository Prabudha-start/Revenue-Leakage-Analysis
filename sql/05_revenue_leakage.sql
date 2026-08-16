/*==============================================================================
PROJECT      : Revenue Leakage Analysis
FILE         : 05_revenue_leakage.sql

BUSINESS GOAL
-------------
Analyze revenue lost through customer returns and identify:
1. Countries with the highest revenue leakage
2. Customers with the highest return-related revenue loss
3. Products causing the greatest revenue loss
4. Executive revenue leakage KPIs

==============================================================================*/

.headers on
.mode box


/*==============================================================================
QUERY 1
Revenue Leakage by Country

Business Question
-----------------
Which countries generate the greatest revenue loss through returns?

==============================================================================*/

SELECT
    TRIM(Country) AS Country,

    COUNT(DISTINCT Invoice) AS Return_Orders,

    ROUND(
        ABS(SUM(Revenue)),
        2
    ) AS Revenue_Lost,

    ROUND(
        ABS(AVG(Revenue)),
        2
    ) AS Avg_Return_Value,

    ROUND(
        MAX(ABS(Revenue)),
        2
    ) AS Largest_Return

FROM online_retail

WHERE Invoice LIKE 'C%'
  AND TRIM(Country) <> ''
  AND Country <> 'Country'

GROUP BY TRIM(Country)

ORDER BY Revenue_Lost DESC

LIMIT 15;


/*==============================================================================
QUERY 2
Customers with Highest Revenue Leakage

Business Question
-----------------
Which customers generate the greatest return-related revenue loss?

==============================================================================*/

SELECT
    CustomerID,

    COUNT(DISTINCT Invoice) AS Returned_Orders,

    ROUND(
        ABS(SUM(Revenue)),
        2
    ) AS Revenue_Lost,

    ROUND(
        ABS(AVG(Revenue)),
        2
    ) AS Avg_Return_Value,

    ROUND(
        MAX(ABS(Revenue)),
        2
    ) AS Largest_Return

FROM online_retail

WHERE Invoice LIKE 'C%'
  AND CustomerID IS NOT NULL

GROUP BY CustomerID

ORDER BY Revenue_Lost DESC

LIMIT 15;


/*==============================================================================
QUERY 3
Products with Highest Revenue Leakage

Business Question
-----------------
Which products generate the greatest financial loss through returns?

==============================================================================*/

SELECT
    TRIM(Description) AS Description,

    SUM(ABS(Quantity)) AS Returned_Items,

    ROUND(
        ABS(SUM(Revenue)),
        2
    ) AS Revenue_Lost,

    ROUND(
        ABS(AVG(Revenue)),
        2
    ) AS Avg_Return_Value,

    ROUND(
        MAX(ABS(Revenue)),
        2
    ) AS Largest_Return

FROM online_retail

WHERE Invoice LIKE 'C%'
  AND TRIM(Description) <> ''
  AND UPPER(TRIM(Description)) NOT IN (
        'MANUAL',
        'POSTAGE',
        'DOTCOM POSTAGE',
        'BANK CHARGES',
        'AMAZON FEE',
        'DISCOUNT',
        'CRUK COMMISSION',
        'SAMPLES'
    )

GROUP BY TRIM(Description)

ORDER BY Revenue_Lost DESC

LIMIT 15;


/*==============================================================================
QUERY 4
Executive Revenue Leakage Summary

Business Question
-----------------
What is the overall financial impact of customer returns?

==============================================================================*/

WITH Sales AS (

    SELECT
        SUM(Revenue) AS Total_Sales,
        COUNT(DISTINCT Invoice) AS Completed_Orders

    FROM online_retail

    WHERE Invoice NOT LIKE 'C%'

),

Returns AS (

    SELECT
        ABS(SUM(Revenue)) AS Revenue_Lost,
        COUNT(DISTINCT Invoice) AS Returned_Orders

    FROM online_retail

    WHERE Invoice LIKE 'C%'

)

SELECT
    ROUND(
        Sales.Total_Sales,
        2
    ) AS Total_Sales,

    ROUND(
        Returns.Revenue_Lost,
        2
    ) AS Revenue_Lost,

    ROUND(
        Returns.Revenue_Lost * 100.0 /
        NULLIF(Sales.Total_Sales, 0),
        2
    ) AS Revenue_Leakage_Percentage,

    Sales.Completed_Orders,

    Returns.Returned_Orders,

    ROUND(
        Returns.Returned_Orders * 100.0 /
        NULLIF(Sales.Completed_Orders, 0),
        2
    ) AS Return_Order_Percentage

FROM Sales
CROSS JOIN Returns;
