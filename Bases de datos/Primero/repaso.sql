/* Consultas sobre unha sola relaci�n */

/* 1 - Cantos discos hai */

select count(*) from disco;

/* 2 - Selecciona o nome dos grupos que non sexan de Espa�a */

select nome from grupo where pais <> 'ESPA�A';

/* 3 - Obter o t�tulo das canci�ns con m�is de 5 minutos de duraci�n*/

select titulo from cancion where duracion > 5;

/* 4 - Obter a lista das distintas funci�ns nun grupo */

select distinct funcion from pertenece;

/* 5 - Nome e sede dos clubs de fans con m�is de 500 socios */

select nombre, sede from club
where num > 500;

/* Consutlas sobre varias t�boas */

/* 6 - Nome e sede de cada club de grupos de Espa�a
asi como o nome do grupo ao que admiran */

select a.nombre, a.sede, b.nombre from club a, grupo b
where b.cod=a.cod_gru and pais = 'ESPA�A';

/* 7 - Nome dos artistas que pertenzan a un grupo de Espa�a */

select a.nombre from artista a, pertenece b, grupo c where
a.dni=b.dni and b.cod=c.cod and c.pais='ESPA�A';

/* 8 - Nome dos discos que conte�en algunha cancion de m�is de
5 minutos */

select a.nombre from disco a, esta b, cancion c where a.cod=b.cod 
and b.can=c.cod and c.duracion > 5;

/* 9 - Nomes das canci�ns que dan nome ao disco */

select a.nombre from disco a, esta b, cancion c where a.cod=b.cod 
and b.can=c.cod and c.titulo=a.nombre;

/* 10 - Nomes das compa��as e direcci�ns postais
que gravaron alg�n disco que comeza por A */

select a.nombre, dir from companyia a, disco b
where a.cod=b.cod_comp and b.nombre like 'A%';

/* Subconsultas */

/* 11 - Obter o nome dos discos do grupo m�is vello.*/

select a.nombre from disco a, grupo b where
a.cod_gru = b.cod and a.cod_gru = (select cod from grupo where fecha = 
(select min(fecha) from grupo));

/* 12 - Obter o nome dos discos gravados por grupos con club de fans con m�is de 5000 persoas */

select nombre from disco where cod_gru in 
(select cod_gru from club where num > 500);

/* 13 -  Obter o nome dos clubs con maior n�mero de fans indicando ese n�mero. */

select nombre, num from club where num =
(select max(num) from club);

/* 14 - Obter o t�tulo das canci�ns de maior duraci�n indicando a duraci�n. */

select titulo, duracion from cancion where duracion in
(select max(duracion) from cancion);

/* Consultas con cuantificaci�n universal */
/* 15. Obter o nome das compa��as discogr�ficas que non traballaron con grupos espa�ois. */

select nombre from companyia where cod in (select cod_comp from disco where cod_gru in
(select cod from grupo where pais != 'ESPA�A'));

/* 16. Obter o nome das compa��as discogr�ficas que s� traballaron con grupos espa�ois. */

select nombre from companyia where cod in (select cod_comp from disco where cod_gru in
(select cod from grupo where pais = 'ESPA�A')) and cod not in 
(select cod_comp from disco where cod_gru in (select cod from grupo where pais != 'ESPA�A') and cod_comp is not null);

/* 17. Obter o nome e a direcci�n daquelas compa��as discogr�ficas que gravasen todos os discos
dalg�n grupo. */

select nombre, dir from companyia where cod in 
(select cod_comp from disco where cod_gru in 
(select cod_gru from disco group by cod_gru having count(distinct cod_comp) = 1));

/* Consultas agrupadas */

/* 18. Obter o nome dos grupos que sexan de Espa�a e a suma dos seus fans. */

select a.nombre, sum(b.num) from grupo a, club b where a.pais = 'ESPA�A' and a.cod=b.cod_gru group by a.nombre;

/* 19. Obter para cada grupo con m�is de dous compo�entes o nome e o n�mero de compo�entes do
grupo. */

select a.nombre, count(*) from grupo a, pertenece b 
where a.cod=b.cod group by a.nombre having count(*) > 2;


/* 20. Obter o n�mero de discos de cada grupo. */

select cod_gru, count(*) from disco group by cod_gru;

/* 21. Obter o n�mero de canci�ns que gravou cada compa��a discogr�fica e a s�a direcci�n */

select a.nombre, dir, count(*) from companyia a, disco b, esta c 
where a.cod=b.cod_comp and b.cod=c.cod group by a.nombre, a.dir;

/* Consultas xerais */

/* 22. Obter o nome dos artistas de grupos con clubs de fans de m�is de 500 persoas e que o grupo
sexa de Inglaterra. */

select nombre from artista where dni in
(select dni from pertenece where cod in (select cod from grupo where pais = 'INGLATERRA')
and cod in (select cod_gru from club where num > 500));

/* 23. Obter o t�tulo das canci�ns de todos os discos do grupo U2. */

select titulo from cancion where cod in (select can from esta where cod in
(select cod from disco where cod_gru in 
(select cod from grupo where nombre = 'U2')));

/* 24. O d�o din�mico por fin xub�lase; para substitu�rlles pret�ndese facer unha selecci�n sobre todos
os pares de artistas de grupos espa�ois distintos tales que o primeiro sexa voz e a segundo guitarra.
Obter dita selecci�n. */
/* seleccionar artistas de grupos espa�oles que son voz y guitarra */ 
select dni, cod from pertenece where cod in 
(select cod from grupo where pais = 'ESPA�A') and (funcion = 'VOZ' or funcion='GUITARRA') order by 2;

/* 25. Obter o nome dos artistas que pertencen a m�is dun grupo. */ 

select nombre from artista where dni in 
(select dni from pertenece group by dni having count(*) > 1);

/* 26. Obter o t�tulo da canci�n de maior duraci�n se � �nica. */
/* ni puta idea  loco */

select titulo from cancion where duracion = 
(select max(duracion) from cancion)
group by titulo;
select max(duracion) from cancion;

/* 27. Obter o d�cimo (debe haber s� 9 por encima del) club con maior n�mero de fans
indicando ese n�mero. */

select cod, num, posicion from 
(select cod, num, rownum as posicion from 
(select cod, num from club order by 2 desc))
where posicion = 10;

/* 28. Obter o nome dos artistas que te�an a funci�n de baixo nun �nico grupo e que ademais este te�a
m�is de dous membros. */

select nombre from artista where dni in (select dni from pertenece where funcion = 'BAJO'
group by dni having count(*) = 1) and dni in (select dni from pertenece where cod in
(select cod from pertenece group by cod having count(*) > 2));

/* 29. Cal � a compa��a discogr�fica que m�is canci�ns gravou?*/ 

select nombre from companyia where cod in (
select cod_comp from disco a, esta b where a.cod=b.cod group by cod_comp having count(*) =
(select max(count(*)) from disco a, esta b where a.cod=b.cod group by cod_comp));




















