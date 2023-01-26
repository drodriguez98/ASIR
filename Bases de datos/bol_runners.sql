--	Base de datos Runners.

CREATE DATABASE Runners;
CREATE TABLE Runners (Runner_id BIGINT NOT NULL AUTO_INCREMENT, Name VARCHAR(120) NOT
NULL, Time BIGINT NOT NULL, Penalty1 BIGINT NOT NULL, Penalty2 BIGINT NOT NULL,
Points BIGINT, PRIMARY KEY (Runner_id)) ENGINE=InnoDB DEFAULT CHARSET=UTF8;
INSERT INTO Runners VALUES (NULL, 'Michael', 123, 5, 2, NULL);
INSERT INTO Runners VALUES (NULL, 'Sarah', 83, 3, 3, NULL);
INSERT INTO Runners VALUES (NULL, 'John', 323, 1, 1, NULL);
INSERT INTO Runners VALUES (NULL, 'Ramon', 100, 8, 4, NULL);
INSERT INTO Runners VALUES (NULL, 'Andrew', 143, 4, 3, NULL);
INSERT INTO Runners VALUES (NULL, 'Antoine', 199, 3, 2, NULL);
INSERT INTO Runners VALUES (NULL, 'David', 101, 2, 1, NULL);


--	Función que amosa todos os datos.

delimiter //
create or replace procedure mostrar_datos ()
begin
	declare c_id int;
	declare c_name varchar(100);
	declare c_time bigint;
	declare c_penalty1 bigint;
	declare c_penalty2 bigint;
	declare c_points bigint;
	declare control int default 0;
	declare cursor_runners cursor for select * from Runners;
	declare continue handler for not found set control = 1;
	open datos;
		bucle: loop
			fetch datos into c_id, c_Name, c_Time, c_Penalty1, c_Penalty2, c_Points;
			if control = 1 then
				leave bucle;
			end if;
			select c_id, c_Name, c_Time, c_Penalty1, c_Penalty2, c_Points;
		end loop bucle;
	close datos;
end //
delimiter ;


--	Función para calcular os puntos de cada xogador.

delimiter //
create or replace function calcular_puntos (Time int, Penalty1 int, Penalty2 int) returns int
deterministic
begin
	declare puntuacion_inicial int;
	declare puntuacion_final int;
	set puntuacion_inicial = 500 - Time;
	set puntuacion_final = puntuacion_inicial - (5 * Penalty1) - (3 * Penalty2); 
	return puntuacion_final;
end // 
delimiter ;


--	Procedemento que actualiza os puntos chamando á función anterior.

delimiter //
create or replace procedure puntuacions () 
begin
	declare c_id int;
	declare c_name varchar(100);
	declare c_time bigint;
	declare c_penalty1 bigint;
	declare c_penalty2 bigint;
	declare c_points bigint;
	declare control int default 0;
	declare puntos cursor for select * from Runners;
	declare continue handler for not found set control=1;
	open puntos;
		bucle: loop
		fetch puntos into c_id, c_Name, c_Time, c_Penalty1, c_Penalty2, c_Points;
		if control = 1 then
			leave bucle;
		end if;
		update Runners set Points = calcular_puntos(c_Time, c_Penalty1, c_Penalty2) where c_id=Runner_id;
		end loop bucle;
	close puntos;
end //
delimiter;


