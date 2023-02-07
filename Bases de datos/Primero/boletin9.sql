--  Obter o dni e nome daqueles investigadores que realizaran máis dunha reserva

select a.dni, a.nomapels 
from investigadores a, reserva b 
where a.dni=b.dni 
group by a.dni, a.nomapels 
having count(*) > 1;


--  Obter un listado completo de reservas incluindo o seguinte: ->>> MAL

    --  - dni e nome do investigador, xunto co nome da súa facultade
    --  - número de serie e nome do equipo reservado, xunto co nome da facultade á que pertence
    --  - data do comezo e fin da reserva


select a.dni, b.nomapels as investigador, b.facultad as cod_fac, c.nombre as facultad, d.numserie, d.nombre as equipo, a.comienzo, a.fin 
from reserva a, investigadores b, facultad c, equipos d 
where a.dni=b.dni and a.numserie=d.numserie and (b.facultad=c.codigo or c.codigo = d.facultad);

    
--  Obter o dni e o nome dos investigadores que reservaran equipos que non son da súa facultade



--  Obter os nomes das facultades nas que ningún investigador realizara unha reserva (2 formas de hacerlo)

select codigo, nombre 
from reserva natural join investigadores right join facultad on codigo=facultad 
group by codigo,nombre 
having count(dni)=0;

select * from facultad 
where codigo not in
(select codigo from reserva natural join investigadores join facultad on codigo=facultad 
where codigo is not null);


--  Obter os nomes das facultades con investigadores que non realizaran ningunha reserva ->>> SIN CORREGIR

select nombre 
from facultad 
where codigo not in 
(select codigo from reserva natural join investigadores right join facultad on codigo=facultad 
group by codigo 
having count(dni)=0);


--  Obter o número de serie e nome dos equipos que nunca foron reservados (Varias formas de hacerlo)

select * 
from equipos 
where numserie not in 
(select numserie from reserva where numserie is not null);

select b.numserie, b.nombre 
from reserva a right join equipos b on a.numserie=b.numserie 
group by b.numserie, b.nombre 
having count(a.dni)=0;
