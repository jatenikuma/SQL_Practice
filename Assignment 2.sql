-- 1  List the department managers who are controlling more than 2 projects.
SELECT Fname , Lname
FROM EMPLOYEE
WHERE Ssn IN (
					-- Get their ssn
					SELECT Mgr_ssn
					FROM DEPARTMENT
					WHERE Dnumber = ANY
							(
                            -- Get the number of managers from project table controlling more than two projects
								SELECT Dnum
								FROM PROJECT
								GROUP BY Dnum	
								HAVING COUNT(*) > 2
							)
									
			);
            
-- 2 Retrieve the names of the departments that only located in ‘Houston’.

SELECT Dname
FROM DEPARTMENT
WHERE Dnumber IN (

			SELECT DEPT_LOCATIONS.Dnumber
            FROM DEPT_LOCATIONS
            WHERE Dlocation = "Houston"
            
				);
                
-- 3 List the names of employees all of whose dependents were born before 1960.

SELECT Fname , Lname
FROM EMPLOYEE
WHERE SSN IN (

		-- Dependents born before 1960
		SELECT Essn
        FROM DEPENDENT
        WHERE YEAR(Bdate) < 1960

);

-- 4 List the names of departments managed by the direct subordinate of the manager of ‘Headquarters’ department.

SELECT Dname
FROM DEPARTMENT
WHERE Mgr_ssn IN ( 
		
			-- Get the ssn of the employee managing another department but subordinate to hq
			SELECT Ssn
            FROM EMPLOYEE
            WHERE Super_ssn = ANY (
            
					-- Get the manager's ssn and pass it to outter select to find who he/she supervises
					SELECT Mgr_ssn
                    FROM DEPARTMENT
                    WHERE Dname = "Headquarters"
								  )
				);

-- 5 Retrieve the average salary of male employees who work totally no less than 50 hours on projects.

SELECT AVG (SALARY) AS Average_Salary
FROM EMPLOYEE
WHERE SEX = "M" AND SSN IN 
			(
						SELECT ESSN
						FROM WORKS_ON
						GROUP BY ESSN
						HAVING SUM(Hours) >= 50
			);


-- 6 Find the names of projects that all direct subordinates of James Borg work for.

SELECT Pname
FROM PROJECT
WHERE Pnumber IN (
				
                --  Get the project number they are working on and pass it to projects to find the Pname
                SELECT Pno
                FROM WORKS_ON
                WHERE Essn = ANY (
                
								-- Get the ssn of employees who are direct subordinates of james
								SELECT Ssn
                                FROM EMPLOYEE
                                WHERE Super_ssn = ANY (
                                
												-- Get the ssn of james and pass it to outter to find who his subordinates are
												SELECT Ssn
                                                FROM EMPLOYEE
                                                WHERE Fname = "James" AND Lname = "Borg"
													  )
								)
                );

-- 7 Show the name of employee who and whose supervisor are in different departments.


SELECT  E.FNAME , E.LNAME
FROM Company.Employee e
LEFT JOIN Company.Employee s
ON e.Super_ssn = s.Super_ssn
WHERE e.DNO != S.DNO;



-- 8 Find the name of employee who only has spouse as the dependent.

SELECT e.Fname , e.Lname
FROM Company.Employee e
JOIN Company.Dependent d ON d.Essn = e.Ssn
WHERE d.Relationship = 'Spouse' AND (
    SELECT COUNT(*)
    FROM Company.Dependent dd
    WHERE e.Ssn = dd.Essn AND (dd.Relationship = 'daughter')) = 0;











                                                  

