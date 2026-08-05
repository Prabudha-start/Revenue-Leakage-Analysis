/*==============================================================================
Advanced SQL Analysis
File: 07_advanced_sql.sql

Business Goal
-------------
Perform advanced business analysis using SQL to uncover
customer value, revenue concentration, and executive insights.

==============================================================================*/

.headers on
.mode box

/*==============================================================================
Query 1: Top Customers by Lifetime Revenue
==============================================================================*/

SELECT

    CustomerID,

    COUNT(DISTINCT Invoice) AS Orders,

    ROUND(SUM(Revenue),2) AS Lifetime_Revenue,

    ROUND(AVG(Revenue),2) AS Average_Sale

FROM online_retail

WHERE Invoice NOT LIKE 'C%'
  AND CustomerID <> ''

GROUP BY CustomerID

ORDER BY Lifetime_Revenue DESC

LIMIT 20;


/*==============================================================================
Query 2: Customer Revenue Contribution
==============================================================================*/

SELECT

    CustomerID,

    ROUND(SUM(Revenue),2) AS Revenue,

    ROUND(

        SUM(Revenue) * 100.0 /

        (
            SELECT SUM(Revenue)
            FROM online_retail
            WHERE Invoice NOT LIKE 'C%'
        ),

        2

    ) AS Revenue_Percentage

FROM online_retail

WHERE Invoice NOT LIKE 'C%'
  AND CustomerID <> ''

GROUP BY CustomerID

ORDER BY Revenue DESC

LIMIT 20;


/*==============================================================================
Query 3: Customer Spending Quartiles
==============================================================================*/

WITH CustomerSales AS (

    SELECT

        CustomerID,

        ROUND(SUM(Revenue),2) AS Total_Sales

    FROM online_retail

    WHERE Invoice NOT LIKE 'C%'
      AND CustomerID <> ''

    GROUP BY CustomerID

)

SELECT

    CustomerID,

    Total_Sales,

    NTILE(4) OVER (

        ORDER BY Total_Sales DESC

    ) AS Spending_Quartile

FROM CustomerSales

LIMIT 30;

/*==============================================================================
Query 4: Running Revenue
==============================================================================*/

WITH MonthlyRevenue AS (

    SELECT

        strftime('%Y-%m', InvoiceDate) AS Year_Month,

        ROUND(SUM(Revenue),2) AS Revenue

    FROM online_retail

    WHERE Invoice NOT LIKE 'C%'

    GROUP BY strftime('%Y-%m', InvoiceDate)

)

SELECT

    Year_Month,

    Revenue,

    ROUND(

        SUM(Revenue)

        OVER (

            ORDER BY Year_Month

        ),

        2

    ) AS Running_Revenue

FROM MonthlyRevenue;


/*==============================================================================
Query 5: Country Revenue Ranking
==============================================================================*/

SELECT

    Country,

    ROUND(SUM(Revenue),2) AS Revenue,

    RANK()

    OVER (

        ORDER BY SUM(Revenue) DESC

    ) AS Revenue_Rank

FROM online_retail

WHERE Invoice NOT LIKE 'C%'

GROUP BY Country

LIMIT 20;