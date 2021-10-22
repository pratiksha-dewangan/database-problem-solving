================================================================================
|                         MySQL Practice Question - 2                          |
================================================================================
1) Find all the professors who are in any one of the committees that professor Piper is in.

Sol:

SELECT DISTINCT c.profname
  FROM committee c
  WHERE c.commname IN (
    SELECT commname FROM committee WHERE profname = 'Piper'
  );

================================================================================
2) Find all the professors who have not offices in any of those buildings that
   Professor Piper has offices in.

Sol:

SELECT p.profname
  FROM professor p
  WHERE p.deptname IN (
    SELECT DISTINCT d.deptname
      FROM department d
        JOIN professor pt ON pt.deptname = d.deptname
      WHERE pt.profname <> 'Piper'
  );

================================================================================
3) Find all the professors who are in at least all those committees that professor Piper is in.

Sol:

SELECT DISTINCT c.*
  FROM committee c
  WHERE c.commname IN ALL (
    SELECT commname FROM committee WHERE profname = 'Piper'
  );