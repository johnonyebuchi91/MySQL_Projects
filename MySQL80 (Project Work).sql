SELECT Empid, First_Name, Last_Name, Gender, Salary, Department
FROM johnsql.employee_demographics AS DEM
JOIN johnsql.employee_salary AS SAL
	ON DEM.EmpID = idEmp_Salary
    ORDER BY salary desc;
    
SELECT COUNT(Salary), MAX(Salary), MIN(Salary)
FROM johnsql.employee_salary;

SELECT *
FROM johnsql.employee_demographics
WHERE first_name = 'Chioma';

SELECT first_name, gender, Age, Count(age), max(age), min(age)
FROM johnsql.employee_demographics
GROUP BY gender, age, First_name;

SELECT First_Name,Gender, age
FROM johnsql.elite_physiologist
group by First_Name, Gender, Age 
order by age;

SELECT*
FROM johnsql.elite_records AS DEM
JOIN johnsql.employee_salary AS SAL
	ON DEM.idElite = SAL.idEmp_Salary;

SELECT First_Name, Last_Name, Age,
CASE
	WHEN Age >= 30 THEN 'OLD'
    ELSE 'YOUNG'
END AS TAGS
FROM johnsql.employee_demographics;

USE johnsql;
DROP TEMPORARY TABLE IF EXISTS temp_Employee;
CREATE TEMPORARY TABLE temp_Employee ( 
Emp_ID int,
Job_Title Varchar (50),
Salary int
);

USE johnsql;
INSERT INTO temp_Employee (Emp_ID, Job_Title, Salary) VALUES
(1, 'Software_Engineer', 70000),
(2, 'Data_Analyst', 40000),
(3, 'HR', 56000);

USE johnsql;
SELECT*
FROM temp_Employee;

SELECT Department, Salary AS Old_Salary,
CASE
WHEN Department IN ('Salesman','Delivery_Man') THEN Salary + (Salary * 0.10)
ELSE Salary + ( Salary * 0.005)
END AS New_Salary
FROM johnsql.elite_records;


SELECT 
Main.Department, 
Main.Salary AS Old_Salary,
(SELECT
CASE
WHEN Not_Main.Department IN ('Salesman','Delivery_Man') 
THEN Not_Main.Salary + (Not_Main.Salary * 0.10)
ELSE Not_Main.Salary + ( Not_Main.Salary * 0.005)
END 
FROM johnsql.elite_records AS Not_Main
WHERE Not_Main.Department = Main.Department
LIMIT 1 ) AS New_Salary,

(SELECT count(Department)
FROM johnsql.elite_records AS Not_Main
WHERE Not_main.Department = Main.Department) AS Total_Employees,

(SELECT avg (Not_main.Salary)
FROM johnsql.elite_records AS Not_Main
WHERE Not_main.Department = Main.Department) AS Avg_Salary,

(SELECT max(Not_main.Salary)
FROM johnsql.elite_records AS Not_Main
WHERE Not_main.Department = Main.Department
GROUP BY Not_Main.Department) AS Max_Salary,

(SELECT min(Not_Main.Salary)
FROM johnsql.elite_records AS Not_Main
WHERE Not_main.Department = Main.Department
GROUP BY Not_Main.Department) AS Min_Salary 
FROM johnsql.elite_records AS Main;