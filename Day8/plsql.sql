PL/SQL Basics
-----------------------------------------------------------------------------------
Practice 1:
     
 Evaluate each of the following declarations.
 Determine which of them are not legal and explain why?

     a.	DECLARE    v_id INT(4);
     b.  DECLARE    v_x , v_y,  v_z  VARCHAR(10);
     c.  DECLARE   v_birthdate DATE;
     d.  DECLARE   v_in_stock   BOOLEAN default 1;  


DELIMITER //
DROP PROCEDURE IF EXISTS P1 //
CREATE PROCEDURE P1()
  BEGIN
    DECLARE v_id INT;
    DECLARE v_x, v_y, v_z VARCHAR(10) DEFAULT 'Test';
    DECLARE v_birthday DATE DEFAULT '2021-07-26';
    DECLARE v_in_stock BOOLEAN DEFAULT FALSE;
    SELECT v_id, v_x, v_y, v_z, v_birthday, v_in_stock;
  END //
DELIMITER ;
===========
  -- Equivalent MySQL version

mysql> CREATE PROCEDURE P1()
    ->   BEGIN
    ->     DECLARE v_id INT;
    ->     DECLARE v_x, v_y, v_z VARCHAR(10) DEFAULT 'Test';
    ->     DECLARE v_birthday DATE DEFAULT '2021-07-26';
    ->     DECLARE v_in_stock BOOLEAN DEFAULT FALSE;
    ->     SELECT v_id, v_x, v_y, v_z, v_birthday, v_in_stock;
    ->   END //
Query OK, 0 rows affected (0.19 sec)

mysql> DELIMITER ;
mysql> call p1();
+------+------+------+------+------------+------------+
| v_id | v_x  | v_y  | v_z  | v_birthday | v_in_stock |
+------+------+------+------+------------+------------+
| NULL | Test | Test | Test | 2021-07-26 |          0 |
+------+------+------+------+------------+------------+
1 row in set (0.00 sec)

Answer: They all are valid.

----------------------------------------------------------------------------------------------
Practice 2: What will be the output of the following program?

DELIMITER //
DROP PROCEDURE IF EXISTS P2//
CREATE PROCEDURE P2()
  BEGIN
    DECLARE v_data INT(7);
    SELECT v_data;
  END//
  DELIMITER ;
  
  CALL P2();

==================
  -- Equivalent MySQL version

mysql> DELIMITER //
mysql> DROP PROCEDURE IF EXISTS P2//
Query OK, 0 rows affected, 1 warning (0.04 sec)

mysql> CREATE PROCEDURE P2()
    ->   BEGIN
    ->     DECLARE v_data INT(7);
    ->     SELECT v_data;
    ->   END//
Query OK, 0 rows affected, 1 warning (0.16 sec)

mysql>   DELIMITER ;
mysql>
mysql>   CALL P2();
+--------+
| v_data |
+--------+
|   NULL |
+--------+
1 row in set (0.00 sec)

Answer: NULL [No default value]

----------------------------------------------------------------------------------------
Practice 3: What will be the output of the following program?

     BEGIN
      	 DECLARE  v_weight INT (3) DEFAULT 600;
            DECLARE v_message VARCHAR2(255) DEFAULT 'Product 10012';

 	BEGIN
      		DECLARE  v_weight INT(3) DEFAULT 1;
      		DECLARE  v_message VARCHAR2 (25) DEFAULT 'Product 11001';
      		DECLARE  v_new_locn VARCHAR2(25) DEFAULT 'Europe';
   		
    		SET v_weight = v_weight +1;
  		SET v_new_locn ='Western ' ||v_new_locn; 
			--  Point 1

END; 
 SET v_weight=v_weight + 1;
 SET v_message=v_message|| ' is in stock';
-- Point 2
   END; 
===============
  -- Equivalent MySQL version

DELIMITER //
  DROP PROCEDURE IF EXISTS P3 //
  CREATE PROCEDURE P3()
  BEGIN
      DECLARE v_weight INT(3) DEFAULT 600;
      DECLARE v_message VARCHAR(255) DEFAULT 'Product 10012';

      BEGIN
        DECLARE  v_weight INT(3) DEFAULT 1;
        DECLARE  v_message VARCHAR(25) DEFAULT 'Product 11001';
        DECLARE  v_new_locn VARCHAR(25) DEFAULT 'Europe';
        
        SET v_weight = v_weight +1;
        SET v_new_locn = CONCAT('Western ', v_new_locn);
        --  Point 1

        SELECT v_weight, v_message, v_new_locn;

      END; 
      SET v_weight = v_weight + 1;
      SET v_message = CONCAT(v_message, ' is in stock');
      -- Point 2
      SELECT v_weight, v_message, v_new_locn;
  END //
  DELIMITER ;
