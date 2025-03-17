--CREATING A NEW_TABLE
CREATE TABLE Chocolate_Sale_1
LIKE chocolate_sales;

--COPYING DATA_INTO THE NEW_TABLE
INSERT INTO Chocolate_Sale_1
SELECT*
FROM chocolate_sales;

--CHECKING THE NEW_TABLE
SELECT*
FROM chocolate_sales.chocolate_sale_1;

--FORMATTING DATES CORRECTLY
SELECT `Date`, STR_TO_DATE(`Date`, '%m/%d/%Y')
FROM chocolate_sales.chocolate_sale_1;

--UPDATING THE NEW_DATE FORMAT_INT0 THE NEW_TABLE
UPDATE chocolate_sales.chocolate_sale_1
SET `Date` = STR_TO_DATE(`Date`, '%m/%d/%Y');


ALTER TABLE chocolate_sales.chocolate_sale_1
MODIFY COLUMN `Date` DATE;

--TOTAL SALES REVENUE ANALYSIS
SELECT SUM(Amount) AS TOTAL_SALES_REVENUE
FROM chocolate_sales.chocolate_sale_1;

--TOP THREE SALES_PERSON ANALYSIS
SELECT `Sales Person`, SUM(Amount) AS TOTAL_SALES
FROM chocolate_sales.chocolate_sale_1
GROUP BY `Sales Person`
ORDER BY TOTAL_SALES DESC
LIMIT 3;

--COUNTRY_WISE SALES PERFORMANCE
SELECT Country, SUM(Amount) AS Country_Sales
FROM chocolate_sales.chocolate_sale_1
GROUP BY Country
ORDER BY Country_Sales DESC
LIMIT 5;

--PRODUCT_WISE SALES TRENDS
SELECT Product, SUM(Amount) AS Product_Sales
FROM chocolate_sales.chocolate_sale_1
GROUP BY Product
ORDER BY Product_Sales;

--MONTHLY SALES TREND
SELECT MONTH(`Date`) AS Sales_Month, SUM(Amount) AS Total_Sales
FROM chocolate_sales.chocolate_sale_1
GROUP BY Sales_Month
ORDER BY Total_Sales DESC
LIMIT 8;

--BOXES SHIPPED VS REVENUE CORRELATION
SELECT `Boxes Shipped`, Product, SUM(Amount) AS Total_Revenue
FROM chocolate_sales.chocolate_sale_1
GROUP BY `Boxes Shipped`, Product 
ORDER BY `Boxes Shipped` DESC
LIMIT 10;

--YEARLY GROWTH ANALYSIS
SELECT YEAR(`Date`) AS Sales_Year, SUM(Amount) AS Total_Sales
FROM chocolate_sales.chocolate_sale_1
GROUP BY Sales_Year
ORDER BY Total_Sales DESC;


--BOTTOM THREE SALES_PERSON ANALYSIS
SELECT `Sales Person`, SUM(Amount) AS TOTAL_SALES
FROM chocolate_sales.chocolate_sale_1
GROUP BY `Sales Person`
ORDER BY TOTAL_SALES
LIMIT 3;

--BOTTOM FIVE SELLING PRODUCTS
SELECT Product, SUM(Amount) AS Product_Sales
FROM chocolate_sales.chocolate_sale_1
GROUP BY Product
ORDER BY Product_Sales 
LIMIT 5;

--TOP FIVE SELLING PRODUCT
SELECT Product, SUM(Amount) AS Product_Sales
FROM chocolate_sales.chocolate_sale_1
GROUP BY Product
ORDER BY Product_Sales DESC
LIMIT 5;

--CUSTOMER DEMAND_BY_PRODUCT(COUNTRY_WISE)
SELECT Country, Product, SUM(Amount) AS Total_Sales
FROM chocolate_sales.chocolate_sale_1
GROUP BY Country, Product
ORDER BY Country,Total_Sales DESC
;

--SHIPPING EFFICIENCY ANALYSIS
SELECT `Boxes Shipped`, SUM(Amount) AS Total_Sales, SUM(Amount)/`Boxes Shipped` AS Revenue_Per_Box
FROM chocolate_sales.chocolate_sale_1
GROUP BY `Boxes Shipped`
ORDER BY Revenue_Per_Box;




