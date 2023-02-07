-- Saca a relaci�n completa dos cient�ficos asignados a cada proxecto. Amosar dni, nome , identificador de proxecto e nome.

select a.dni, a.nomapels, c.id, c.nombre 
from cientificos a left join (asignado_a b join proyecto c on b.proyecto=c.id) on a.dni=b.cientifico;


-- Obter o n�mero de proxectos aos que est� asignado cada cient�fico (amosar dni e nome).

select count(a.proyecto) as proyectos, b.dni, b.nomapels as nombre 
from asignado_a a right join cientificos b on a.cientifico=b.dni group by dni, nomapels;


-- Obter o n�mero de cient�ficos asignados a cada proxecto (amosar identificador de proxecto e nome de proxecto).

select count(a.cientifico) as cientificos, b.id, b.nombre as nombre 
from asignado_a a right join proyecto b on a.proyecto=b.id group by id,nombre;


-- Obter o n�mero de horas de dedicaci�n de cada cient�fico.

select a.cientifico, sum(b.horas) as horas_totales 
from asignado_a a, proyecto b where a.proyecto=b.id (+) group by a.cientifico;


-- Obter o dni e nome dos cient�ficos que se adican a m�is dun proxecto e cunha dedicaci�n media a cada proxecto superior a 50h.



