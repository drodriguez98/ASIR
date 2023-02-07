--  Select the name, job, salary, department number of all employees except SALESMAN from department number 30.

select *  
from emp 
where job <> 'SALESMAN' or deptno <> 30;

-- Display the names of employees with experience of over 10 years

select ename, hiredate as contratacion
from emp 
where (sysdate - hiredate) /365 >= 10; 

--  Find the employees who live in the same cities as the companies for which they work.  

select b.employeename, b.city, c.companyname, c.city
from works a, employee b, company c
where a.employeeid=b.employeeid and a.companyid=c.companyid
and b.city=c.city;

--  Find all employees who live in the same cities and on the same streets as do their managers. 

--   Find all employees who do not work for First Bank Corporation.

select b.employeename as empleado, c.companyname as compañía
from works a, employee b, company c
where a.employeeid=b.employeeid and a.companyid=c.companyid
and c.companyname not in ('FIRST BANK CORPORATION');

--  Find all employees who earn more than every employee of Small BankCorporation.

select * from emp where sal > 
(select max(sal) from works a, emp b, company c where a.companyid=c.companyid and a.employeeid=b.employeeid 
and a.companyid in ('SMALL BANK CORPORATION'));


select * from emp where sal > 
(select max(salary) from works where companyid in ('SMALL BANK CORPORATION'));
