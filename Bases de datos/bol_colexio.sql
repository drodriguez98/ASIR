--	Base de datos Colexio.

CREATE TABLE `notasexamenes` (`id` int(11) NOT NULL, `idalumno` int(11) NOT NULL, `idmateria` int(11) NOT NULL, `nota1` decimal(10,2) NOT NULL, `nota2` decimal(10,2) NOT NULL, `nota3` decimal(10,2) NOT NULL) ENGINE=InnoDB DEFAULT CHARSET=latin1;
ALTER TABLE `notasexamenes` ADD PRIMARY KEY (`id`);
INSERT INTO `notasexamenes` (`id`, `idalumno`, `idmateria`, `nota1`, `nota2`, `nota3`) VALUES (1, 1000, 1, '8.00', '9.25', '7.00'), (2, 1001, 1, '6.33', '8.50', '8.00'), (3, 1002, 1, '10.00', '7.50', '8.33'), (4, 1003, 2, '4.50', '2.00', '5.50'), (5, 1004, 1, '3.50', '2.00', '2.00');


--	Función que calcula a media de cada alumno e a amosa en texto.

delimiter //
create or replace function nota_media (nota1 decimal(10,2), nota2 decimal(10,2), nota3 decimal(10,2)) returns varchar(100)
deterministic
begin
	declare media decimal(10,2);
	set media = (nota1 + nota2 + nota3) / 3;
	if (media < 3) then
		return "Moi deficiente";
	elseif (media >= 3) and (media < 5) then
		return "Insuficiente";
	elseif (media >= 5) and (media < 7) then
		return "Suficiente";
	elseif (media >= 7) and (media < 9) then
		return "Notable";
	elseif (media >= 9) then
		return "Sobresaliente";
	else
		return "Nota no válida";
	end if;
end //
delimiter;

