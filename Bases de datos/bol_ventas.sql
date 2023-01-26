--	Base de datos Ventas.

CREATE DATABASE ventas;
USE ventas;
CREATE TABLE vendedores (id INT AUTO_INCREMENT PRIMARY KEY, nombre VARCHAR(30) NOT NULL, email VARCHAR(50), contacto VARCHAR(30));
CREATE TABLE ventas (id INT NOT NULL PRIMARY KEY, fecha DATE NOT NULL, coste id_vendedor int, CONSTRAINT fk_vend FOREIGN KEY (id_vendedor) REFERENCES vendedores(id) ON DELETE CASCADE ON UPDATE CASCADE);
INSERT INTO `vendedores` (`id`, `nombre`, `email`, `contacto`) VALUES (NULL, 'Kamal Hasan', 'kamal@gmail.com', '0191275634'), (NULL, 'Nila Hossain', 'nila@gmail.com', '01855342357'), (NULL, 'Abir Hossain', 'abir@yahoo.com', '01634235698');
INSERT INTO `ventas` (`id`, `fecha`, `coste`, `id_vendedor`) VALUES ('90', '2021-11-09', '800000', '1'),('34', '2020-12-15', '5634555', '3'), ('67', '2021-12-23', '900000', '1'), ('56', '2020-12-31', '6700000', '1');


--	Función que calcula o bonus de cada venta.

delimiter //
create or replace function calcular_bonus (coste int) returns int
deterministic
begin
	declare venta int;
	declare venta_con_bonus int;
	set venta = coste;
	if (venta > 10000) then
		set venta_con_bonus = coste + (coste * 15 / 100);
	else
		set venta_con_bonus = coste + (coste * 10 / 100);
	end if;
	return venta_con_bonus;
end //

delimiter;

--	Procedemento que chama á función anterior para calcular as ventas totais de cada vendedor.

delimiter //
create or replace procedure total_vendedor()
begin
declare vfinal integer default 0;
declare ventas_totais float;
declare id int;
declare total cursor for select sum(coste), id_vendedor from ventas group by id_vendedor;
declare continue handler for not found set vfinal = 1;
open total;
	while vfinal = 0 do
		fetch total into ventas_totais, id;
		if vfinal = 0 then
			select calcular_bonus (ventas_totais), ventas_totais, id;
		end if;
	end while;
close total;
end //
delimiter ;



