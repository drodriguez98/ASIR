--	Procedimiento que cuenta el número de empleados, calcula la media de su salario y el número de aquellos que superan la media

delimiter //
create or replace procedure media(out sal varchar(255))
begin
	declare mediaSalario float;
	declare numEmpregados int;
	declare superanMedia int;
	select count(*) into numEmpregados from empleados;
	select avg(salario) into mediaSalario from empleados;
	select count(*) into superanMedia from empleados where salario>=mediaSalario;
	select concat("El número de empleados es ",numEmpregados,". La media de su salario es ",mediaSalario,". 
	El número de empleados que cobran más que la media es ",superanMedia) 
	into sal;
end //
delimiter ;
