-- Employee Data Analysis using MySQL

-- 1. Retrieving Employee Information with Salary Details
SELECT Empid, First_Name, Last_Name, Gender, Salary, Department
FROM johnsql.employee_demographics AS DEM
JOIN johnsql.employee_salary AS SAL
    ON DEM.EmpID = idEmp_Salary
ORDER BY salary DESC;

-- 2. Calculating Salary Statistics (Count, Max, Min)
SELECT COUNT(Salary), MAX(Salary), MIN(Salary)
FROM johnsql.employee_salary;

-- 3. Filtering Employees by First Name
SELECT *
FROM johnsql.employee_demographics
WHERE first_name = 'Chioma';

-- 4. Grouping Employees by Gender and Age, with Count and Age Statistics
SELECT first_name, gender, Age, COUNT(age), MAX(age), MIN(age)
FROM johnsql.employee_demographics
GROUP BY gender, age, First_name;

-- 5. Grouping and Sorting Employees from Elite Physiologist Table
SELECT First_Name, Gender, age
FROM johnsql.elite_physiologist
GROUP BY First_Name, Gender, Age 
ORDER BY age;

-- 6. Joining Elite Records with Employee Salary Table
SELECT *
FROM johnsql.elite_records AS DEM
JOIN johnsql.employee_salary AS SAL
    ON DEM.idElite = SAL.idEmp_Salary;

-- 7. Categorizing Employees Based on Age (Young vs. Old)
SELECT First_Name, Last_Name, Age,
CASE
    WHEN Age >= 30 THEN 'OLD'
    ELSE 'YOUNG'
END AS TAGS
FROM johnsql.employee_demographics;

-- 8. Creating a Temporary Employee Table
USE johnsql;
DROP TEMPORARY TABLE IF EXISTS temp_Employee;
CREATE TEMPORARY TABLE temp_Employee ( 
Emp_ID INT,
Job_Title VARCHAR(50),
Salary INT
);

-- 9. Inserting Sample Data into Temporary Table
USE johnsql;
INSERT INTO temp_Employee (Emp_ID, Job_Title, Salary) VALUES
(1, 'Software_Engineer', 70000),
(2, 'Data_Analyst', 40000),
(3, 'HR', 56000);

-- 10. Retrieving Data from Temporary Table
USE johnsql;
SELECT *
FROM temp_Employee;

-- 11. Adjusting Salaries Based on Department
SELECT Department, Salary AS Old_Salary,
CASE
    WHEN Department IN ('Salesman','Delivery_Man') THEN Salary + (Salary * 0.10)
    ELSE Salary + (Salary * 0.005)
END AS New_Salary
FROM johnsql.elite_records;

-- 12. Calculating Department-wise Salary Adjustments and Statistics
SELECT 
Main.Department, 
Main.Salary AS Old_Salary,
(SELECT
    CASE
        WHEN Not_Main.Department IN ('Salesman','Delivery_Man') 
        THEN Not_Main.Salary + (Not_Main.Salary * 0.10)
        ELSE Not_Main.Salary + (Not_Main.Salary * 0.005)
    END 
 FROM johnsql.elite_records AS Not_Main
 WHERE Not_Main.Department = Main.Department
 LIMIT 1 ) AS New_Salary,

(SELECT COUNT(Department)
 FROM johnsql.elite_records AS Not_Main
 WHERE Not_Main.Department = Main.Department) AS Total_Employees,

(SELECT AVG(Not_Main.Salary)
 FROM johnsql.elite_records AS Not_Main
 WHERE Not_Main.Department = Main.Department) AS Avg_Salary,

(SELECT MAX(Not_Main.Salary)
 FROM johnsql.elite_records AS Not_Main
 WHERE Not_Main.Department = Main.Department
 GROUP BY Not_Main.Department) AS Max_Salary,

(SELECT MIN(Not_Main.Salary)
 FROM johnsql.elite_records AS Not_Main
 WHERE Not_Main.Department = Main.Department
 GROUP BY Not_Main.Department) AS Min_Salary 
FROM johnsql.elite_records AS Main;
