 --  ART�CULOS Y FABRICANTES

--  Obtener el precio medio de los productos de cada fabricante, mostrando el nombre del fabricante

        select avg(precio), b.nombre 
        from articulos a, fabricantes b 
        where a.fabricante=b.codigo 
        group by a.nombre;

--  Obtener los nombres de los fabricantes que ofrecen productos cuyo precio medio es mayor o igual a 150�

        select a.nombre from fabricantes a, articulos b 
        where a.codigo=b.fabricante 
        group by a.nombre 
        having avg(precio) >= 150;

--  Obtener el nombre y el precio del art�culo m�s barato

        select nombre, precio 
        from articulos 
        where precio = (select min(precio) from articulos);

--  Obtener una lista con el nombre y el precio de los art�culos m�s caros de cada proveedor (incluyendo el nombre del proveedor)

        select a.nombre, a.precio, b.nombre 
        from articulos a, fabricantes b 
        where a.fabricante=b.codigo 
        and precio = (select max(precio) from articulos)

--  A�adir un nuevo producto: Altavoces de 70� del fabricante 2

        insert into articulos (nombre, precio, fabricante) 
        values ('altavoces', 70, 2);

--  Cambiar el nombre del producto 8 a 'Impresora l�ser'

        update articulos 
        set nombre = 'impresora l�ser' 
        where codigo = 8;

--  Aplicar un descuento del 10% a todos los art�culos cuyo precio sea mayor o igual a 120�

        update articulos 
        set precio=precio*0.9 
        where precio >= 120;


        --  EMPLEADOS Y DEPARTAMENTOS

--  Obtener los apellidos de los empleados sin repeticiones

        select distinct apellidos 
        from empleados;

--  Obtener los datos de los empleados que se apellidan 'L�pez' o 'P�rez'

        select * from empleados 
        where apellidos in ('L�pez', 'P�rez');
        
        select * from empleados 
        where apellidos = 'L�pez' or apellidos = 'P�rez';

--  Obtener los datos de los empleados que trabajan para el departamento 37 o para el departamento 77

        select * from empleados 
        where departamento in ('37', '77');
        
        select * from empleados 
        where departamento = '37' or departamento = '77';

--  Obtener los datos de los empleados cuyo apellido empiece por P

        select * from empleados 
        where apellidos like 'P%';

--  Obtener el n�mero de empleados de cada departamento

        select departamento, count(*) as total_empleados 
        from empleados 
        group by departamento;
    
--  Obtener un listado completo de empleados, incluyendo sus datos y los de su departamento

        select * 
        from empleados a, departamentos b 
        where a.departamento=b.codigo;

--  Obtener un listado completo de empleados, incluyendo su nombre, sus apellidos junto al nombre y presupuesto de su departamento

        select a.nombre, a.apellidos, b.nombre as departamento, b.presupuesto 
        from empleados a, departamentos b 
        where a.departamento=b.codigo;

-- Obtener los nombres y apellidos de los empleados que trabajen en departamentos cuyo presupuesto sea mayor a 60.000�

        select a.nombre, a.apellidos 
        from empleados a, departamentos b 
        where a.departamento=b.codigo and b.presupuesto > 60000;
        
        select a.nombre, a.apellidos 
        from empleados a, departamentos b 
        where a.departamento in 
        (select codigo from departamentos where presupuesto > 60000);

--  Obtener los datos de los departamentos cuyo presupuesto es superior al presupuesto medio de todos los departamentos

        select * from departamentos 
        where presupuesto > (select avg(presupuesto) from departamentos);

