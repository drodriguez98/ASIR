--	Base de datos Almacén.

CREATE DATABASE Almacen;
USE Almacen;
CREATE TABLE produtos (id INT NOT NULL AUTO_INCREMENT, nombre VARCHAR(20) NOT NULL, coste FLOAT NOT NULL DEFAULT 0.0, precio FLOAT NOT NULL DEFAULT 0.0, tipo_iva TINYINT, PRIMARY KEY(id) );
INSERT INTO productos (nombre, coste, precio, 1) VALUES ('Producto A', 4, 8, 2), ('Producto B', 1, 1.5, 2),('Producto C', 50, 80, 1);


--	Función que devuelve el beneficio de cada producto.

DELIMITER //
CREATE OR REPLACE FUNCTION beneficio (compra float, venta float) RETURNS float
DETERMINISTIC
BEGIN
	DECLARE resultado float;
	SET resultado = venta-compra;
	RETURN resultado;
END //
DELIMITER ;

	-- Para llamarla: select id, nombre, coste, precio, beneficio(coste, precio) as beneficio from produtos;
	
	
--	Función que calcula con distintos porcentajes el precio de un producto según el tipo de iva que recibe como parámetro.

DELIMITER //
CREATE OR REPLACE FUNCTION beneficio (venta float, tipo tinyint) RETURNS float
DETERMINISTIC
BEGIN
	DECLARE resultado float;
	DECLARE valor int;
	IF (tipo = 1) THEN
		SET valor = 4;
		SET resultado = venta * (1+4/100);
	ELSEIF (tipo = 2) then
		SET valor = 10;
	ELSEIF (tipo = 2) then
		SET valor = 21;
	END IF;	
	SET resultado = venta + (venta * valor) / 100;
	RETURN resultado;
END //
DELIMITER ;

	-- Para llamarla: select id, nombre, coste, precio, beneficio(precio,tipo_iva) as precio_iva from produtos;
