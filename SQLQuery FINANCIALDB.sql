USE FinancialDB
SELECT*FROM [dbo].[Financial$$]

SELECT *
FROM [dbo].[Financial$$]
WHERE "Segment" IS NULL
   OR "Country" IS NULL
   OR "Product" IS NULL
   OR "Discount Band" IS NULL
   OR "Manufacturing Price" IS NULL
   OR "Units Sold" IS NULL
   OR "Sale Price" IS NULL 
   OR "Gross Sales" IS NULL
   OR "Discounts" IS NULL
   OR "Sales" IS NULL
   OR "COGS" IS NULL
   OR "Profit" IS NULL
   OR "Date" IS NULL
   OR "Month Number" IS NULL
   OR "MONTH NAME" IS NULL
   OR "Year" IS NULL;

 --KPI measures:
 --Total Units Sold: Sum of the "Units Sold" column.
SELECT
    SUM("Units Sold") AS "Total Units Sold"
FROM 
    [dbo].[Financial$$];

--Total Gross Sales: Sum of the "Gross Sales" column.
SELECT
    SUM("Gross Sales") AS "Total Gross Sales"
FROM
   [dbo].[Financial$$];

--Total Discounts: Sum of the "Discounts" column.
SELECT
    SUM("Discounts") AS "Total Discounts"
FROM 
    [dbo].[Financial$$];

--Total Sales: Sum of the "Sales" column.
SELECT
    SUM("Sales") AS "Total Sales"
FROM 
    [dbo].[Financial$$];

--Total Cost of Goods Sold (COGS): Sum of the "COGS" column.
SELECT
    SUM("COGS") AS "Total COGS"
FROM 
    [dbo].[Financial$$];

--Total Profit: Sum of the "Profit" column.
SELECT
    SUM("Profit") AS "Total Profit"
FROM 
    [dbo].[Financial$$];

--What are the top-selling products in terms of gross sales?
SELECT TOP 5 Product, sum("Gross Sales") AS "Total Gross Sales"
FROM [dbo].[Financial$$]
GROUP BY "Product"
ORDER BY "Total Gross Sales" DESC; 
----What are the top-selling Country in terms of gross sales?
SELECT TOP 5 "Country", SUM("Gross Sales") AS "Total Gross Sales"
FROM [dbo].[Financial$$]
GROUP BY "Country"
ORDER BY "Total Gross Sales" DESC;


--Which country generates the highest total sales revenue?
SELECT TOP 5 "Country", SUM("Sales") AS "Total Sales Revenue"
FROM [dbo].[Financial$$]
GROUP BY "Country"
ORDER BY "Total Sales Revenue" DESC;
--- WHICH COUNTRY HAS MORE PROFIT
SELECT TOP 5 "Country", SUM("Profit") AS "Total Profit Revenue"
FROM [dbo].[Financial$$]
GROUP BY "Country"
ORDER BY "Total Profit Revenue" DESC;



---- How does the profit margin vary across different segments?
-- Assuming profit is calculated as (Sales - COGS)
SELECT "Segment", AVG(("Sales" - "COGS") / "Sales") AS "Average Profit Margin"
FROM [dbo].[Financial$$]
GROUP BY "Segment";

-- What is the average discount percentage for each discount band?
SELECT "Discount Band", AVG("Discounts" / "Gross Sales") AS "Average Discount Percentage"
FROM [dbo].[Financial$$]
GROUP BY "Discount Band";

---- Can you provide a breakdown of sales and profit by month and year?
SELECT "Year", "Month Name", SUM("Sales") AS "Total Sales", SUM("Profit") AS "Total Profit"
FROM [dbo].[Financial$$]
GROUP BY "Year", "Month Name"
ORDER BY "Year", "Month Name";

/*Which product has the highest profit margin? Is it consistent across different countries?
Are there any noticeable seasonal trends in sales or profit?*/
SELECT TOP 5 "Product", "Country", ("Sales" - "COGS") / "Sales" AS "Profit Margin"
FROM [dbo].[Financial$$]
ORDER BY "Profit Margin" DESC;

-- How do government, enterprise, and small business segments compare in terms of total sales?
SELECT "Segment", SUM("Sales") AS "Total Sales"
FROM [dbo].[Financial$$]
WHERE "Segment" IN ('Government', 'Enterprise', 'Small Business')
GROUP BY "Segment";

SELECT*FROM [dbo].[Financial$$]


-- Which country and segment combination has the highest average units sold per transaction?
SELECT  TOP 5 "Country", "Segment", AVG("Units Sold") AS "Average Units Sold per Transaction"
FROM [dbo].[Financial$$]
GROUP BY "Country", "Segment"
ORDER BY "Average Units Sold per Transaction" DESC


-- How do different discount bands affect the sales volume and profit?
SELECT "Discount Band", SUM("Units Sold") AS "Total Units Sold", SUM("Profit") AS "Total Profit"
FROM [dbo].[Financial$$]
GROUP BY "Discount Band";
--SQL query to find rows with negative profit from your dataset
SELECT *
FROM [dbo].[Financial$$]
WHERE Profit < 0;
--calculate the total of negative profit using a SQL query
SELECT SUM(Profit) AS TotalNegativeProfit
FROM [dbo].[Financial$$]
WHERE Profit < 0;
-- write a SQL query to find rows with negative profit in the month of April
SELECT *
FROM [dbo].[Financial$$]
WHERE Profit < 0 AND MONTH(Date) = 4;
--calculate the total of Positive profit using a SQL query
SELECT SUM(Profit) AS TotalPositiveProfit
FROM [dbo].[Financial$$]
WHERE Profit > 0;
--calculate the total negative profit for Wednesdays (weekday = "Wed") in a SQL query
SELECT SUM(Profit) AS TotalNegativeProfitWednesday
FROM [dbo].[Financial$$]
WHERE Profit < 0 AND DATEPART(WEEKDAY, Date) = 4;
--calculate the total negative profit for Tuesday (weekday = "Tue") in a SQL query

