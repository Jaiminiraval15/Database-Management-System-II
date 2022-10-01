ALTER TABLE EMPLOYEE ALTER COLUMN JOININGDATE DATETIME NULL
1. --Display all the employees whose name starts with “m” and 4 th character is “h”.
SELECT * FROM EMPLOYEE WHERE ENAME LIKE 'M___H%'
2. --Find the value of 3 raised to 5. Label the column as output.
SELECT POWER(3,5)
3.-- Write a query to subtract 20 days from the current date.
SELECT GETDATE()-20
4. --Write a query to display name of employees whose name starts with “j” and contains “n” in their name.
SELECT ENAME FROM EMPLOYEE WHERE ENAME LIKE 'J%N%'
5.-- Display 2nd to 9th character of the given string “SQL Programming”.
SELECT SUBSTRING('SQL PROGRAMMING',2,9)
6.-- Display name of the employees whose city name ends with “ney” &contains six characters.
SELECT ENAME FROM EMPLOYEE WHERE CITY LIKE '%NEY' AND CITY LIKE '______'
7.-- Write a query to convert value 15 to string.
SELECT CONVERT(VARCHAR,15)
8.-- Add department column with varchar (20) to Employee table.
ALTER TABLE EMPLOYEE ADD DEPARTMENT VARCHAR(20)
9.-- Set the value of department to Marketing who belongs to London city.
UPDATE EMPLOYEE SET DEPARTMENT='MARKETING' WHERE CITY='LONDON'
10.-- Display all the employees whose name ends with either “n” or “y”.
SELECT * FROM EMPLOYEE WHERE ENAME LIKE '%N' OR ENAME LIKE '%Y'
11. --Find smallest integer value that is greater than or equal to 63.1, 63.8 and -63.2.
SELECT CEILING(63.1),CEILING(63.8),CEILING(-63.2)
12. --Display all employees whose joining date is not available.
SELECT * FROM EMPLOYEE WHERE JOININGDATE IS NULL
13. --Display name of the employees in capital letters and city in small letters.
SELECT UPPER(ENAME), LOWER(CITY) FROM EMPLOYEE
14. --Change the data type of Ename from varchar (30) to char (30).
ALTER TABLE EMPLOYEE ALTER COLUMN ENAME CHAR(30)
15. --Display city wise maximum salary.
SELECT CITY,MAX(SALARY) FROM EMPLOYEE GROUP BY CITY
16. --Produce output like <Ename> works at <city> and earns <salary> (In single column).
SELECT CONCAT(EMPLOYEE.ENAME ,'WORKS AT', EMPLOYEE.CITY , 'AND EARNS', EMPLOYEE.SALARY) FROM EMPLOYEE 
17. --Find total number of employees whose salary is more than 5000.
SELECT COUNT(EID) FROM EMPLOYEE WHERE SALARY>5000