=================
mysql>   CREATE PROCEDURE P3()
    ->   BEGIN
    ->       DECLARE v_weight INT(3) DEFAULT 600;
    ->       DECLARE v_message VARCHAR(255) DEFAULT 'Product 10012';
    ->
    ->       BEGIN
    ->         DECLARE  v_weight INT(3) DEFAULT 1;
    ->         DECLARE  v_message VARCHAR(25) DEFAULT 'Product 11001';
    ->         DECLARE  v_new_locn VARCHAR(25) DEFAULT 'Europe';
    ->
    ->         SET v_weight = v_weight +1;
    ->         SET v_new_locn = CONCAT('Western ', v_new_locn);
    ->         --  Point 1
    ->
    ->         SELECT v_weight, v_message, v_new_locn;
    ->
    ->       END;
    ->       SET v_weight = v_weight + 1;
    ->       SET v_message = CONCAT(v_message, ' is in stock');
    ->       -- Point 2
    ->       SELECT v_weight, v_message, v_new_locn;
    ->   END //
Query OK, 0 rows affected, 2 warnings (0.32 sec)

mysql>   DELIMITER ;
mysql> CALL P3();
+----------+---------------+----------------+
| v_weight | v_message     | v_new_locn     |
+----------+---------------+----------------+
|        2 | Product 11001 | Western Europe |
+----------+---------------+----------------+
1 row in set (0.00 sec)

ERROR 1054 (42S22): Unknown column 'v_new_locn' in 'field list'
----------------------------------------------------------------------------------------
ractice 4:  

Write a PL/SQL block that accepts values of two non zero integer Ints from user. The block performs the following operation 
( first_Int/second_Int + second_Int). The result of the operation should be stored in a PL/SQL variable and also displayed on the screen.

DELIMITER //
DROP PROCEDURE IF EXISTS P4 //
CREATE PROCEDURE P4(A INT, B INT)
BEGIN
  DECLARE C INT;
  SET C = (A / B) + B;
  SELECT C as Result;
END //
DELIMITER; 
=================
  -- Equivalent MySQL version

mysql> CREATE PROCEDURE P4(A INT, B INT)
    -> BEGIN
    ->   DECLARE C INT;
    ->   SET C = (A / B) + B;
    ->   SELECT C as Result;
    -> END //
Query OK, 0 rows affected (0.13 sec)

mysql> DELIMITER ;
mysql> CALL P4(10,10);
+--------+
| Result |
+--------+
|     11 |
+--------+
1 row in set (0.00 sec)

Query OK, 0 rows affected (0.01 sec)
-----------------------------------------------------------------------------------------
Practice 5:

Declare two SQL* plus variables named MAX_SALARY and MIN_SALARY that are of data type INT.
Write a PL/SQL block that accepts deptno value from a user, selects the maximum salary and minimum salary paid in the department,
from the EMP table and stores the corresponding values in MAX_SALARY and MIN_SALARY respectively.
Use appropriate SQL * plus command to see the modified values of MAX_SALARY and MIN_SALARY

-- Works with Scott Schema
  
DELIMITER //
DROP PROCEDURE IF EXISTS P5 //
CREATE PROCEDURE P5(dept_id INT, OUT min_salary INT, OUT max_salary INT)
BEGIN
  SELECT MAX(sal), MIN(sal) INTO max_salary, min_salary
    FROM emp
    WHERE deptno = dept_id;

  SELECT dept_id, max_salary, min_salary;
END //
DELIMITER ;

CALL P5(10, @min, @max);

SELECT @min, @max;
===============
mysql> DELIMITER //
mysql> DROP PROCEDURE IF EXISTS P5 //
Query OK, 0 rows affected, 1 warning (0.08 sec)

mysql> CREATE PROCEDURE P5(dept_id INT, OUT min_salary INT, OUT max_salary INT)
    -> BEGIN
    ->   SELECT MAX(sal), MIN(sal) INTO max_salary, min_salary
    ->     FROM emp
    ->     WHERE deptno = dept_id;
    ->
    ->   SELECT dept_id, max_salary, min_salary;
    -> END //