--  Obtener los nombres de los departamentos que tienen m�s de dos empleados

        select a.nombre 
        from departamentos a, empleados b 
        where a.codigo=b.departamento 
        group by a.nombre 
        having count(*) > 2;
        
        select nombre 
        from departamentos 
        where codigo in 
        (select departamento from empleados group by departamento having count (*) > 2;

--  Reasignar a los empleados del departamento 77 al departamento 14

        update empleados 
        set departamento = 14 
        where departamento = 77;

-- Despedir a todos los empleados que trabajan para el departamento 14

        delete from empleados 
        where departamento = 14;

-- Despedir a todos los empleados que trabajen en departamentos cuyo presupuesto sea mayor a 60000�

        delete from empleados 
        where departamento in 
        (select codigo from departamentos where presupuesto > 60000);


        --  ALMACENES Y CAJAS

--  Obtener los tipos de contenido de las cajas sin repetici�n

        select distinct contenido 
        from cajas;

--  Obtener el valor medio de las cajas de cada almac�n

        select almacen, avg(valor) 
        from cajas 
        group by almacen;

--  Obtener los c�digos de los almacenes cuyo valor medio de las cajas sea superior a 150�

        select almacen, avg(valor) 
        from cajas 
        group by almacen 
        having avg(valor) > 150;

--  Obtener el n�mero de referencia de cada caja junto con el nombre de la ciudad en la que se encuentra

        select a.num_referencia, b.lugar 
        from cajas a, almacenes b 
        where a.almacen=b.codigo;

--  Obtener el n�mero de cajas que hay en cada almac�n

        select almacen, count (*) as total_cajas 
        from cajas 
        group by almacen;
        
        select codigo, count (num_referencia) 
        from almacenes left join cajas 
        on a.codigo=b.almacen 
        group by a.codigo;

--  Obtener los n�meros de referencia de las cajas que est�n en Bilbao
    
        select a.num_referencia, b.lugar 
        from cajas a right join almacenes b 
        on a.almacen=b.codigo 
        where b.lugar = 'Bilbao';
        
        select num_referencia from cajas 
        where almacen in 
        (select codigo from almacenes where lugar = 'Bilbao');   
    
--  Insertar un nuevo almac�n en Barcelona con capacidad para 3 cajas

        insert into almacenes (lugar, capacidad) 
        values ('Barcelona', 3);
    
--  Insertar una nueva caja con n�mero de referencia 'H5RT', con contenido 'Papel', valor de 200 y situada en el almac�n 2

        insert into cajas (num_referencia, contenido, valor, almacen) 
        values ('H5RT', 'papel', 200, 2);
    
--  Rebajar un 20% el valor de aquellas cajas cuyo valor sea superior al valor medio de todas las cajas

        update cajas 
        set valor = valor * 0.80 
        where valor > (select avg(valor) from cajas);
    
--  Eliminar todas las cajas cuyo valor sea inferior a 100�

        delete from cajas 
        where valor < 100;
        

        --  PEL�CULAS Y SALAS
    
--  Obtener todas las pel�culas que a�n no han sido calificadas
    
        select nombre from peliculas 
        where calificacionedad is null;
    
--  Mostrar todas las salas que no proyectan ninguna pel�cula
    
        select nombre from salas 
        where pelicula is null;
    
--  Mostrar la informaci�n de todas las salas y, si en alguna se proyecta alguna pel�cula, mostrar tambi�n la informaci�n de la pel�cula
    
        select a.*,b.* 
        from salas a left join peliculas b 
        on a.pelicula=b.codigo;
    
--  Mostrar los nombres de las pel�culas que no se proyectan en ninguna sala
    
        select nombre from peliculas 
        where codigo not in 
        (select pelicula from salas where pelicula is not null);
        
        select b.nombre 
        from salas a right join peliculas b 
        on a.pelicula=b.codigo 
        where a.pelicula is null; 
    
--  A�adir a todas las pel�culas que no han sido calificadas la calificaci�n "no recomendable para menores de 13 a�os"
    
        update from peliculas 
        set calificacionedad = 13 
        where calificacionedad is null;
    
--  Eliminar las salas que proyectan pel�culas recomendadas para todos los p�blicos
    
        delete from salas 
        where pelicula in 
        (select codigo from peliculas where calificacionedad = 0);
    

        --  DIRECTORES Y DESPACHOS

--  Mostrar los datos de los directores que no tienen jefes

        select * from directores 
        where dnijefe is null;

--  Mostrar el nombre y apellidos de cada director junto con la capacidad del despacho en el que se encuentra

        select a.nomapels, b.despacho, b.capacidad 
        from directores a, despachos b 
        where a.despacho=b.numero;

--  Mostrar el n�mero de directores que hay en cada despacho

        select despacho, count (*) as total_directores 
        from directores 
        group by despacho;
        
        select a.numero, count (dni) as total_directores 
        from despachos a left join directores b 
        on a.numero=b.despacho 
        group by numero;
        
--  Mostrar los datos de los directores cuyos jefes no tienen jefes
        
        select * from directores 
        where dnijefe in 
        (select dni from directores where dnijefe is null);
        
--  Mostrar los nombres y apellidos de los directores junto con los de su jefe

        select d1.nomapels, d2.nomapels 
        from directores d1, directores d2 
        where d1.dnijefe=d2.dni;
        
        select d1.nomapels, d2.nomapels 
        from directores d1 left join directores d2 
        on d1.dnijefe=d2.dni;
    
--  Asignar a todos los empleados apellidados 'P�rez' un nuevo jefe con DNI 74568521

        update from empleados 
        set dnijefe = '74568521' 
        where nomapels like '%P�rez%';
    

        --  PIEZAS Y PROVEEDORES
        
--  Obtener los nombres de los proveedores que suministran la pieza 1

        select a.nombre 
        from proveedores a, suministra b 
        where a.id=b.idproveedor and b.codigopieza = 1;
        
        select nombre from proveedores 
        where id in 
        (select idproveedor from suministra where codigopieza = 1);

--  Obtener los nombres de las piezas suministradas por el proveedor cuyo c�digo es 'HAL'
        
        select a.nombre 
        from piezas a, suministra b 
        where a.codigo=b.codigo pieza and idproveedor='HAL';
        
        select nombre from piezas 
        where codigo in 
        (select codigopieza from suministra where idproveedor = 'HAL');
        
--  Obtener los nombres de los proveedores que suministran las piezas m�s caras, indicando el nombre de la pieza y el precio al que la suministran
        
        select a.nombre as proveedor, c.nombre, b.precio as pieza 
        from proveedores a, suministra b, piezas c 
        where a.id=b.idproveedor and c.codigo=b.codigopieza 
        and b.precio in 
        (select max(precio) from suministra a, piezas b where a.codigopieza=b.codigo group by codigopieza));
        
