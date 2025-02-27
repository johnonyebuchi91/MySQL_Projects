--CREATE TABLE PAKS_AND_RECORDS
--(EMPLOYEE_ID int,
--First_Name varchar (50),
--Last_Name varchar (50),
--Age int,
--DOB varchar (50),
--Gender varchar (50),
--)

--INSERT INTO PAKS_AND_RECORDS(EMPLOYEE_ID,First_Name,Last_Name,Age,DOB,Gender)VALUES
--(1001, 'James', 'Gunn', 50, 'September_24th', 'Male'),
--(1002,'Peter', 'Sutherland', 45,  'July_15th', 'Male'),
--(1003, 'Rose', 'Hawkins', 35, 'April_12th', 'Female'),
--(1004, NULL, 'Jackson', 30, 'October_28th', 'Female'),
--(1005, 'Marcus', NULL, 28, 'February_5th', 'Male'),
--(1006, 'Slyvia', 'Nelson', 25, NULL, 'Female'),
--(1007, 'Precious', 'Ederson', 20, 'May_29th', 'Female'),
--(1008, 'John', 'Onyebuchi', 23, 'April_28th', NULL);

--CREATE TABLE SALARY_OF_PAKS_N_RECORDS
--(Employee_ID int,
--Job_Title varchar (50),
--References_No int,
--Salary int
--);

--INSERT INTO SALARY_OF_PAKS_N_RECORDS (Employee_ID, Job_Title, References_No, Salary) VALUES
--(1001, 'Accountant', 45634425, 30000),
--(1002, 'Sales_Manager', 76859436, 45000),
--(1003, 'Distributor', 78542789, 60000),
--(1004, 'Saleswoman', 09843674, 35000),
--(1005, 'HR', 76425349, 70000),
--(1006, 'Secretary', 324156489, 40000),
--(1007, 'Handler', 65341892, 45000),
--(1008, 'General Supervisor', 76532214, 70000);

--SELECT DISTINCT First_Name, Last_Name, Gender
--FROM PAKS_AND_RECORDS
--WHERE First_Name <> 'John'
--AND Gender = 'Male'
--;

--SELECT*
--FROM PAKS_AND_RECORDS
--WHERE Last_Name LIKE '%ack%'
--OR Gender <> 'male'
--;

--SELECT Gender, Age, Last_Name
--FROM PAKS_AND_RECORDS
--GROUP BY Gender, Age, Last_Name
--HAVING Age <= 35

--SELECT*
--FROM [JOHN SQL TUTORIAL].DBO.PAKS_AND_RECORDS
--INNER JOIN [JOHN SQL TUTORIAL].DBO.SALARY_OF_PAKS_N_RECORDS
--	ON PAKS_AND_RECORDS.EMPLOYEE_ID = SALARY_OF_PAKS_N_RECORDS.Employee_ID

--SELECT*
--FROM [JOHN SQL TUTORIAL].dbo.PAKS_AND_RECORDS
--RIGHT OUTER JOIN [JOHN SQL TUTORIAL].dbo.SALARY_OF_PAKS_N_RECORDS
--	ON PAKS_AND_RECORDS.EMPLOYEE_ID = SALARY_OF_PAKS_N_RECORDS.Employee_ID

--SELECT Empolyee_ID, Job_Title, Salary
--FROM [JOHN SQL TUTORIAL].dbo.Employee_Salary
--UNION
--SELECT Employee_ID,Job_Title,Salary
--FROM [JOHN SQL TUTORIAL].dbo.SALARY_OF_PAKS_N_RECORDS
--ORDER BY Empolyee_ID 

--SELECT First_Name,Last_Name,Gender,Age,
--CASE 
--	WHEN Age <= 30 THEN 'YOUNG'
--	WHEN Age BETWEEN 31 AND 39 THEN 'OLD'
--	WHEN Age >= 40 THEN 'ELDERLY'
--END AS Age_Bracket
--FROM [JOHN SQL TUTORIAL].dbo.Employee_Demograhics
--ORDER BY Gender,Age

--SELECT First_Name, Last_Name,Age,Gender,
--CONCAT (First_Name, ' ', Last_Name) AS FULL_NAME
--FROM [JOHN SQL TUTORIAL].dbo.Employee_Demograhics
--ORDER BY Age, Gender

--SELECT First_Name,Last_Name,Job_Title,Gender,Salary,
--CASE
--	WHEN Job_Title = 'Salesman' THEN Salary + (Salary * .10)
--	WHEN Job_Title = 'HR' THEN Salary + (Salary * .25)
--	ELSE Salary + (Salary * .05)
--END AS NEW_SALARY
--FROM [JOHN SQL TUTORIAL].dbo.Employee_Demograhics
--INNER JOIN [JOHN SQL TUTORIAL].dbo.Employee_Salary
--	ON Employee_Demograhics.Employee_ID = Employee_Salary.Empolyee_ID
--ORDER BY Salary DESC

--SELECT*
--FROM [JOHN SQL TUTORIAL].dbo.PAKS_AND_RECORDS

--UPDATE [JOHN SQL TUTORIAL].dbo.PAKS_AND_RECORDS
--SET DOB = 'December_19th'
--WHERE First_Name = 'Slyvia' and Last_Name = 'Nelson'

--UPDATE [JOHN SQL TUTORIAL].dbo.PAKS_AND_RECORDS
--SET First_Name = 'Nicolas'
--WHERE Last_Name = 'Jackson' and Age = 30

--UPDATE [JOHN SQL TUTORIAL].dbo.PAKS_AND_RECORDS
--SET Gender = 'Male'
--WHERE First_Name = 'John' and Last_Name = 'Onyebuchi'

--UPDATE [JOHN SQL TUTORIAL].dbo.PAKS_AND_RECORDS
--SET Last_Name = 'Rashfordson'
--WHERE First_Name = 'Marcus' and DOB = 'February_5th'

--SELECT First_Name, Last_Name,Age, Gender,Job_Title,Salary, COUNT (Gender) OVER (PARTITION BY Gender) AS Total_Gender
--FROM [JOHN SQL TUTORIAL].dbo.PAKS_AND_RECORDS
--INNER JOIN [JOHN SQL TUTORIAL].dbo.SALARY_OF_PAKS_N_RECORDS
--	ON PAKS_AND_RECORDS.EMPLOYEE_ID = SALARY_OF_PAKS_N_RECORDS.Employee_ID
--ORDER BY Age 