SELECT SUM(Profit) AS TotalNegativeProfittuesday
FROM [dbo].[Financial$$]
WHERE Profit < 0 AND DATEPART(WEEKDAY, Date) = 3;

--calculate the total negative profit for Monday (weekday = "Mon") in a SQL query
SELECT SUM(Profit) AS TotalNegativeProfitmonday
FROM [dbo].[Financial$$]
WHERE Profit < 0 AND DATEPART(WEEKDAY, Date) = 2;

----calculate the total negative profit for Thursday (weekday = "thu") in a SQL query
SELECT SUM(Profit) AS TotalNegativeProfitWednesday
FROM [dbo].[Financial$$]
WHERE Profit < 0 AND DATEPART(WEEKDAY, Date) = 5;


--1. Average Profit Margin Across All Products:
SELECT AVG(("Profit" / "Gross Sales") * 100) AS AvgProfitMargin
FROM [dbo].[Financial$$] ;

--2. Product with Highest Average Sales per Unit:


SELECT*FROM[dbo].[Financial$$]
SELECT TOP 5 Product, AVG("Sales" / "Units Sold") AS AvgSalesPerUnit
FROM [dbo].[Financial$$]
GROUP BY Product
ORDER BY AvgSalesPerUnit DESC;

--3. Country with Highest Total Sales and Profit:
SELECT  TOP 5 Country, SUM(Sales) AS TotalSales, SUM(Profit) AS TotalProfit
FROM [dbo].[Financial$$]
GROUP BY Country
ORDER BY TotalSales DESC, TotalProfit DESC;

--4. Seasonal Effect on Sales and Profit (Assuming seasons are represented by months):
SELECT "Month Name", SUM(Sales) AS TotalSales, SUM(Profit) AS TotalProfit
FROM [dbo].[Financial$$]
GROUP BY "Month Name"
ORDER BY TotalSales DESC, TotalProfit DESC;

--5. Relationship Between Discount Percentage and Sales:
SELECT "Discount Band", AVG(Sales) AS AvgSales
FROM [dbo].[Financial$$]
GROUP BY "Discount Band"
ORDER BY AvgSales DESC;

--6. Day of the Week with Highest Sales:
SELECT 
    DATENAME(WEEKDAY, [Date]) AS Weekday,
    SUM(Sales) AS TotalSales
FROM [dbo].[Financial$$]
GROUP BY DATENAME(WEEKDAY, [Date])
ORDER BY TotalSales DESC;

--7. Manufacturing Price's Effect on Profit Margin:
SELECT AVG((Profit / "Gross Sales") * 100) AS AvgProfitMargin
FROM [dbo].[Financial$$]
WHERE "Manufacturing Price" IS NOT NULL;

--8. Segment with Highest Total Sales and Profit:
SELECT TOP 5 Segment, SUM(Sales) AS TotalSales, SUM(Profit) AS TotalProfit
FROM [dbo].[Financial$$]
GROUP BY Segment
ORDER BY TotalSales DESC, TotalProfit DESC;

--9. Effect of Sale Price on Units Sold:
SELECT "Sale Price", AVG("Units Sold") AS AvgUnitsSold
FROM [dbo].[Financial$$]
GROUP BY "Sale Price"
ORDER BY AvgUnitsSold DESC;

--10. Quarter of the Year with Highest Sales and Profit:
SELECT
    DATEPART(QUARTER, [Date]) AS Quarter,
    SUM(Sales) AS TotalSales,
    SUM(Profit) AS TotalProfit
FROM [dbo].[Financial$$]
GROUP BY DATEPART(QUARTER, [Date])
ORDER BY TotalSales DESC, TotalProfit DESC;


--calculate the profit margin using SQL
SELECT SUM("Profit") / NULLIF(SUM("Gross Sales"), 0) AS ProfitMargin
FROM [dbo].[Financial$$];
--calculate the overall growth rate of sales and profit from one year to another using SQL
SELECT
    YEAR(Date) AS Year,
    SUM(Sales) AS TotalSales,
    SUM(Profit) AS TotalProfit,
    LAG(SUM(Sales)) OVER (ORDER BY YEAR(Date)) AS PreviousYearSales,
    LAG(SUM(Profit)) OVER (ORDER BY YEAR(Date)) AS PreviousYearProfit,
    CASE
        WHEN LAG(SUM(Sales)) OVER (ORDER BY YEAR(Date)) IS NULL THEN NULL
        ELSE ((SUM(Sales) - LAG(SUM(Sales)) OVER (ORDER BY YEAR(Date))) / LAG(SUM(Sales)) OVER (ORDER BY YEAR(Date))) * 100
    END AS SalesGrowthRate,
    CASE
        WHEN LAG(SUM(Profit)) OVER (ORDER BY YEAR(Date)) IS NULL THEN NULL
        ELSE ((SUM(Profit) - LAG(SUM(Profit)) OVER (ORDER BY YEAR(Date))) / LAG(SUM(Profit)) OVER (ORDER BY YEAR(Date))) * 100
    END AS ProfitGrowthRate
FROM [dbo].[Financial$$]
GROUP BY YEAR(Date)
ORDER BY Year;












