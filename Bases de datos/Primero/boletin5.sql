-- Amosar o dni, nome e apelidos de cada director

select  dni, nomapels from directores;


--  Amosar os datos dos directores que non teñen xefes

select * from directores 
where dnijefe is null;


--  Obter o nome e apelidos de cada director xunto coa capacidade do despacho no que se atopa

select a.nomapels, a.despacho, b.capacidad 
from directores a, despachos b 
where a.despacho=b.numero;


--  Obter o número de directores que hai en cada despacho

select a.numero, count(dni) as dir
from directores b right join despachos a on b.despacho=a.numero 
group by a.numero; 


--  Amosar os datos dos directores cuxos xefes non teñen xefes

select * from directores 
where dnijefe in (select dni from directores where dni in (select dnijefe from directores where dnijefe is not null) and dnijefe is null); 