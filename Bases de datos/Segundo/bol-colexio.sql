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
