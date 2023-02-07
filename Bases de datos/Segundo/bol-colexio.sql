--	Función que calcula a media de cada alumno e a amosa en texto.

DELIMITER //

CREATE OR REPLACE FUNCTION nota_media (nota1 decimal(10,2), nota2 decimal(10,2), nota3 decimal(10,2)) RETURNS varchar(100)

DETERMINISTIC

BEGIN

	DECLARE media decimal(10,2);
	
	SET media = (nota1 + nota2 + nota3) / 3;
	
	IF (media < 3) THEN
		RETURN "Moi deficiente";
		
	ELSEIF (media >= 3) and (media < 5) THEN
		RETURN "Insuficiente";
		
	ELSEIF (media >= 5) and (media < 7) THEN
		RETURN "SuficienteTHEN
		
	ELSEIF (media >= 7) and (media < 9) THEN
		RETURN "Notable";
		
	ELSEIF (media >= 9) THEN
		RETURN "Sobresaliente";
		
	ELSE
		RETURN "Nota no válida";
		
	END IF;
END //

DELIMITER;
