Functions

1. Write a program to take the input as empno and return the experience of employee in terms of number of years.

DELIMITER $$
DROP FUNCTION IF EXISTS F1 $$
CREATE FUNCTION F1 (empno INT)
  RETURNS INT
  READS SQL DATA
  DETERMINISTIC
BEGIN
  DECLARE experience INT;

  SELECT TIMESTAMPDIFF(YEAR, e.hiredate, CURDATE()) INTO experience
    FROM emp e WHERE e.empno = empno;

  RETURN experience;
END $$
DELIMITER ;

--------------------------------------------------------------------------------
2. Write a program to take the input as deptno and return the comma separated list of employee names

DELIMITER $$
DROP FUNCTION IF EXISTS F2 $$
CREATE FUNCTION F2 (deptno INT)
  RETURNS VARCHAR(100)
  READS SQL DATA
  DETERMINISTIC
BEGIN
  DECLARE employees VARCHAR(100);

  SELECT GROUP_CONCAT(e.ename) INTO employees
    FROM emp e WHERE e.deptno = deptno;

  RETURN employees;
END $$
DELIMITER ;

--------------------------------------------------------------------------------
3. Add a new column incentive to emp table.
  Write a program to calculate and update the incentive using following logic.
  If employees salary is more then avg salary of dept then incentive is 0
  If employees salary is less then avg salary of dept then incentive is 10% of salary

Answer:

DELIMITER $$
DROP FUNCTION IF EXISTS F3 $$
CREATE FUNCTION F3 ()
  RETURNS NULL
  DETERMINISTIC
BEGIN
  CREATE TEMPORARY TABLE emp_incentive (
    SELECT 
        e.*,
        IF(e.sal < d.avg_sal, ROUND(1.1 * e.sal), 0) as incentive
      FROM EMP e
      JOIN (
        SELECT e.deptno, ROUND(AVG(e.sal)) AS avg_sal
          FROM emp e
          GROUP BY deptno
      ) d ON e.deptno = d.deptno
  );

  UPDATE emp e, emp_incentive ei
    SET e.incentive = ei.incentive
    WHERE ei.empno = e.empno;
 
  RETURN 0;
END $$
DELIMITER ;
-- ALTER TABLE emp ADD COLUMN incentive FLOAT DEFAULT 0;
--------------------------------------------------------------------------------
4. Write a program to get the count of employees working in provided deptno

Answer:

DELIMITER $$
DROP FUNCTION IF EXISTS F4 $$
CREATE FUNCTION F4 (deptno INT)
  RETURNS INT
  READS SQL DATA
  DETERMINISTIC
BEGIN
  DECLARE count INT;
  SELECT COUNT(*)
    INTO count
    FROM emp e
    WHERE e.deptno = deptno;
  RETURN count;
END $$
DELIMITER ;

