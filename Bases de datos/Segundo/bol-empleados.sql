--	Procedimiento que cuenta el número de empleados, calcula la media de su salario y el número de aquellos que superan la media

DELIMITER //
CREATE OR REPLACE PROCEDURE media (out sal VARCHAR(255))
BEGIN
	DECLARE mediaSalario float;
	DECLARE numEmpregados int;
	DECLARE superanMedia int;
	SELECT count(*) INTO numEmpregados FROM empleados;
	SELECT avg(salario) INTO mediaSalario FROM empleados;
	SELECT count(*) INTO superanMedia FROM empleados WHERE salario>=mediaSalario;
	SELECT concat("El número de empleados es ",numEmpregados,". La media de su salario es ",mediaSalario,". 
	El número de empleados que cobran más que la media es ",superanMedia) 
	INTO sal;
END //
DELIMITER ;
