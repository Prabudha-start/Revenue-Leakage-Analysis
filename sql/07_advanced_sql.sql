/*==============================================================================
PROJECT      : Revenue Leakage Analysis
FILE         : 07_advanced_sql.sql

BUSINESS GOAL
-------------
Perform advanced business analysis using SQL to uncover customer value,
revenue concentration, spending distribution, cumulative revenue, and
geographic performance.

==============================================================================*/

.headers on
.mode box


/*==============================================================================
QUERY 1
Top Customers by Lifetime Revenue

Business Question
-----------------
Which customers generate the highest lifetime revenue?

==============================================================================*/

SELECT
    CustomerID,

    COUNT(DISTINCT Invoice) AS Orders,

    ROUND(
        SUM(Revenue),
        2
    ) AS Lifetime_Revenue,

    ROUND(
        SUM(Revenue) * 1.0 /
        COUNT(DISTINCT Invoice),
        2
    ) AS Average_Order_Value

FROM online_retail

WHERE Invoice NOT LIKE 'C%'
  AND CustomerID IS NOT NULL

GROUP BY CustomerID

ORDER BY Lifetime_Revenue DESC

LIMIT 20;


/*==============================================================================
QUERY 2
Customer Revenue Contribution

Business Question
-----------------
How much of total sales revenue is contributed by each customer?

==============================================================================*/

SELECT
    CustomerID,

    ROUND(
        SUM(Revenue),
        2
    ) AS Revenue,

    ROUND(
        SUM(Revenue) * 100.0 /
        NULLIF(
            (
                SELECT SUM(Revenue)
                FROM online_retail
                WHERE Invoice NOT LIKE 'C%'
            ),
            0
        ),
        2
    ) AS Revenue_Percentage

FROM online_retail

WHERE Invoice NOT LIKE 'C%'
  AND CustomerID IS NOT NULL

GROUP BY CustomerID

ORDER BY Revenue DESC

LIMIT 20;


/*==============================================================================
QUERY 3
Customer Spending Quartiles

Business Question
-----------------
How are customers distributed by lifetime spending?

==============================================================================*/

WITH CustomerSales AS (

    SELECT
        CustomerID,

        SUM(Revenue) AS Total_Sales

    FROM online_retail

    WHERE Invoice NOT LIKE 'C%'
      AND CustomerID IS NOT NULL

    GROUP BY CustomerID

),

CustomerQuartiles AS (

    SELECT
        CustomerID,

        ROUND(
            Total_Sales,
            2
        ) AS Total_Sales,

        NTILE(4) OVER (
            ORDER BY Total_Sales DESC
        ) AS Spending_Quartile

    FROM CustomerSales

)

SELECT
    CustomerID,
    Total_Sales,
    Spending_Quartile

FROM CustomerQuartiles

ORDER BY Spending_Quartile, Total_Sales DESC;


/*==============================================================================
QUERY 4
Running Revenue

Business Question
-----------------
How does cumulative revenue build over the analysis period?

==============================================================================*/

WITH MonthlyRevenue AS (

    SELECT
        strftime('%Y-%m', InvoiceDate) AS Year_Month,

        SUM(Revenue) AS Revenue

    FROM online_retail

    WHERE Invoice NOT LIKE 'C%'
      AND InvoiceDate IS NOT NULL
      AND InvoiceDate <> ''

    GROUP BY strftime('%Y-%m', InvoiceDate)

)

SELECT
    Year_Month,

    ROUND(
        Revenue,
        2
    ) AS Revenue,

    ROUND(
        SUM(Revenue) OVER (
            ORDER BY Year_Month
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ),
        2
    ) AS Running_Revenue

FROM MonthlyRevenue

ORDER BY Year_Month;


/*==============================================================================
QUERY 5
Country Revenue Ranking

Business Question
-----------------
Which countries generate the highest sales revenue?

==============================================================================*/

SELECT
    TRIM(Country) AS Country,

    ROUND(
        SUM(Revenue),
        2
    ) AS Revenue,

    RANK() OVER (
        ORDER BY SUM(Revenue) DESC
    ) AS Revenue_Rank

FROM online_retail

WHERE Invoice NOT LIKE 'C%'
  AND TRIM(Country) <> ''
  AND Country <> 'Country'

GROUP BY TRIM(Country)

ORDER BY Revenue_Rank

LIMIT 20;
