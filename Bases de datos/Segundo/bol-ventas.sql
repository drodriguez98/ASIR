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
