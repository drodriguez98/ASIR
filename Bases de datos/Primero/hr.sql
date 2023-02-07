-- Obter un listado completo de todos os departamentos xunto co gasto total en salarios e número de empregados.

select a.department_name as departamento,  sum (c.salary) as gasto_salarial, count (b.employee_id) as num_empregados 
from departments a left join job_history b 
on a.department_id=b.department_id 
left join employees c 
on b.employee_id=c.employee_id 
group by a.department_name;

        -- correccion:
        
select a.department_name as departamento,  sum (b.salary) as gasto_salarial, count (b.employee_id) as num_empregados 
from departments a left join employees b on a.department_id=b.department_id 
group by a.department_name;

-- Obter o nome e apelidos dos empregados que traballen en departamentos situados en España.
-- Faino con joins e de novo con subconsultas.

select a.first_name as nombre, a.last_name as apellidos
from employees a, departments b,  locations c, countries d
where a.department_id=b.department_id and b.location_id=c.location_id and c.country_id=d.country_id
and d.country_name='ESPAÑA';

select first_name as nombre, last_name as apellidos 
from employees a where department_id in 
(select department_id from departments where location_id in
(select location_id from locations where country_id in
(select country_id from countries where country_name='ESPAÑA')));

--  Que empregado de US é mánager de máis empregados? Indicar de cantos empregados é manager

select a.first_name as nombre, a.last_name as apellidos, count (*) as numero_empregados
from employees a,  departments b, locations c, countries d
where a.department_id=b.department_id and a.employee_id=b.manager_id and b.location_id=c.location_id and c.country_id=d.country_id
and d.country_name= 'UNITED STATES OF AMERICA' 
and b.department_id in
(select department_id from employees group by department_id having count (*) =
(select max (count (*) from employees group by department_id)))
group by a.first_name, a.last_name;


--  Selecciona o departamento cuxo número de empregados supera o número de empregados do departamento onde está o empregado de código 100

select a.department_name as departamento from departments a, employees b 
where a.department_id=b.department_id
group by department_name having count(b.employee_id) >
(select count (employee_id) from employees where employee_id=100 group by department_id);


--  Selecciona o nome, salario e salario total (aplicandolle a porcentaxe da comisión) de todos os traballadores. 
--  Non pode haber ningún traballador do que non coñezamos o salario total.

select first_name as empleado, salary as salario, salary + (salary * commission_pct) as salario_total 
from employees where commission_pct is not null;

        -- correccion:
    
select first_name as empleado, salary as salario, salary + (salary * commission_pct) as salario_total 
from employees;
        

-- Obter o nome dos empregados que realizaran máis dun traballo no pasado.

select a.first_name as empleado from employees a, job_history b, jobs c
where a.employee_id=b.employee_id and b.job_id=c.job_id 
group by a.first_name 
having count (b.job_id) > 1;


--  Amosar os empregados cuxo nome empeza por A que non teñan traballos previos. Usar Joins

select a.first_name as empleado from employees a, job_history b, jobs c
where a.employee_id=b.employee_id and b.job_id=c.job_id  
and a.first_name like 'A%'
group by a.first_name 
having count (b.job_id) = 0;

--  Obter unha listaxe de todos os empregados que pertencen ao mesmo departamento que Stephen King

select first_name from employees where department_id in
(select a.department_id from departments a, employees b where a.department_id=b.department_id and
b.first_name='Steven' and last_name='King');

--  Amosar os empregados cuxo nome empeza por A que non teñan traballos previos. Usar operadores de conxunto.

select employee_id as empleado from employees where first_name like 'A%' 
intersect 
(select employee_id as empleado from job_history b group by employee_id having count (*) = 0);

select employee_id as empleado from employees where first_name like 'A%' 
minus 
(select employee_id as empleado from job_history b group by employee_id having count (*) = 0);

--  Obter o número de empregados que hai en cada departamento (deben saír todos os departamentos)

select a.department_name, count (*) as num_empregados 
from departments a left join employees b on a.department_id=b.department_id 
group by a.department_name;






















