Procedure
==========
1. Prepare a program which can perform following operation
  - Lookout for tables which has missing constraints
  - Display list of those tables


--------------------------------------------------------------------------------
2. Prepare a program to delete the data from emp. It will receive two inputs employee number and employee name.
If employee number is passed as null then delete the data based on employee name.
Backup the deleted data to employee_backup table.

DELIMITER //
DROP PROCEDURE IF EXISTS PROC2 //
CREATE PROCEDURE PROC2(ID INT,NAME VARCHAR(20))
BEGIN
IF(ID IS NULL)
THEN
DELETE FROM EMP WHERE ENAME=NAME;
ELSE
DELETE FROM EMP WHERE EMPNO=ID;
END IF;
END //
--------------------------------------------------------------------------------
3. Prepare a program to insert new record in employee table. it will take the input of employee data.
If salary is provided as null then consider the salary as highest salary earned by any employee in same department.
If comm is not provided then assume it as 200$

DELIMITER //
DROP PROCEDURE IF EXISTS PROC3 //
   CRATE PROCEDURE PROC3(EMPNO INT,ENAME VARCHAR(10),JPB VARCHAR(9),MGR INT,HIREDATE DATE,
   INOUT SAL FLOAT,INOUT COMM FLOAT,DEPTNO INT)
BEGIN
IF(SAL IS NULL) THEN
  SELECT MAX(E.SAL) AS SAL FROM EMP WHERE E.DEPTNO=DEPTNO;
END IF;

IF(COMM IS NULL)
  SET COMM = 200;
END IF;

 INSERT INTO emp (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
    VALUES (empno, ename, job, mgr, hiredate, sal, comm, deptno);
END //
DELIMITER ;

SET @SAL=4000;
SET @COMM=500;

CALL PROC3(2000, 'LOKESH', 'Manager', 7333, '2021-11-02', @saL, @comm, 10);

--------------------------------------------------------------------------------

4. Prepare a program to receive the input as table name and column name.
Add primary key constraint on provided table column.

Answer:

DELIMITER $$
DROP PROCEDURE IF EXISTS P11 $$
CREATE PROCEDURE P11(tablename VARCHAR(30), columnname VARCHAR(30))
BEGIN
  SET @query = CONCAT('ALTER TABLE ', tablename, ' ADD PRIMARY KEY ( ', columnname, ' )');
  PREPARE stmt FROM @query;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
END $$
DELIMITER ;

CALL P11('emp', 'empno');

(NOT UNDERSTAND:CLEARED FROM SOMEONE)
--------------------------------------------------------------------------------
5. Prepare a program to list those employee who are earning less then avg of there deparment.
This program may take input as (p_salary_fix BOOLEAN).
If the input is given as true then these employees salary must be set to AVG Salary + 100$.

Answer:

DELIMITER $$
DROP PROCEDURE IF EXISTS P11 $$
CREATE PROCEDURE P11(p_salary_fix BOOLEAN)
BEGIN
  DECLARE CONTINUE HANDLER FOR 1050
    BEGIN
      SELECT 'Temporary Table Already Exists.' as Message;
    END;

  CREATE TEMPORARY TABLE underpaid_emps (
    SELECT e.*, d.avg_sal FROM emp e 
      JOIN (
        SELECT deptno, ROUND(AVG(sal)) AS avg_sal FROM emp GROUP BY deptno
      ) d ON e.deptno = d.deptno
      WHERE e.sal < d.avg_sal
  );

  SELECT * FROM underpaid_emps;

  IF (p_salary_fix = TRUE) THEN
    UPDATE emp e, underpaid_emps ue SET e.sal = ue.avg_sal + 100 WHERE e.empno = ue.empno;
  END IF;

  SELECT * FROM emp;
END $$
DELIMITER ;


(NOT UNDERSTAND:CLEARED FROM SOMEONE)

--------------------------------------------------------------------------------------------