--  Hacer constar que la empresa con el id 'RBT' ya no va a suministrar clavos (c�digo 4)

        delete from suministra 
        where idproveedor = 'RBT' and codigopieza = 4; 
        

        --  CIENT�FICOS Y PROYECTOS
        
--  Sacar una relaci�n completa de los cient�ficos asignados a cada proyecto. Mostrar dni, nombre del cient�fico, id y nombre del proyecto 
        
        select a.nomapels, b.*, c.nombre
        from cientificos a, asignado_a b, proyecto c
        where a.dni=b.cientifico and c.id=b.proyecto;

--  Obtener el n�mero de proyectos al que est� asignado cada cient�fico, indicando su dni y nombre

        select a.dni, a.nomapels, count (proyecto) 
        from cientificos a left join asignado_a b 
        on a.dni=b.cientifico 
        group by a.dni, a.nomapels;
    
--  Obtener el n�mero de horas de dedicaci�n de cada cient�fico

        select a.dni, a.nomapels, sum(horas) 
        from cientificos a, asignado_a b, proyecto c
        where a.dni=b.cientifico and c.id=b.proyecto
        group by a.dni, a.nomapels;
        
--  Obtener el dni y nombre de los cient�ficos que se dedican a m�s de un proyecto y cuya dedicaci�n media a cada proyecto sea superior a 80 horas

        select a.dni, a.nomapels 
        from cientificos a, asignado_a b, proyectos c
        where a.dni=b.cientifico and c.id=b.proyectos
        group by a.dni, a.nomapels
        having count(b.proyecto) > 1 and avg(c.horas) > 80;
        

        --  PRODUCTOS, CAJEROS, M�QUINAS REGISTRADORAS Y VENTAS

