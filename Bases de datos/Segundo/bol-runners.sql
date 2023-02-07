--	Función que amosa todos os datos.

DELIMITER //
CREATE OR REPLACE PROCEDURE mostrar_datos ()
BEGIN
	DECLARE c_id int;
	DECLARE c_name varchar(100);
	DECLARE c_time bigint;
	DECLARE c_penalty1 bigint;
	DECLARE c_penalty2 bigint;
	DECLARE c_points bigint;
	DECLARE control int default 0;
	DECLARE cursor_runners cursor for select * from Runners;
	DECLARE continue handler for not found set control = 1;
	OPEN datos;
		bucle: LOOP
			FETCH datos INTO c_id, c_Name, c_Time, c_Penalty1, c_Penalty2, c_Points;
			IF control = 1 THEN
				LEAVE bucle;
			END IF;
			SELECT c_id, c_Name, c_Time, c_Penalty1, c_Penalty2, c_Points;
		END LOOP bucle;
	CLOSE datos;
END //
DELIMITER ;


--	Función para calcular os puntos de cada xogador.

DELIMITER //
CREATE OR REPLACE FUNCTION calcular_puntos (Time int, Penalty1 int, Penalty2 int) RETURNS int
DETERMINISTIC
BEGIN
	DECLARE puntuacion_inicial int;
	DECLARE puntuacion_final int;
	SET puntuacion_inicial = 500 - Time;
	SET puntuacion_final = puntuacion_inicial - (5 * Penalty1) - (3 * Penalty2); 
	RETURN puntuacion_final;
END // 
DELIMITER ;


--	Procedemento que actualiza os puntos chamando á función anterior.

DELIMITER //
CREATE OR REPLACE PROCEDURE puntuacions () 
BEGIN
	DECLARE c_id int;
	DECLARE c_name varchar(100);
	DECLARE c_time bigint;
	DECLARE c_penalty1 bigint;
	DECLARE c_penalty2 bigint;
	DECLARE c_points bigint;
	DECLARE control int default 0;
	DECLARE puntos cursor for select * from Runners;
	DECLARE continue handler for not found set control=1;
	OPEN puntos;
		bucle: LOOP
		FETCH puntos into c_id, c_Name, c_Time, c_Penalty1, c_Penalty2, c_Points;
		IF control = 1 THEN
			LEAVE bucle;
		END if;
		UPDATE Runners SET Points = calcular_puntos(c_Time, c_Penalty1, c_Penalty2) WHERE c_id=Runner_id;
		END LOOP bucle;
	CLOSE puntos;
END //
DELIMITER;
