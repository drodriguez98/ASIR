--  1. Listaxe de toda a información dos empregados, excepto os seus salarios.

select a.*, b.* from templeados a, tdep b where a.cod_dep=b.cod_dep;

--  2. Listaxe dos nomes e cargos de todos os empregados.

select nombre, cargo from templeados;

--  3. Listaxe dos nomes dos empregados con cargos de 'contable' ou 'comercial'

select nombre, cargo from templeados where cargo='contable' or cargo='comercial';

--  4. Listaxe dos nomes dos empregados que se incorporaron desde o 2003

select nombre, anno_incorp from templeados where anno_incorp >= 2003;

--  5. Ordenar a consulta anterior por nome (crecente). Se dous ou máis empregados chámanse igual, ordenalos por DNI (descendente).

select nombre, anno_incorp from templeados where anno_incorp >= 2003 order by nombre asc, dni desc;

--  6. Listar todos os cargos existentes. Cada cargo, obviamente non debe aparecer máis dunha vez.

select distinct cargo from templeados;

--  7. Mostrar o nome dos contables que se incorporaron no ano 2005.

select nombre, cargo, anno_incorp from templeados where cargo='contable' and anno_incorp >= 2005;

--  8. Mostar os nomes dos empregados que non teñen asignado ningún cargo concreto.

select nombre, cargo from templeados where cargo is null;

--  9. Mostar os nomes dos empregados que teñen asignado cargo.

select nombre, cargo from templeados where cargo is not null;

--  10. Listar o DNI e o salario dos empregados incrementado nun 3%

select a.dni, a.nombre as empleado, b.salario * 1.03 as salario from templeados a, tsalarios b where a.dni=b.dni;

--  11. Listar o DNI e o salario dos empregados supoñendo que se lles gratifica con 100€.

select a.dni, a.nombre as empleado, b.salario + 100 as salario from templeados a, tsalarios b where a.dni=b.dni;

--  12. Mostar cuantos empregados non teñen asignado un cargo concreto. 

select count (*) as sin_cargo from templeados where cargo is null;

--  13. Mostar o salario máis baixo

select min(salario) as salario_minimo from tsalarios;


--      AGRUPAMIENTOS

--  14. Mostrar o salario total (suma dos salarios) de cada empregado xunto co seu DNI.

select dni, sum(salario) as salario_total
from tsalarios
group by dni;

--  15. Mostrar o número de empregados contratados cada ano

select anno_incorp as ano, count (*) as empregados_contratados 
from templeados 
group by anno_incorp;

--  16. Mostrar o número de empregados por cada departamento

select a.cod_dep as departamento, a.nombre, count (*) as empregados 
from tdep a, templeados b 
where a.cod_dep=b.cod_dep 
group by a.cod_dep, a.nombre;

--  17. Mostrar o número de empregados contratados cada ano desde 2001.

select anno_incorp as ano, count (*) as empregados_contratados 
from templeados 
where anno_incorp >= 2001 group by anno_incorp;


--      JOIN NATURAL

--  19. Listar os DNIs dos colaboradores dos departamentos de 'contabilidade', 'vendas', e 'legal'.

select a.dni, b.nombre as departamento 
from tcolaboradores a, tdep b 
where a.cod_dep=b.cod_dep 
and b.nombre='contabilidade' or b.nombre='vendas' or b.nombre='legal';

--   20. Calcular o custo salarial do departamento de 'vendas' 

select sum(salario) 
from tsalarios a, tdep b, templeados c 
where a.dni=c.dni and b.cod_dep=c.cod_dep 
and b.nombre='vendas';

--  21. Calcular o salario medio dos empregados incorporados no ano 2003.

select avg (salario) as salario_medio 
from tsalarios a, templeados b 
where a.dni=b.dni and b.anno_incorp = 2003;

--  22. Listar o nome de cada empregado e o máximo dos seus salarios, sempre que a suma dos seus salarios sexa superior a 3.000€ e non pertenza ao departamento de 'enxeñaría'.

select a.nombre, max(salario) as salario_maximo
from templeados a, tsalarios b
where a.dni=b.dni 
and a.cod_dep not in (select cod_dep from tdep where nombre='enxeñaría' and cod_dep is not null) 
group by a.dni, a.nombre 
having sum(b.salario) > 3000;


--      SUBCONSULTAS

--  23. Mostrar, usando unha subconsulta, os nomes dos empregados que non dirixen ningún departamento. (2 formas de hacerlo)

select dni, nombre 
from templeados 
where dni not in (select a.dni from templeados a, tdep b where a.dni=b.dni_resp);

select a.* from templeados a left join tdep b on a.dni=b.dni_resp where b.cod_dep is null;


--  24. Mostrar os nomes dos empregados daqueles departamentos que non teñen colaboradores

select nombre 
from templeados 
where cod_dep not in (select cod_dep from tcolaboradores where cod_dep is not null);


--  25. Listar os nomes dos departamentos que non teñen empregados

select nombre as depts_sen_empregados 
from tdep 
where cod_dep not in 
(select cod_dep from templeados);


--  26. Listar os nomes dos empregados con máis dun salario --> MAL

select *
from templeados
where dni in 
(select dni from tsalarios group by dni having count(*) > 1);


--      COMBINACIÓNS (UNION, INTERSECCIÓN, EXCEPT)


--  27. Mostrar os nomes de todos os recursos humanos da empresa: empregados e colaboradores



--  28. Mostar os DNIs dos empregados que non son directivos

select dni from templeados minus select dni_resp from tdep;

--  29. Mostrar os nomes e os DNIs dos empregados que traballan como colaboradores externos dalgún departamento.


