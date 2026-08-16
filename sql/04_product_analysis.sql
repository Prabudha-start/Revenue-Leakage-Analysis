/*==============================================================================
PROJECT      : Revenue Leakage Analysis
FILE         : 04_product_analysis.sql

DESCRIPTION
-----------
Product-level sales, revenue leakage, and return-rate analysis.

==============================================================================*/


/*==============================================================================
QUERY 1
Top Revenue Generating Products

Business Question
-----------------
Which products generate the highest revenue?

Business Value
--------------
Identifies the company's highest-revenue products to support
inventory planning, supplier management, and marketing decisions.

==============================================================================*/

.headers on
.mode box

SELECT
    TRIM(Description) AS Description,

    SUM(Quantity) AS Items_Sold,

    ROUND(
        SUM(Revenue),
        2
    ) AS Total_Revenue,

    ROUND(
        AVG(Revenue),
        2
    ) AS Avg_Sale_Value,

    ROUND(
        MAX(Revenue),
        2
    ) AS Highest_Sale

FROM online_retail

WHERE Invoice NOT LIKE 'C%'
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

ORDER BY Total_Revenue DESC

LIMIT 15;


/*==============================================================================
QUERY 2
Products Causing the Highest Revenue Leakage

Business Question
-----------------
Which products generate the greatest financial loss through returns?

Business Value
--------------
Helps identify products with potential quality issues, packaging problems,
supplier defects, or customer dissatisfaction.

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
QUERY 3
Products with the Highest Return Rate

Business Question
-----------------
Which products have the highest return rate relative to units sold?

Business Value
--------------
Identifies products that may have quality issues, misleading
descriptions, packaging problems, or supplier defects.

==============================================================================*/

WITH Sales AS (

    SELECT
        TRIM(Description) AS Description,

        SUM(Quantity) AS Sold_Items,

        SUM(Revenue) AS Sales

    FROM online_retail

    WHERE Invoice NOT LIKE 'C%'
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

),

Returns AS (

    SELECT
        TRIM(Description) AS Description,

        SUM(ABS(Quantity)) AS Returned_Items,

        ABS(SUM(Revenue)) AS Revenue_Lost

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

)

SELECT
    s.Description,

    s.Sold_Items,

    IFNULL(r.Returned_Items, 0) AS Returned_Items,

    ROUND(
        s.Sales,
        2
    ) AS Total_Revenue,

    ROUND(
        IFNULL(r.Revenue_Lost, 0),
        2
    ) AS Revenue_Lost,

    ROUND(
        IFNULL(r.Returned_Items, 0) * 100.0 /
        NULLIF(s.Sold_Items, 0),
        2
    ) AS Return_Rate

FROM Sales s

LEFT JOIN Returns r
    ON s.Description = r.Description

WHERE IFNULL(r.Returned_Items, 0) > 0

ORDER BY Revenue_Lost DESC

LIMIT 15;