Query OK, 0 rows affected (0.14 sec)

mysql> DELIMITER ;
mysql>
mysql> CALL P5(10, @min, @max);
+---------+------------+------------+
| dept_id | max_salary | min_salary |
+---------+------------+------------+
|      10 |       5000 |       1300 |
+---------+------------+------------+
1 row in set (0.01 sec)

Query OK, 0 rows affected (0.06 sec)


--------------------------------------------------------------------------------
Practice 6: 

Write a PL/SQL block that accepts employee Int from a user and retrieves the salary for the employee from the EMP table.
It determines the salary class as per the following criteria and displays the salary and salary class on the screen.
Criteria for deciding salary class:
• If the salary is less than 2500, then it comes under the class 'LOW'
• If the salary is greater than or equal to  2500 and less than 5000, then it comes under class 'MEDIUM'.
• If the salary is greater than or equal to 5000, then it comes under class 'HIGH'

Answer:

-- Works with Scott Schema

DELIMITER //
DROP PROCEDURE IF EXISTS P6 //
CREATE PROCEDURE P6(emp_id INT)
BEGIN
  DECLARE salary INT;
  DECLARE class ENUM('LOW', 'MEDIUM', 'HIGH');
  SELECT sal INTO salary FROM emp WHERE empno = emp_id;
  SELECT (
    CASE
      WHEN salary >= 5000 THEN 'HIGH'
      WHEN salary >= 2500 THEN 'MEDIUM'
      ELSE 'LOW'
    END
  ) INTO class;

  SELECT salary, class;
END //
DELIMITER ;

CALL P6(7844);
==================
mysql> CREATE PROCEDURE P6(emp_id INT)
    -> BEGIN
    ->   DECLARE salary INT;
    ->   DECLARE class ENUM('LOW', 'MEDIUM', 'HIGH');
    ->   SELECT sal INTO salary FROM emp WHERE empno = emp_id;
    ->   SELECT (
    ->     CASE
    ->       WHEN salary >= 5000 THEN 'HIGH'
    ->       WHEN salary >= 2500 THEN 'MEDIUM'
    ->       ELSE 'LOW'
    ->     END
    ->   ) INTO class;
    ->
    ->   SELECT salary, class;
    -> END //
Query OK, 0 rows affected (0.10 sec)

mysql> DELIMITER ;
mysql>
mysql> CALL P6(7844);
+--------+-------+
| salary | class |
+--------+-------+
|   1500 | LOW   |
+--------+-------+
1 row in set (0.01 sec)

Query OK, 0 rows affected (0.07 sec)

--------------------------------------------------------------------------------
Practice 7:

Write a PL/SQL block that accepts an integer value between 1 and 12 from a user and displays the name of the corresponding month.
If the Int input  is not in the range +1 to +12 then the block should display the message “Invalid Month” on the screen.

Answer:

DELIMITER //
DROP PROCEDURE IF EXISTS P7 //
CREATE PROCEDURE P7(month INT)
BEGIN
  DECLARE name VARCHAR(10);

  SELECT (
    CASE month
      WHEN 01 THEN 'January'
      WHEN 02 THEN 'February'
      WHEN 03 THEN 'March'
      WHEN 04 THEN 'April'
      WHEN 05 THEN 'May'
      WHEN 06 THEN 'June'
      WHEN 07 THEN 'July'
      WHEN 08 THEN 'August'
      WHEN 09 THEN 'September'
      WHEN 10 THEN 'October'
      WHEN 11 THEN 'November'
      WHEN 12 THEN 'December'
      ELSE 'Invalid Month'
    END
  ) INTO name;

  SELECT month, name;
END //
DELIMITER ;

CALL P7(11);
================
mysql> CREATE PROCEDURE P7(month INT)
    -> BEGIN
    ->   DECLARE name VARCHAR(10);
    ->
    ->   SELECT (
    ->     CASE month
    ->       WHEN 01 THEN 'January'
    ->       WHEN 02 THEN 'February'
    ->       WHEN 03 THEN 'March'
    ->       WHEN 04 THEN 'April'
    ->       WHEN 05 THEN 'May'
    ->       WHEN 06 THEN 'June'
    ->       WHEN 07 THEN 'July'
    ->       WHEN 08 THEN 'August'
    ->       WHEN 09 THEN 'September'
    ->       WHEN 10 THEN 'October'
    ->       WHEN 11 THEN 'November'
    ->       WHEN 12 THEN 'December'
    ->       ELSE 'Invalid Month'
    ->     END
    ->   ) INTO name;
    ->
    ->   SELECT month, name;
    -> END //
