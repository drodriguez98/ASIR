--  5. Obter o título das obras escritas só por un autor se este é de nacionalidade Francesa? indicando tamén o nome do autor.

select a.titulo, b.nombre as autor from obra a, autor b, escribir c where a.cod_ob=c.cod_ob and c.autor_id=b.autor_id and b.nacionalidad='Francesa' and b.autor_id in
(select autor_id from escribir group by autor_id having count(*)=1);

--  6. Obter o título e o identificador dos libros que teñan titulo e máis de dúas obras, indicando o número de obras.

select id_lib, titulo, varias_obras from libro where varias_obras > 2;


--  15. Obter o nome dos amigos que leron todas as obras do autor de identificador RUKI

select nombre, num from amigo where num in 
(select num from prestamo where id_lib in
(select id_lib from libro where id_lib in  
(select id_lib from esta_en where cod_ob in 
(select cod_ob from obra where cod_ob in 
(select cod_ob from escribir where autor_id in 
(select autor_id from autor where autor_id='RUKI'))))));


select nombre from amigo where num in (select num from prestamo where id_lib in
(select id_lib from esta_en where cod_ob in
(select cod_ob from escribir where autor_id in 
(select autor_id from autor where autor_id='RUKI'))));

--  17. Obter o nome dos amigos que leron todas as obras dalgún autor.

select distinct a.nombre 
from amigo a right join (prestamo b join (libro c join (esta_en d join (obra e join (escribir f join autor g on g.autor_id=f.autor_id)
on f.cod_ob=e.cod_ob) on e.cod_ob=d.cod_ob)on d.id_lib=c.id_lib)on c.id_lib=b.id_lib)on b.num=a.num where g.autor_id='RUKI';

--  18. Resolver a consulta anterior indicando tamén o nome dese autor

select distinct a.nombre as amigo, e.nombre as autor from amigo a, prestamo b, esta_en c, escribir d, autor e
where a.num=b.num and b.id_lib=c.id_lib and c.cod_ob=d.cod_ob and d.autor_id=e.autor_id and d.autor_id in 
(select autor_id from escribir where cod_ob in 
(select cod_ob from esta_en));

