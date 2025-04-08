---Retrieve All Drinks Shipped to the USA with More Than 500 Boxes--
SELECT Country, Boxes_Shipped
FROM drinks_dataset_updated
WHERE Country = 'USA' AND Boxes_Shipped > 500
ORDER BY Boxes_Shipped;

---Count Total Number of Customers--
SELECT COUNT(Customer_ID)
FROM drinks_dataset_updated;

---Retrieve Drinks Shipped by Employee 'John'--
SELECT Male_Employee_Name,Drink_Name,Boxes_Shipped
FROM drinks_dataset_updated
WHERE Male_Employee_Name = 'John'
ORDER BY Boxes_Shipped;

---Retrieve Customers from UK Aged Between 25 and 40--
SELECT Country,Customer_Age
FROM drinks_dataset_updated
WHERE Country ='UK' AND Customer_Age BETWEEN 25 AND 40
ORDER BY Customer_Age;

---Retrieve Distinct Customer Genders--
SELECT DISTINCT(Customer_Gender)
FROM drinks_dataset_updated;

---Retrieve Drinks with More Than 5 Employees Involved--
SELECT Drink_Name, Boxes_Shipped,Employees_Involved
FROM drinks_dataset_updated
WHERE Employees_Involved > 5
ORDER BY Boxes_Shipped DESC;

---Retrieve Drinks Sold in Toronto, Canada--
SELECT Drink_Name,Country, Customer_Location
FROM drinks_dataset_updated
WHERE Country = 'Canada' AND Customer_Location = 'Toronto'
ORDER BY Drink_Name;

---Retrieve Records of 'Coca Cola 1' Sold in Germany--
SELECT Drink_Name,Boxes_Shipped,Country
FROM drinks_dataset_updated
WHERE Drink_Name = 'Coca Cola 1' and Country = 'Germany';

--- Update Boxes Shipped for 'Coca Cola 1' in Germany to 1500--
UPDATE drinks_dataset_updated
SET Boxes_Shipped = 1500
WHERE Drink_Name = 'Coca Cola 1' and Country = 'Germany';

---Retrieve Drinks Shipped to Australia with Boxes Less Than or Equal to 200--
SELECT Country, Boxes_Shipped
FROM drinks_dataset_updated
WHERE Country = 'Australia' and Boxes_Shipped <= 200
ORDER BY Boxes_Shipped;

---Retrieve Average Boxes Shipped per Country--
SELECT Country, AVG(Boxes_Shipped) AS Average_Boxes_Per_Country
FROM drinks_dataset_updated
GROUP BY Country;

---Count Number of Drinks Per Customer Location--
SELECT Customer_Location, 
COUNT(DISTINCT Drink_Name) AS Total_Drinks
FROM drinks_dataset_updated
GROUP BY Customer_Location;

---Retrieve Top 5 Drinks with Highest Boxes Shipped--
SELECT  Drink_Name, Boxes_Shipped
FROM drinks_dataset_updated
GROUP BY Drink_Name, Boxes_Shipped
ORDER BY Boxes_Shipped DESC
LIMIT 5;

---Retrieve Drinks Shipped Above 500 Boxes--
SELECT Drink_Name,Boxes_Shipped,Country, Customer_Age, Customer_Gender
FROM drinks_dataset_updated
WHERE Boxes_Shipped > 500
ORDER BY Boxes_Shipped DESC;

---CREATE PROCEDURE Search_Drinks_By_Location--
DROP PROCEDURE IF EXISTS Search_Drinks_By_Location;
DELIMITER $$
CREATE PROCEDURE Search_Drinks_By_Location()
BEGIN
    SELECT Drink_Name, Customer_Location
    FROM drinks_dataset_updated
    WHERE Customer_Location = 'Canada';
END$$
DELIMITER ;

---CREATE A VIEW showing drink name, country, customer age, and gender where boxes shipped > 500--
CREATE VIEW High_Shipped_Drinks AS
SELECT Drink_Name, 
       Country, 
       Customer_Age, 
       Customer_Gender
FROM drinks_dataset_updated
WHERE Boxes_Shipped > 500;

--Check Created View --
SELECT * FROM High_Shipped_Drinks;
