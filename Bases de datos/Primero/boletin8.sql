-- Amosar o número de ventas de cada producto, ordeado de máis a menos ventas

select a.codigo as producto, a.nombre, count (*) as ventas 
from productos a, venta b
where a.codigo=b.producto
group by a.codigo, a.nombre
order by ventas desc;

--  con nulos: 

select a.codigo as producto, a.nombre, count (b.producto) as ventas 
from productos a left join venta b
on a.codigo=b.producto
group by a.codigo, a.nombre
order by ventas desc;


-- Obter un informe completo de vendas, indicando o nome do caixeiro que realizou a venta, nome e prezo dos productos vendidos e piso no que se atopa a máquina rexistradora na que se realizou a venta

select a.*, b.nomapels, c.nombre, c.precio, d.piso 
from venta a, cajeros b, productos c, maquinas_registradoras d
where a.cajero=b.codigo, a.maquina=d.codigo, a.producto=c.codigo;


-- Obter as ventas totais realizadas en cada piso 

select a.piso as piso, b.count (*) as ventas_totais 
from maquinas_registradoras a, venta b
where a.codigo=b.maquina 
group by a.piso;



-- Obter a suma total das ventas realizadas en cada piso: select piso, sum (precio por producto) donde producto =

select a.piso, sum(b.precio) 
from maquinas_registradoras a left join venta c on a.codigo=c.maquina left join productos b on b.codigo=c.producto 
group by a.piso;


-- Obter o código e nome de cada empregado xunto co importe total das súas ventas 

select b.*, sum(c.precio) as importe_total 
from venta a right join cajeros b on a.cajero=b.codigo left join productos c on a.producto=c.codigo 
group by b.codigo, b.nomapels;


-- Obter o nome e código dos caixeiros que realizaran ventas en pisos con ventas totais inferiores a 500€

select * from cajeros where codigo in (
select cajero from venta where maquina in (
select codigo from maquinas_registradoras where piso in (
select b.piso from productos a join (maquinas_registradoras b join venta c on b.codigo=c.maquina) on a.codigo=c.producto 
group by b.piso 
having sum(nvl(a.precio,0))<500)));

