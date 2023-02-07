-- Amosar o nome das películas

select nombre from peliculas;


-- Amosar tódalas cualificacións por idade que existen

select nombre,calificacionedad from peliculas 
group by calificacionedad,nombre;


-- Obter todas as películas que aínda non foron calificadas

select * from peliculas 
where calificacionedad is null;


-- Obter todas as salas nas que non se proxecta ningunha película

select * from salas 
where pelicula is null;


-- Obter información de todas as salas e, se é proxectada algunha película nela, amosar tamén a información desa película

select a.*, b.nombre, b.calificacionedad 
from salas a left join peliculas b on a.pelicula=b.codigo;


-- Amosar a información de todas as películas e, se non están proxectadas en ningunha sala, amosar tamén a información da sala.

select a.*, b.nombre, b.calificacionedad 
from salas a right join peliculas b on a.pelicula=b.codigo;


-- Amosar o nome de películas que aínda non teñen sala asignada

select * from peliculas 
where codigo not in (select pelicula from salas where pelicula is not null);