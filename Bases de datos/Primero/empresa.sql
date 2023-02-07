--          PR�CTICA 3

-- 1. Hallar la comisi�n, el nombre y el salario de los empleados con m�s de tres hijos, ordenados por comisi�n y, dentro de comisi�n, alfab�ticamente.

select nombre, comision, salario, num_hijos 
from empleados 
where num_hijos > 3 
order by comision;

-- 2. Obtener los nombres de los departamentos que no dependen de otros.

select nombre 
from departamentos 
where depto_jefe is null;

-- 3. Obtener, por orden alfab�tico, los nombres y los salarios de los empleados cuyo salario est� comprendido entre 1250 y 1300 euros.

select nombre, salario 
from empleados 
where salario between 1250 and 1300 
order by nombre;

-- 4. Datos de los empleados que cumplen la condici�n anterior o tienen al menos un hijo.

select * 
from empleados 
where salario between 1250 and 1300 and num_hijos >= 1 
order by nombre;

-- 5. Muestre para cada empleado el n�mero de meses que lleva el empleado en la empresa junto con su nombre.            *****

-- 6. Calcule aquellos empleados que llevan m�s de 35 a�os en la empresa. Muestre todos los datos de cada uno de ellos.     *****

-- 7. Hallar, por orden alfab�tico, los nombres de los empleados tales que si se les da una gratificaci�n de 10 euros por hijo, el total de esta gratificaci�n no supera la cent�sima parte del salario.

select nombre 
from empleados 
where num_hijos * 10 <= 0.1 * salario;

-- 8. Hallar, por orden de n�mero de empleado, el nombre y el salario total (salario m�s comisi�n) de los empleados cuyo salario total supera los 1300 euros mensuales.

select nombre, salario + comision as salario_total 
from empleados 
where salario + comision > 1300 
order by cod;

-- 9. Obtener, por orden alfab�tico, los nombres de los departamentos que no contengan la palabra 'Direcci�n' ni 'Sector'          SIN CORREGIR

select nombre 
from departamentos 
where nombre not in ('sector', 'direccion') 
order by nombre;

-- 10. Obtener, por orden alfab�tico, los nombres de los departamentos que, o bien tienen directores en funciones y su presupuesto no excede los 5 mil euros, o bien no dependen de ning�n otro departamento.

select nombre 
from departamentos 
where (tipo_dir = 'F' and presupuesto <= 5000) or (depto_jefe is null);


--          PR�CTICA 4

-- 1. Hallar el n�mero de empleados de toda la empresa.

select count (*) as total_empleados 
from empleados;

-- 2. Hallar cu�ntos departamentos existen y el presupuesto anual medio de la empresa para el global de todos los departamentos.

select count (distinct nombre) as total_departamentos, avg (presupuesto) as presupuesto_medio 
from departamentos;

-- 3. Hallar el n�mero de empleados y de extensiones telef�nicas distintas del departamento 112.

select count(cod), count(telefono) 
from empleados 
where departamento not in '112';

-- 4. Idem para los departamentos que no tienen director en propiedad.

select count(numero), count(telefono)
from empleados a, departamentos b
where a.departamento=b.numero and b.director is null;

-- 5. Datos de los empleados que trabajan en un centro con direcci�n en calle Atocha (cualquier n�mero y ciudad) y tienen dos hijos exactamente. No use subconsultas anidadas.

select a.*, b.nombre, c.direccion from empleados a, departamentos b, centros c
where a.departamento=b.numero and b.centro=c.numero
and a.num_hijos = 2 and c.direccion like '%C. ATOCHA%';

-- 6. Extraiga los nombres de las parejas de empleados que trabajan en el mismo centro y tienen los mismos ingresos como salario base. No use subconsultas anidadas. Visualizar tambi�n el salario.



-- 7. Utilice las operaciones de conjuntos para extraer los c�digos de los departamentos que no hacen de departamento jefe.



-- 8. Idem pero que s� hacen de departamento jefe de alg�n otro departamento.



-- 9. Extraiga un listado donde aparezca el c�digo de los departamentos y su nombre conjuntamente con el c�digo de los centros en donde est�n situados y el nombre de estos centros.

select a.numero as cod_depart, a.nombre as departamento, b.numero as cod_centro, b.nombre as centro
from departamentos a, centros b
where a.centro=b.numero;

-- 10. Utilice las operaciones de conjuntos para solventar la consulta n�mero 4 de la relaci�n anterior.


