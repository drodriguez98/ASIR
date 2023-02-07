-- Crea unha vista co nome de todos os pa�ses, o id e nome de cada departamento que estea neles.

create view paises 
as
select a.country_name as pais, c.department_id as departamento, c.department_name as nombre
from countries a left join (locations b left join departments c
on b.location_id=c.location_id) on a.country_id=b.country_id;

-- Usando a vista lista todos os pa�ses xunto co n�mero de traballadores por pa�s. 
-- Se un pa�s non ten traballadores debe sa�r un cero. Se non creaches a vista no 
-- exercicio anterior, Fai a select igual sen usala.

select a.country_name as pais, count (d.employee_id) as numempregados
from countries a left join (locations b left join  (departments c left join  employees d 
on d.department_id=c.department_id)
on b.location_id=c.location_id) 
on a.country_id=b.country_id
group by a.country_name;

-- Usando s� a vista selecciona o pa�s cuxo numero de departamentos supera o n�mero 
-- de departamentos do pa�s onde est� o departamento 40

select a.country_name as pais, count (c.department_id) as numdepartamentos
from countries a, locations b, departments c
where a.country_id=b.country_id and b.location_id=c.location_id
group by a.country_name
having count (c.department_id) > 
(select count (c.department_id) from countries a, locations b, departments c
where a.country_id=b.country_id and b.location_id=c.location_id 
and c.department_id=40);

-- Selecciona o nome do empregado e o nome do pa�s no que est� daqueles empregados que 
-- ga�an m�is de 10000 euros usando d�as formas de join. 
-- (Fai d�as selects, unha con cada tipo de join)

select a.first_name as empregado, a.salary as salario, d.country_name as pais
from employees a, departments b, locations c, countries d
where a.department_id=b.department_id and b.location_id=c.location_id and c.country_id=d.country_id
and a.salary > 10000;


select a.first_name as empregado, a.salary as salario, d.country_name as pais
from employees a left join 
(departments b left join 
(locations c left join countries d
on d.country_id=c.country_id)
on c.location_id=b.location_id)
on b.department_id=a.department_id
where a.salary > 10000;

-- Selecciona o nome, salario e salario total (aplic�ndolle a porcentaxe da comisi�n) de 
-- todos os traballadores. Non pode haber ning�n traballador do que non co�ezamos o salario 
-- total.

select first_name as empregado, salary as sincomision, salary + (salary * commission_pct) 
as concomision
from employees
where commission_pct is not null;

-- Selecciona o gasto total en salarios por departamento. Deben sa�r todos os departamentos.

select a.department_name as departamento, sum(b.salary) as gasto_salarial
from departments a left join employees b
on a.department_id=b.department_id
group by a.department_name;

-- Lista os departamentos (id e nome) que non te�en empregados usando alg�n operador 
-- de conxunto.

select department_id as departamento, department_name as nombre
from departments 
minus
select b.department_id, a.department_name from departments a, employees b
where a.department_id=b.department_id;

select department_id as departamento, department_name as nombre
from departments 
minus
select b.department_id, a.department_name from departments a, employees b
where a.department_id=b.department_id
group by b.department_id, a.department_name
having count (*) > 0;

-- Selecciona os departamentos que non te�en empregados usando s� subconsultas

select department_id as departamento, department_name as nombre 
from departments 
where department_id not in 
(select b.department_id from departments a, employees b
where a.department_id=b.department_id
group by b.department_id
having count (*) > 0);









