/*==============================================================================
PROJECT      : Revenue Leakage Analysis
FILE         : 02_sales_analysis.sql

DESCRIPTION
-----------
Sales performance analysis covering country-level performance and
monthly revenue trends.

==============================================================================*/


/*==============================================================================
QUERY 1
Sales by Country

Business Question
-----------------
Which countries generate the highest revenue?

Business Value
--------------
Identifies the company's strongest geographic markets by comparing
sales revenue, order volume, average order value, and highest order value.

NOTE
----
Order-level metrics are calculated from invoice totals rather than
individual transaction lines. This ensures Highest_Order_Value represents
the value of a complete order.
==============================================================================*/

.headers on
.mode box

WITH OrderTotals AS (

    SELECT
        Invoice,
        Country,
        SUM(Revenue) AS Order_Revenue

    FROM online_retail

    WHERE Invoice NOT LIKE 'C%'
      AND Country <> 'Country'
      AND TRIM(Country) <> ''

    GROUP BY
        Invoice,
        Country

)

SELECT
    Country,

    COUNT(DISTINCT Invoice) AS Orders,

    ROUND(
        SUM(Order_Revenue),
        2
    ) AS Total_Revenue,

    ROUND(
        SUM(Order_Revenue) * 1.0 /
        COUNT(DISTINCT Invoice),
        2
    ) AS Average_Order_Value,

    ROUND(
        MAX(Order_Revenue),
        2
    ) AS Highest_Order_Value

FROM OrderTotals

GROUP BY Country

ORDER BY Total_Revenue DESC;


/*==============================================================================
QUERY 2
Monthly Revenue Trend

Business Question
-----------------
How has monthly revenue changed over time?

Business Value
--------------
Measures month-over-month sales performance and identifies growth
or decline trends for executive reporting.
==============================================================================*/

WITH MonthlySales AS (

    SELECT
        "Year-Month",

        ROUND(
            SUM(Revenue),
            2
        ) AS Monthly_Revenue

    FROM online_retail

    WHERE Invoice NOT LIKE 'C%'
      AND "Year-Month" <> 'Year-Month'

    GROUP BY "Year-Month"

),

MonthlyComparison AS (

    SELECT
        "Year-Month",
        Monthly_Revenue,

        LAG(Monthly_Revenue) OVER (
            ORDER BY "Year-Month"
        ) AS Previous_Month_Revenue

    FROM MonthlySales

)

SELECT
    "Year-Month",

    Monthly_Revenue,

    Previous_Month_Revenue,

    ROUND(
        Monthly_Revenue - Previous_Month_Revenue,
        2
    ) AS Revenue_Change,

    ROUND(
        CASE
            WHEN Previous_Month_Revenue IS NULL
                 OR Previous_Month_Revenue = 0
            THEN NULL

            ELSE
                (
                    (Monthly_Revenue - Previous_Month_Revenue)
                    * 100.0
                ) /
                Previous_Month_Revenue
        END,
        2
    ) AS Growth_Percentage

FROM MonthlyComparison

ORDER BY "Year-Month";