--          PR�CTICA 5

--  1. Hallar los siguientes datos para cada departamento:

    -- N�mero de empleados. 
    -- Salario medio. 
    -- Salario m�ximo y m�nimo. 
    -- Varianza y desviaci�n t�pica del salario.
    -- Media de las comisiones.
    -- N�mero de comisiones que hay distintas.
    -- Media de las comisiones que hay distintas.
    
--  2. Calcular el salario medio, el salario medio por hijo y la comisi�n media de aquellos grupos de empleados que tienen igual n�mero de hijos.
--  3. Calcular la media y la varianza del n�mero de hijos de aquellos empleados que tienen el mismo tel�fono y pertenecen al mismo departamento.
--  4. Calcular cuantos n�meros de tel�fono usa cada departamento, mostrando el c�digo y el nombre de cada departamento.
--  5. Mostrar los n�meros de tel�fono que est�n asignados a m�s de un empleado, indicando a cu�ntos empleados est� asignado cada uno.
--  6. Mostrar los n�meros de tel�fono que est�n asignados a m�s de un departamento, indicando a cu�ntos departamentos est� asignado cada uno.
--  7. Seleccionar n�mero, nombre, presupuesto y presupuesto por empleado, de aquellos departamentos cuyo presupuesto por empleado sea mayor que el presupuesto m�nimo. Ordenar el resultado alfab�ticamente por el nombre. 
--  8. Mostrar los departamentos (n�mero y nombre) con sus centros (n�mero y nombre) y la edad media de sus empleados de aquellos departamentos que tienen una edad media en sus empleados mayor a 35 a�os.

--  9. Cree una vista llamada DPTOS_JEFES que contenga los siguientes datos para cada departamento que sea jefe de otro departamento: 

    --  n�mero, nombre  y presupuesto del departamento
    --  n�mero y nombre de su director
    --  suma de los presupuestos de todos los departamentos que son supervisados por �l.

--          FALTAN********


--          PR�CTICA EXTRA

