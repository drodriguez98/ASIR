--	Base de datos Almacén.

CREATE DATABASE Almacen;
USE Almacen;
CREATE TABLE produtos (id INT NOT NULL AUTO_INCREMENT, nombre VARCHAR(20) NOT NULL, coste FLOAT NOT NULL DEFAULT 0.0, precio FLOAT NOT NULL DEFAULT 0.0, tipo_iva TINYINT, PRIMARY KEY(id) );

INSERT INTO productos (nombre, coste, precio, 1) VALUES ('Producto A', 4, 8, 2), ('Producto B', 1, 1.5, 2),('Producto C', 50, 80, 1);


--	Función que devuelve el beneficio de cada producto.

delimiter //
create or replace function beneficio (compra float, venta float) returns float
deterministic
begin
	declare resultado float;
	set resultado = venta-compra;
	return resultado;
end //
delimiter ;

	-- Para llamarla: select id, nombre, coste, precio, beneficio(coste, precio) as beneficio from produtos;
	
	
--	Función que calcula con distintos porcentajes el precio de un producto según el tipo de iva que recibe como parámetro.

delimiter //
create or replace function beneficio (venta float, tipo tinyint) returns float
deterministic
begin
	declare resultado float;
	declare valor int;
	if (tipo = 1) then
		set valor = 4;
		set resultado = venta * (1+4/100);
	elseif (tipo = 2) then
		set valor = 10;
	elseif (tipo = 2) then
		set valor = 21;
	end if;	
	set resultado = venta + (venta * valor) / 100;
	return resultado;
end //
delimiter ;

	-- Para llamarla: select id, nombre, coste, precio, beneficio(precio,tipo_iva) as precio_iva from produtos;
