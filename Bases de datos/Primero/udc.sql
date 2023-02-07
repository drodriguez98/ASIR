-- Muestra los puestos de trabajo que hay en cada departamento (código de dept y nombre del puesto de trabajo). No deben aparecer repetidos.

select distinct deptno,job 
from emp;


-- Muestra los códigos de empleados que son jefes. En el resultado no debe aparecer filas con nulos.

select distinct mgr 
from emp 
where mgr is not null;


-- Muestra las ciudades donde se ejecutan proyectos controlados por el departamento 30. No debe aparecer repetidos en el resultado.

select distinct loc 
from pro 
where deptno=30;


-- Muestra empleados que no tienen jefe.

select empno,ename 
from emp 
where mgr is null;


-- Muestra empleados que tengan jefe y que ganen (incluyendo salario y comisión) más de 2500.

select empno,ename,sal,comm 
from emp 
where mgr is not null and 2500 < sal + NVL(comm,0);


-- Muestra los empleados cuyo nombre empieza por ‘S’.

select empno,ename 
from emp 
where ename like 'S%';


-- Muestra los empleados que ganan (incluyendo salario y comisión) entre 1500 y 2500 euros.

select empno,ename,sal,comm 
from emp 
where mgr is not null and sal + NVL(comm,0) between 1500 and 2500;


-- Muestra los empleados que son ‘CLERK’, ‘SALESMAN’ o ‘ANALYST’ y gana (incluyendo salario y comisión) más de 1250

select empno,ename 
from emp 
where sal+NVL(comm,0)>1250 and job in('CLERK','SALESMAN','ANALYST');



--      FUNCIÓNS DE AGREGACIÓN

-- Muestra cuántos empleados hay y a cuánto ascienden sus ingresos (sumando los de todos e incluyendo salario y comisión) que sean SALESMAN o CLERK.

select count(*) as empleados,sum(sal) + sum(NVL(comm,0)) as ingresos 
from emp 
where job in('CLERK','SALESMAN');


-- Cuántos empleados tienen comisión, cuántos no tienen comisión, a cuánto asciende el salario medio, y cuánto asciende la comisión media.

select count(comm) as comisions, count(*) - count(comm) as sincomision, avg(sal) as media_salarios, avg(comm) as media_comisions 
from emp;


-- Cuántos empleados trabajan para los departamentos 20 y 30, y cuántos trabajos distintos se desempeñan en esos departamentos.

select deptno, count(*) as trabajadores, count (distinct job) as trabajos 
from emp 
where deptno='20' or deptno='30' 
group by deptno;


-- Cuántos empleados tienen jefe, cuántos son jefes y cuántos no son jefes.

select count(mgr) as conjefe, count(distinct mgr) as jefes, count(*) - count (distinct mgr) as nojefes 
from emp;


-- Cuántos son los ingresos (salario más comisión) medios de los empleados contratados después del 01-08-1981



--      AGRUPACIÓNS

-- Cuántos empleados hay en cada departamento, cuántos tienen comisión, cuántos no tienen comisión y cuales son los ingresos medios (incluyendo salario y comisión.


-- Muestra los departamentos que tienen empleados con comisión. No puede haber valores repetidos.

select distinct deptno 
from emp 
group by deptno
having count(comm) <> 0;


-- Para cada departamento muestra la comisión media, si no tiene empleados con comisión, se debe indicar con un 0.

select deptno, avg(NVL (comm,0) as media 
from emp 
group by deptno;


-- Para cada departamento muestra cuántos puestos de trabajo distintos desempeñan sus trabajadores.


-- Para cada departamento muestra cuántos empleados hay de cada puesto de trabajo.

select deptno,job,count(*) as empleados 
from emp
group by deptno,job order by 1;


-- Para cada departamento muestra cuántos empleados tienen unos ingresos (sal+comm) superiores a 2500 €.


-- Muestra los departamentos con unos ingresos medios superiores a los 2500 €. Muestra para cada uno, cuántos empleados tienen.

select deptno,count(*) as empleados 
from emp 
group by deptno 
having avg(sal+NVL(comm,0)) > 2500;


-- Departamentos con al menos dos ‘MANAGER’.

select deptno from emp where job='manager' group by deptno having count (*) > 2;

-- Departamentos con al menos dos empleados con comisión. Para cada departamento muestra cuántos empleados tiene (en total) y cuántos con comisión.
-- *******
-- Departamentos con al menos dos empleados con el mismo puesto de trabajo. No puede aparecer repetidos.
-- *******


--      SUBCONSULTAS

-- Empleados que tienen un salario mayor al salario medio de la empresa.

select empno, ename, sal 
from emp 
where sal > (select avg(sal) from emp); 


-- Para cada departamento mostrar cuántos empleados tiene que ganen más del salario medio de la empresa. Muestra el nombre del departamento.

select dname,deptno,count(*)
from emp natural join dept 
where sal > (select avg(sal) from emp) 
group by deptno,dname;


-- Empleados que son jefe. Muestra su nombre.

select ename 
from emp 
where empno in (select mgr from emp);


-- Empleados que no son jefe. Muestra su nombre.

select ename 
from emp 
where empno not in (select mgr from emp where mgr is not null);


-- Muestra el empleado/s (nombre) con el salario más alto.

select ename 
from emp 
where sal=(select max(sal) from emp);


-- Muestra el departamento (nombre) con la suma de salarios más alta.

select dname 
from emp 
natural join dept 
group by deptno, dname 
having sum(sal)=(select max(sum(sal)) from emp group by deptno);


-- Para los departamentos que tienen empleados con comisión, muestra cuántos empleados tienen comisión, y cuántos no. Muestra nombre del departamento.

select dname, count(comm) as con_comision,count(*) - count(comm) as sin_comision 
from emp natural join dept 
where deptno in (select deptno from emp where comm is not null) group by dname;



--      CORRELADAS

-- Muestra el empleado/s con el salario más alto de cada departamento.


-- Muestra el código del empleado/s que más horas trabajan en cada proyecto.


-- Muestra el nombre de empleado/s que más horas trabajan en cada proyecto


-- Muestra el nombre de empleado/s que más horas trabajan en cada proyecto. Muestra también el nombre del proyecto.

select b.ename as trabajador, d.pname as proyecto 
from empro c, emp b, pro d 
where c.empno=b.empno and c.prono=d.prono and c.hours in (select max (hours) from empro where prono = c.prono);


-- Para cada departamento muestra su nombre y cuántos empleados de ese departamento tienen un salario mayor al salario medio de su departamento.

select a.dname as departamento, count(*) as empregados 
from dept a, emp b 
where a.deptno=b.deptno and b.sal > (select avg (sal) from emp where deptno=b.deptno) group by a.dname, a.deptno;


-- Para cada departamento muestra su nombre y cuántos empleados ganan más que su jefe.

select a.dname as departamento, count(*) as empregados 
from dept a, emp b 
where a.deptno=b.deptno and b.sal > (select sal from emp where empno=b.mgr) group by a.dname, a.deptno;