-- 1. Hallar, para cada departamento, el salario medio, el m�nimo y el m�ximo.
-- 2. Agrupando por departamento y n�mero de hijos, hallar cu�ntos empleados hay en cada grupo.
-- 3. Para cada extensi�n telef�nica, hallar cu�ntos empleados la usan y el salario medio de �stos.
-- 4. Para los departamentos en los que hay alg�n empleado cuyo salario sea superior a 400 euros mensuales, hallar el n�mero de empleados y la suma de sus salarios, de sus comisiones y el n�mero total de hijos.
-- 5. Hallar el salario m�ximo y el m�nimo para cada grupo de empleados con igual n�mero de hijos exceptuando los que no tienen, pero s�lo si hay m�s de un empleado en el grupo y el salario m�ximo del grupo excede los 200 euros.
-- 6. Listar ordenadamente los n�meros tel�fonos adscritos a los departamentos que tienen m�s de dos n�meros de tel�fono diferentes siendo cada uno de ellos compartido por menos de cuatro empleados. Excluir de �ste listado los n�meros de tel�fono que no son compartidos.
-- 7. Obtener, por orden alfab�tico, los nombres y las comisiones de los empleados del departamento 110, si es que hay en �l alg�n empleado que tenga comisi�n.
-- 8. Obtener, por orden alfab�tico, los nombres de los empleados cuyo salario supera a todos los salarios de los empleados del departamento 122.
-- 9. Repetir la consulta anterior para un departamento inexistente, por ejemplo el 150. �Cu�l es el resultado?
-- 10. Obtener, por orden alfab�tico, los nombres de los empleados cuyo salario es igual o superior al menor de los salarios de los empleados del departamento 122.
-- 11. Obtener, por orden alfab�tico, los nombres y los salarios de los empleados cuyo salario coincide con la comisi�n de cualquier otro o la suya propia.
-- 12. Obtener, por orden alfab�tico, los nombres y los salarios de los empleados cuyo salario es inferior a la m�s alta comisi�n existente.
-- 13. Para los departamentos cuyo salario medio supera al promedio de la empresa, hallar cu�ntas extensiones telef�nicas tienen.
-- 14. Datos de los empleados que trabajan a las �rdenes de un jefe que no tiene a su vez a otro subordinado con un n�mero de hijos mayor que el del primero.
-- 15. Datos de los empleados que cobran el salario m�ximo de su departamento y est�n por encima del salario medio de la empresa.
-- 16. Datos de los centros que albergan 2 departamentos, siendo todos ellos de m�s de 4 empleados.
-- 17. Idem que la anterior, pero con �m�s de 4 empleados que cobren m�s de 200�.
-- 18. Idem que la anterior pero con �alguno de ellos cobra m�s de 200�
-- 19. Datos de los empleados que trabajan en departamentos que tienen el menor n�mero de empleados de toda la empresa.
-- 20. Datos de los departamentos que tienen coste salarial por encima de 600 y que tienen el mayor n�mero de empleados sin hijos que adem�s cobren alguna comisi�n. Nota: el coste salarial es la suma de los salarios de ese departamento.
-- 21. �Cuales son los departamentos hacen el mayor n�mero de veces de departamento supervisor y tales que tienen m�s de tres empleados en plantilla, teniendo alguno de ellos m�s de un hijo.
-- 22. Dar los centros que no tienen ning�n departamento en su sede que haga de supervisor de otro de menor n�mero de empleados.
-- 23. Idem que la anterior pero adem�s en este centro trabaja el m�ximo n�mero de empleados con comisi�n est� por encima de la media de todos los centros, siempre que la media de salarios de los empleados del centro sea superior a 300.
-- 24. Obtener, por orden alfab�tico, los nombres de los empleados cuyos sueldos superan al del empleado n�mero 420 en un 50%.
-- 25. Obtener los nombres de los centros de trabajo, si hay alguno en MADRID.
-- 26. Hallar el salario medio, el m�nimo, el m�ximo y el promedio de estos dos �ltimos para el colectivo de todos los empleados.
-- 27. Hallar, la masa salarial (salarios+comisiones) de la empresa.
-- 28. Hallar el salario medio de los empleados cuyo salario no supera en m�s del 20% al salario m�nimo de los empleados que tienen alg�n hijo y su salario medio por hijo es mayor que 1000 � (Euros).
-- 29. Hallar la diferencia entre los salarios m�s alto y m�s bajo de la empresa, junto con la varianza y la desviaci�n t�pica.
-- 30. Hallar el presupuesto medio de los departamentos cuyo presupuesto supera el promedio de los presupuestos.
-- 31. Agrupando por n�mero de hijos, hallar la media por hijo del total del salario y de comisi�n.
-- 32. Para cada departamento, hallar la media de la comisi�n con respecto a los empleados que la reciben y con respecto al total de los empleados.
-- 33. Hallar el salario medio por departamento para aquellos departamentos cuyo salario m�ximo es inferior al salario medio de todos los empleados.
-- 34. Obtener un listado que incluya el nombre de cada uno de los departamentos junto al nombre de su director.
-- 35. Obtener un listado alfab�tico de todos los trabajadores, agrupados por centros.
-- 36. Obtener un listado que incluya el nombre de cada uno de los empleados junto al nombre de su departamento, el nombre de su jefe y la direcci�n de su centro de trabajo.
-- 37. Obtener, por orden alfab�tico, los nombres y los salarios de los empleados de los departamentos 110 y 111 que, o bien no tengan hijos o bien su salario por hijo supere los 1000 �, si hay alguno sin comisi�n en los departamentos 111 � 112.
-- 38. Obtener, por orden alfab�tico, los salarios y nombres de los empleados cuyo salario se diferencia con el m�ximo en menos de un 40% de �ste.
-- 39. Datos de los departamentos que tienen un presupuesto mayor que el doble de la media de los presupuestos de todos los departamentos en la empresa que tienen, como mucho, un 20% m�s de empleados que �ste.
-- 40. Para cada grupo de empleados que cobran el mismo salario y tienen el mismo n�mero de hijos, diga cuantos empleados forman el grupo y en cuantos departamentos est�n trabajando.
-- 41. Idem que la anterior pero se pide que los departamentos de cada grupo cumplan la condici�n de pertenecer todos al mismo centro.
-- 42. Dar los datos de los centros tales que la media de los salarios de otro centro es menor que la media de los salarios de los empleados de este centro que tienen otro segundo empleado de igual n�mero de hijos trabajando en un departamento que tiene el mismo jefe que el departamento del primero
-- 43. Idem que la anterior, pero el departamento del segundo empleado cumple la condici�n de tener menor n�mero de empleados que el del primer empleado.
-- 44. Idem que la anterior, pero los empleados que se cuentan en los dos departamentos son los que cobren un salario mayor que el del primer empleado.


       