--  Mostrar el n�mero de ventas de cada producto, ordenado de m�s a menos ventas

select a.codigo, a.nombre, a.precio, count(b.producto) as ventas_totales 
from productos a, venta b 
where a.codigo=b.producto 
group by a.codigo, a.nombre, a.precio
order by count(b.producto) desc;


--  Obtener un informe completo de ventas, indicando el nombre del cajero que realiz� la venta nombre y precios de los productos vendidos y piso en el que se encuentra la m�quina 
--  registradora donde se realiz� la venta

select b.nomapels as cajero, c.nombre as producto, c.precio, d.piso,
from venta a, cajeros b, productos c, maquinas_registradoras d
where a.cajero=b.codigo and a.maquina=d.codigo and a.producto=c.codigo;


--  Obtener las ventas totales realizadas en cada piso

select b.piso, count(*) as ventas_totales
from venta a, maquinas_registradoras b
where a.venta=b.codigo 
group by b.piso;

--  Obtener la suma total de las ventas totales realizadas en cada piso

select b.piso, sum(c.precio) as ingresos
from venta a, maquinas_registradoras b, productos c
where a.maquina=b.codigo and a.producto=c.codigo
group by b.piso;


--  Obtener el c�digo y nombre de cada empleado junto con el importe total de sus ventas

select b.codigo, b.nomapels as empleado, sum(c.precio) as importe_total
from venta a, cejeros b, productos c
where a.cajero=b.codigo and a.producto=c.codigo
group by b.codigo, b.nomapels;


--  Obtener el c�digo y nombre de aquellos cajeros que hayan realizado ventas en pisos cuyas ventas totales sean inferiores a los 500�

select codigo, nomapels as empleado
from cajeros where codigo in
(select cajero from venta 
where maquina in
(select codigo from maquinas_registradoras 
where piso in
(select a.piso from venta a, productos b, maquinas_registradoras c
where a.producto=b.codigo and a.maquina=c.codigo 
group by a.piso
having sum(precio) < 500 ) ) );


        --  FACULTADES, INVESTIGADORES, EQUIPOS Y RESERVAS
        
--  Obtener el dni y nombre de aquellos investigadores que han realizado m�s de una reserva

select a.dni, a.nomapels as investigador 
from investigadores a, reserva b
where a.dni=b.dni
group by a.dni
having count(b.dni) > 1;

select dni, nomapels as investigador where dni in
(select dni from reserva group by dni having count(dni) > 1);


--  Obtener un listado completo de reservas incluyendo los siguientes datos:

    --  dni y nombre del investigador, junto con el nombre de su facultad
    --  n�mero de serie y nombre del equipo reservado, junto con el nombre de la facultad a la que pertenece
    --  fecha de comienzo y fin de la reserva
    
select b.dni, b.nomapels as investigador, d_inv.nombre as facultad_inv, c.numserie, c.nombre as equipo,
d_equ.facultad as facultad_equ, a.comienzo, a.fin
from reserva a, investigadores b, equipos c, facultad d_inv, facultad d_equ
where a.dni=b.dni and a.numserie=c.numserie and d_inv=b.facultad and d_equ=c.facultad;

--      MIX DE OPERACIONES DE CONJUNTOS

--  Imprimir una lista con dni, nombe y departamento de cada empleado. Primero los m�dicos y luego los sanitarios

select dni, nome, dept, 'm�dico' as trabajo from medicos 
union
select dni, nome, dept, 'sanitario' as trabajo from sanitarios;

--  Mostrar empleados que no son m�dicos ni sanitarios

select dni from emp 
minus
(select dni from medicos union select dni from sanitarios);


--  Saber que departamentos te�en empregados: varias formas

select * from departamentos where id in (select dept from empregados);
select dept from empregados intersect select id from departamentos;
select a.* from dept a, emp b where a.id=b.dept;


--  Saber que departamentos NON te�en empregados: varias formas

select * from departamentos where id not in (select dept from empregados where dept is not null);
select id from departamentos minus select dept from empregados;
select a.* from departamentos a left join empregados b on a.id=b.dept where b.dni is null;


















