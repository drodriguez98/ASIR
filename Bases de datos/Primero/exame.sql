--  Mostra a matrícula dos vehículos que non foran alugados no ano actual (usa subconsulta non correlada IN)

select matricula from vehiculos 
where matricula not in 
(select matricula from alugueres 
where extract(year from data_inicial) = extract(year from sysdate) 
and matricula is not null);

--  Mostra a matrícula dos vehículos que non foran alugados no ano actual (usa subconsulta correlada EXISTS)

select matricula from vehiculos t
where not exists
(select * from alugueres 
where extract(year from data_inicial) = extract(year from sysdate) 
and matricula = t.matricula);

--  Mostra a matrícula dos vehículos que non foran alugados no ano actual (usa operadores de conxunto)      (+1)

select matricula 
from vehiculos minus
(select matricula from alugueres
where extract (year from data_inicial) = extract (year from sysdate));

--  Mostra a matrícula dos vehículos que non foran alugados no ano actual (usa joins)

select * from vehiculos a 
left join 
(select * from alugueres
where extract (year from data_inicial) = extract (year from sysdate)) b
on a.matricula=b.matricula 
where b.matricula is null order by 1;

--  Mostrar o dni e o nome dos clientes que alugaran algunha vez algún vehículo da marca BMW        (+1)

select a.dni, a.nome as cliente
from clientes a, alugueres b, vehiculos c
where a.dni=b.dni and b.matricula=c.matricula
and c.marca in ('BMW');

--  Mostrar as matrículas dos vehículos alugados, xunto ao total de kilómetros recorridos con cada vehículo e o total de diñeiro gastado no
--  aluguer de cada vehículo, do cliente chamado “José Sánchez”

select a.matricula, sum(a.kilometros), sum(a.num_dias*b.prezo_dia) as prezo_total
from alugueres a, vehiculos b, clientes c
where a.matricula=b.matricula and a.dni=c.dni 
and c.nome in ('José Sánchez')
group by a.matricula;

--  Mostra todas as marcas e, por cada unha, a media de kilómetros que tiveron os vehículos desa marca

select  a.marca, round (avg(nvl(b.kilometros,0)),3) as media_km
from vehiculos a left join alugueres b
on a.matricula=b.matricula 
group by a.marca;

--  Mostra a marca e os kilometros totais recorridos por ela da marca que máis kilometros totais recorreu SIN CORREGIR

select a.marca, sum(b.kilometros) as km_totales
from vehiculos a left join alugueres b 
on a.matricula=b.matricula
group by a.marca 
having sum(b.kilometros) = (select max(sum(kilometros) from alugueres));

--  Fai unha consulta donde se mostren a marca e o modelo dos vehículos que non están alugados hoxe

--  A axencia vai vender os coches que teñan máis de tres anos ou fixeran máis de 50000 kilómetros. Mostra as matrículas dos vehículos que 
--  cumpran esas condicións da táboa Vehículos

select a.matricula, sum(b.kilometros) as km_totais
from vehiculos a, alugueres b
where a.matricula=b.matricula and extract(year from a.data_compra) > (extract(year from sysdate) -3)
group by a.matricula
having sum(b.kilometros) > 50000;

--  Mostrando o dni e nome de todos os socios, para cada un mostra o total de diñeiro que gastaron na empresa de aluguer

select a.dni, a.nombre, sum(b.precio * c.num_dias) as gastos_totales
from clientes  a join (vehichulos b join alugueres c)
on a.dni=c.dni on b.matricula=c.matricula
group by a.dni, a.nombre;

--  Mostrando o dni e nome de todos os socios, para cada un mostra tamén cantos alugueres fixeron

select a.dni, a.nome, count(dni) as alugueres_totais
from clientes a left join alugueres b 
on a.dni=b.dni 
group by a.dni, a.nome;

--  Queremos saber o que gañou a empresa no primeiro trimestre de 2018 cos vehículos alugados a clientes españois

select sum(a.prezo_dia*b.num_dias) as beneficios_2018
from vehiculos a, alugueres b, clientes c
where a.matricula=b.matricula and
b.data_inicial between "1/1/2018" and "31/3/2018" and c.nacionalidade in ('España');

--  Interésanos mostrar os tres vehículos máis alugados xunto coa súa marca

select * from 
(select a.marca, a.matricula, count (*) as alugueres
from vehiculos a, alugueres b 
where a.matricula=b.matricula 
group by a.marca, a.matricula
order by 2 desc)
where rownum <4;

--  Realiza un listado completo de todos os socios, data de aluguer, matricula e modelo do coche alugado