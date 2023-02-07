--  CONSULTAS SOBRE UNHA TÁBOA

-- 1. Cantos discos hai?

select count(*) as total_discos from disco;

-- 2. Selecciona o nome dos grupos que non sexan de España.

select nombre, pais from grupo where pais != 'ESPAÑA';

-- 3. Obter o título das cancións con máis de 5 minutos de duración.

select titulo, duracion from cancion where duracion > 5;

-- 4. Segundo os datos na base de datos, obter a lista das distintas funcións que se poden realizar nun grupo.

select distinct funcion from pertenece;

-- 5. Selecciona o nome e a sede dos clubs de fans con máis de 500 socios.

select nombre, sede, num from club where num > 500;


--  CONSULTAS SOBRE VARIAS TÁBOAS

-- 6. Obter o nome e a sede de cada club de fans de grupos de España así como o nome do grupo ao que admiran.

select a.nombre as club, a.sede, b.nombre as grupo 
from club a, grupo b where a.cod_gru=b.cod 
and b.pais = 'ESPAÑA'; 

-- 7. Obter o nome dos artistas que pertenzan a un grupo de España.

select b.nombre as artista, c.nombre as grupo, c.pais 
from pertenece a, artista b, grupo c where b.dni=a.dni 
and c.cod= a.cod and c.pais = 'ESPAÑA';

-- 8. Obter o nome dos discos que conteñen algunha canción que dure máis de 5 minutos.     

select b.nombre as disco, c.titulo as cancion, c.duracion 
from esta a, disco b, cancion c where a.cod=b.cod and a.can=c.cod 
and c.duracion > 5;

-- 9. Obter os nomes das cancións que dan nome ao disco no que aparecen.

select b.titulo as cancion, c.nombre as disco 
from esta a, cancion b, disco c where a.can=b.cod and a.cod=c.cod 
and b.titulo=c.nombre;

-- 10. Obter os nomes de compañías e direccións postais daquelas compañías que gravaron algún disco que comeza por A

select a.nombre as compañia, a.dir as direccion, b.nombre as disco 
from companyia a, disco b where a.cod=b.cod_comp 
and b.nombre like 'A%';


--  SUBCONSULTAS

-- 11. Obter o nome dos discos do grupo máis vello.

select nombre as disco, cod_gru as grupo from disco 
where cod_gru in 
(select cod from grupo where fecha in 
(select min(fecha) from grupo));

-- 12. Obter o nome dos discos gravados por grupos con club de fans con máis de 5000 persoas.

select nombre as disco from disco 
where cod_gru in 
(select cod_gru from club where num > 5000);

-- 13. Obter o nome do club con maior número de fans indicando ese número.

select nombre as club, num as fans from club 
where num in 
(select max(num) from club);

-- 14. Obter o título das cancións de maior duración indicando a duración.

select titulo, duracion from cancion 
where duracion in 
(select max(duracion) from cancion);


--  CONSULTAS CON CUANTIFICACIÓN UNIVERSAL

-- 15. Obter o nome das compañías discográficas que non traballaron con grupos españois.    

select nombre from companyia where cod in 
(select cod_comp from disco where cod_gru in
(select cod from grupo where pais != 'ESPAÑA'));

-- 16. Obter o nome das compañías discográficas que só traballaron con grupos españois. 

select nombre from companyia where cod in 
(select cod_comp from disco where cod_gru in 
(select cod from grupo where pais='ESPAÑA')) 
and cod not in 
(select cod_comp from disco where cod_gru in 
(select cod from grupo where pais<>'ESPAÑA'));

-- 17. Obter o nome e a dirección daquelas compañías discográficas que gravasen todos os discos dalgún grupo.   -->     NI IDEA

select nombre,dir from companyia where cod in 
(select cod_comp from disco t where cod_comp in 
(select cod_comp from disco r where r.cod_comp=t.cod_comp 
and cod_gru in (select cod_gru from disco where r.cod_gru=cod_gru)));

select nombre, dir from companyia where cod in 
(select cod_comp from disco where cod_gru in 
(select cod_gru from disco group by cod_gru having count(distinct cod_comp) = 1));


--  CONSULTAS AGRUPADAS

-- 18. Obter o nome dos grupos que sexan de España e a suma dos seus fans.

select a.nombre as grupo, sum(num) as fans 
from grupo a, club b where a.cod=b.cod_gru 
and a.pais='ESPAÑA' 
group by a.nombre;

-- 19. Obter para cada grupo con máis de dous compoñentes o nome e o número de compoñentes do grupo. 

select b.nombre as grupo, count(dni) as compoñentes 
from pertenece a, grupo b where a.cod=b.cod 
group by b.nombre 
having count (dni) > 2 ;

--  20. Obter o número de discos de cada grupo.

select cod_gru, count(*) 
from disco 
group by cod_gru;

-- 21. Obter o número de cancións que gravou cada compañía discográfica e a súa dirección

select b.nombre as compañía, b.dir as direccion, count(*) as cancions_gravadas 
from disco a, companyia b, esta c where a.cod_comp=b.cod and a.cod=c.cod
and a.cod in 
(select cod from esta) 
group by b.nombre, b.dir;


--  CONSULTAS XERAIS

-- 22. Obter o nome dos artistas de grupos con clubs de fans de máis de 500 persoas e que o grupo sexa de Inglaterra.

select nombre as artista from artista 
where dni in 
(select dni from pertenece where cod in 
(select a.cod from grupo a, club b where a.pais = 'INGLATERRA' and b.num > 500));

-- 23. Obter o título das cancións de todos os discos do grupo U2.

select titulo as cancion from cancion 
where cod in 
(select can from esta where cod in 
(select cod from disco where cod_gru in 
(select cod from grupo where nombre = 'U2')));

-- 24. Obter o nome dos artistas que pertencen a máis dun grupo.

select nombre as artista from artista 
where dni in 
(select dni from pertenece group by dni having count(*) > 1);

-- 25. Obter o título da canción de maior duración se é única.   -->     NI IDEA


-- 26. Obter o décimo (debe haber só 9 por encima del) club con maior número de fans indicando ese número.   -->     NI IDEA

select nombre as club, num as fans from club where rownum < 11;

select cod, num, posicion from 
(select cod, num, rownum as posicion from 
(select cod, num from club order by 2 desc))
where posicion = 10;

-- 27. Obter o nome dos artistas que teñan a función de baixo nun único grupo e que ademais este teña máis de dous membros.

select nombre from artista 
where dni in
(select dni from pertenece where funcion='BAJO' group by dni having count (*) = 1)
and dni in
(select dni from pertenece where cod in 
(select cod from pertenece group by cod having count (*) > 2));

--24. Selección sobre todos os pares de artistas de grupos españois distintos tales que o primeiro sexa voz e a segundo guitarra.   -->     NI IDEA

select b.nombre from artista b, pertenece a 
where a.dni=b.dni 
and a.cod in 
(select cod from grupo where pais = 'ESPAÑA') 
and a.funcion= 'VOZ' or a.funcion = 'GUITARRA' 
group by a.cod 
having count(distinct dni) = 2);

select * from pertenece a where  (select cod from grupo where pais = 'ESPAÑA')
and a.funcion = 'VOZ' and a.funcion = 'GUITARRA'  group by b.nombre having count(distinct a.dni)=2;

-- 28. Cal é a compañía discográfica que máis cancións gravou?

select nombre from companyia where cod in 
(select cod_comp from disco a, esta b where a.cod=b.cod group by cod_comp having count (*) =
(select max(count(*)) from disco a, esta b where a.cod=b.cod group by cod_comp));




