Query OK, 0 rows affected (0.17 sec)

mysql> DELIMITER ;
mysql>
mysql> CALL P7(11);
+-------+----------+
| month | name     |
+-------+----------+
|    11 | November |
+-------+----------+
1 row in set (0.00 sec)

Query OK, 0 rows affected (0.03 sec)

--------------------------------------------------------------------------
Practice 8:

Write a PL/SQL block that accepts employee Int from a user.
Declare a PL/SQL record to store the employee Int, employee name, department Int
and the department name of the employee. Retrieve the values of these columns for the employee
from the EMP and DEPT tables and display the employee name and the corresponding department name on the screen.

Answer:

DELIMITER //
DROP PROCEDURE IF EXISTS P8 //
CREATE PROCEDURE P8(emp_id INT)
BEGIN
  DECLARE dept_id INT;
  DECLARE emp_name, dept_name VARCHAR(20);

  SELECT e.ename, e.deptno, d.dname INTO emp_name, dept_id, dept_name
    FROM emp e JOIN dept d ON e.deptno = d.deptno WHERE e.empno = emp_id;

  SELECT emp_id, emp_name, dept_id, dept_name;
END //
DELIMITER ;

CALL P8(7698);
=====================

mysql> CREATE PROCEDURE P8(emp_id INT)
    -> BEGIN
    ->   DECLARE dept_id INT;
    ->   DECLARE emp_name, dept_name VARCHAR(20);
    ->
    ->   SELECT e.ename, e.deptno, d.dname INTO emp_name, dept_id, dept_name
    ->     FROM emp e JOIN dept d ON e.deptno = d.deptno WHERE e.empno = emp_id;
    ->
    ->   SELECT emp_id, emp_name, dept_id, dept_name;
    -> END //
Query OK, 0 rows affected (0.13 sec)

mysql> DELIMITER ;
mysql>
mysql> CALL P8(7698);
+--------+----------+---------+-----------+
| emp_id | emp_name | dept_id | dept_name |
+--------+----------+---------+-----------+
|   7698 | BLAKE    |      30 | SALES     |
+--------+----------+---------+-----------+
1 row in set (0.14 sec)

Query OK, 0 rows affected (0.18 sec)
-----------------------------------------------------------------------------------------
Practice 09:

Write a PL/SQL block to add a department row in the DEPT table with the following values for columns

a.  The block retrieves the maximum value of deptno from the dept table and adds 1 to it to generate the value of deptno 
b.  Dname  value should be  'Education'
c.  Loc value should be NULL
           
Answer:

DELIMITER //
DROP PROCEDURE IF EXISTS P9 //
CREATE PROCEDURE P9()
  BEGIN
    DECLARE new_id INT;
    SELECT MAX(deptno) + 1 INTO new_id FROM dept;

    INSERT INTO dept VALUES (new_id, 'Education', NULL);
  END //
DELIMITER ;

CALL P9();
===============
mysql> DELIMITER //
mysql> DROP PROCEDURE IF EXISTS P9 //
Query OK, 0 rows affected, 1 warning (0.06 sec)

mysql> CREATE PROCEDURE P9()
    ->   BEGIN
    ->     DECLARE new_id INT;
    ->     SELECT MAX(deptno) + 1 INTO new_id FROM dept;
    ->
    ->     INSERT INTO dept VALUES (new_id, 'Education', NULL);
    ->   END //
Query OK, 0 rows affected (0.14 sec)

mysql> DELIMITER ;
mysql>
mysql> CALL P9();
Query OK, 1 row affected (0.16 sec)


mysql> select * from dept;
+--------+------------+----------+
| DEPTNO | DNAME      | LOC      |
+--------+------------+----------+
|     10 | ACCOUNTING | NEW YORK |
|     20 | RESEARCH   | DALLAS   |
|     30 | SALES      | CHICAGO  |
|     40 | OPERATIONS | BOSTON   |
|     41 | Education  | NULL     |
+--------+------------+----------+
5 rows in set (0.00 sec)
==========================================================================================