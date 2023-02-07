-- Saca a relación completa dos científicos asignados a cada proxecto. Amosar dni, nome , identificador de proxecto e nome.

select a.dni, a.nomapels, c.id, c.nombre 
from cientificos a left join (asignado_a b join proyecto c on b.proyecto=c.id) on a.dni=b.cientifico;


-- Obter o número de proxectos aos que está asignado cada científico (amosar dni e nome).

select count(a.proyecto) as proyectos, b.dni, b.nomapels as nombre 
from asignado_a a right join cientificos b on a.cientifico=b.dni group by dni, nomapels;


-- Obter o número de científicos asignados a cada proxecto (amosar identificador de proxecto e nome de proxecto).

select count(a.cientifico) as cientificos, b.id, b.nombre as nombre 
from asignado_a a right join proyecto b on a.proyecto=b.id group by id,nombre;


-- Obter o número de horas de dedicación de cada científico.

select a.cientifico, sum(b.horas) as horas_totales 
from asignado_a a, proyecto b where a.proyecto=b.id (+) group by a.cientifico;


-- Obter o dni e nome dos científicos que se adican a máis dun proxecto e cunha dedicación media a cada proxecto superior a 50h.



