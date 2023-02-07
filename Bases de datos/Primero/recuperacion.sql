-- Crea unha vista co nome de todos os países, o id e nome de cada departamento que estea neles.

create view paises 
as
select a.country_name as pais, c.department_id as departamento, c.department_name as nombre
from countries a left join (locations b left join departments c
on b.location_id=c.location_id) on a.country_id=b.country_id;

-- Usando a vista lista todos os países xunto co número de traballadores por país. 
-- Se un país non ten traballadores debe saír un cero. Se non creaches a vista no 
-- exercicio anterior, Fai a select igual sen usala.

select a.country_name as pais, count (d.employee_id) as numempregados
from countries a left join (locations b left join  (departments c left join  employees d 
on d.department_id=c.department_id)
on b.location_id=c.location_id) 
on a.country_id=b.country_id
group by a.country_name;

-- Usando só a vista selecciona o país cuxo numero de departamentos supera o número 
-- de departamentos do país onde está o departamento 40

select a.country_name as pais, count (c.department_id) as numdepartamentos
from countries a, locations b, departments c
where a.country_id=b.country_id and b.location_id=c.location_id
group by a.country_name
having count (c.department_id) > 
(select count (c.department_id) from countries a, locations b, departments c
where a.country_id=b.country_id and b.location_id=c.location_id 
and c.department_id=40);

-- Selecciona o nome do empregado e o nome do país no que está daqueles empregados que 
-- gañan máis de 10000 euros usando dúas formas de join. 
-- (Fai dúas selects, unha con cada tipo de join)

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

-- Selecciona o nome, salario e salario total (aplicándolle a porcentaxe da comisión) de 
-- todos os traballadores. Non pode haber ningún traballador do que non coñezamos o salario 
-- total.

select first_name as empregado, salary as sincomision, salary + (salary * commission_pct) 
as concomision
from employees
where commission_pct is not null;

-- Selecciona o gasto total en salarios por departamento. Deben saír todos os departamentos.

select a.department_name as departamento, sum(b.salary) as gasto_salarial
from departments a left join employees b
on a.department_id=b.department_id
group by a.department_name;

-- Lista os departamentos (id e nome) que non teñen empregados usando algún operador 
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

-- Selecciona os departamentos que non teñen empregados usando só subconsultas

select department_id as departamento, department_name as nombre 
from departments 
where department_id not in 
(select b.department_id from departments a, employees b
where a.department_id=b.department_id
group by b.department_id
having count (*) > 0);









