-- Obte-los datos de coches (marca, nome, modelo) vendidos polos concesionarios de Madrid, ordenado por marca e nome do coche.

select a.nombre as coche, a.modelo, b.nombre as marca
from coches a, marcas b, ventas c, concesionarios d
where a.codmarca=b.codmarca and a.codcoche=c.codcoche and c.codconc=d.codconc
and d.ciudad = 'MADRID'
order by b.nombre, a.modelo;

--  Obte-lo número total de coches turbodiésel (o modelo leva as letras 'TD'  nalgunha parte da palabra) dispoñibles no conxunto de concesionarios

select sum (cantidad) as coches_turbodiesel 
from coches a, distribucion b 
where a.codcoche=b.codcoche 
and a.modelo like ('%TD%');

-- Obte-la media de automóbiles que teñen todos os concesionarios

select avg (sum (cantidad)) from distribucion group by codconc;

select avg(sum(nvl(a.cantidad,0))) as media_coches 
from distribucion a right join concesionarios b 
on a.codconc=b.codconc 
group by b.codconc;

-- Obte-los códigos de coches vendidos a clientes de Madrid

select a.codcoche from ventas a, clientes b
where a.dni=b.dni 
and b.ciudad = 'MADRID';

-- Obte-los códigos de coches vendidos a clientes de Madrid en concesionarios de Madrid

    -- Con join
select a.codcoche from ventas a, clientes b, concesionarios c
where a.dni=b.dni and a.codconc=c.codconc
and b.ciudad = 'MADRID' and c.ciudad = 'MADRID';

    -- Con subconsulta

select codcoche from ventas where dni in 
(select dni from clientes where ciudad = 'MADRID') 
and codconc in 
(select codconc from concesionarios where ciudad = 'MADRID');

-- Obte-los datos persoais de clientes que compraron os coches en concesionarios de cidades diferentes da que residen, ordeado por apelidos e nome

select b.* from ventas a, clientes b, concesionarios c
where a.dni=b.dni and a.codconc=c.codconc and b.ciudad <> c.ciudad
order by b.apellidos, b.nombre;

-- Obte-los datos persoais dos clientes que compraron un coche nalgún concesionario de Madrid, ordenado por dni

select * from clientes where dni in 
(select dni from ventas where codconc in
(select codconc from concesionarios where ciudad = 'MADRID'));

--  Obte-la lista ordeada alfabéticamente de concesionarios que dispoñan de menos de 3 modelos de coche

select nombre from concesionarios where codconc in
(select codconc from distribucion a, coches b where a.codcoche=b.codcoche group by codconc having count (distinct b.modelo) < 3);

--  Obter unha lista ordenada dos modelos de coches (nome da marca, nome do coche, modelo de coche) e as unidades dispoñibles no conxunto de concesionarios      

select modelo, sum (cantidad) as unidades_dispoñibles
from coches a, marcas b, distribucion c
where a.codmarca=b.codmarca and a.codcoche=c.codcoche
group by modelo;

--  Obtelos datos das ventas (datos do coche e comprador) de calquera vehículo das seguintes marcas: Renault, Citroen, Audi, Opel ou Mercdes

select b.*, c.* from ventas a, clientes b, coches c, marcas d
where a.dni=b.dni and a.codcoche=c.codcoche and c.codmarca=d.codmarca
and d.nombre in ('RENAULT', 'CITROEN', 'AUDI', 'OPEL', 'MERCEDES');

-- Obter nome e apelidos dos clientes que adquiriron como mínimo un coche branco e un coche vermello

select nombre, apellidos from clientes 
where dni in 
(select dni from ventas where color='BLANCO')
and dni in 
(select dni from ventas where color = 'ROJO');

--  Obte-los nomes dos clientes que non teñan comprado ningún coche vermello a ningún concesionario de Madrid

select nombre, apellidos from clientes where dni not in 
(select distinct dni from ventas a, concesionarios b where a.codconc=b.codconc and a.color='ROJO' and b.ciudad='MADRID');

--  Obte-lo concesionario que non sexa de Madrid, tal que a súa media de vehículos en stock sexa a máis alta de tódalas medias

select codconc as concesionario 
from concesionarios 
where ciudad != 'MADRID' 
and codconc in 
(select codconc from distribucion group by codconc having avg(cantidad) = 
(select (max (avg (cantidad))) from distribucion group by codconc));























