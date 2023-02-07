-- Función que calcula le letra que realmente corresponde a cada DNI. Si hacemos un select a la función con un DNI incorrecto devuelve el DNI correcto.

DELIMITER //

CREATE OR REPLACE FUNCTION calcular_letra (NIFemp vachar (9)) RETURNS VARCHAR (9)

DETERMINISTIC

BEGIN

    DECLARE cadena TEXT;
    DECLARE numDNI VARCHAR (8);
    DECLARE letraDNI VARCHAR (9);
    DECLARE letra_bien VARCHAR (1);

    SET cadena = "TRWAGMYFPDXBNJZSQVHLCKE";
    SET numDNI = substr(NIFemp, 1, 8);
    SET letraDNI = substr(NIFemp, 9, 1);
    SET letra_bien = substr(cadena, (numDNI % 23) +1, 1);
    
    RETURN concat(numDNI, letra_bien);

END //


--  Trigger que hace el actualiza el dni cuando se hace un inserta en la tabla nueva. Si ahora hacemos un insert de un DNI en la nueva tabla con una letra incorrecta comprobamos que lo inserta corregido en la nueva tabla.

DELIMITER //

CREATE OR REPLACE TRIGGER corregir_dni BEFORE INSERT ON empregados FOR EACH ROW

BEGIN

    SET new.dni = calcular_letra(new.dni);

END //

DELIMITER ;


--  Procedimiento que inserta los dni corregidos de todos los empleados en la tabla nueva con un cursor.

DELIMITER //

CREATE OR REPLACE PROCEDURE insertar_dni ()

BEGIN

    DECLARE c_nome VARCHAR(100);

    DECLARE c_apelido1 VARCHAR(100);

    DECLARE c_dni VARCHAR(9);  

    DECLARE c_nacimiento DATETIME;

    DECLARE c_dni_old VARCHAR(9);

    DECLARE c_final INT DEFAULT 0;

    DECLARE datos CURSOR for SELECT nomemp, ape1emp, NIFemp, fnacemp, NIFemp FROM templeados;

    DECLARE CONTINUE handler FOR NOT FOUND SET c_final = 1;

    OPEN datos;

        BUCLE: loop

            FETCH datos INTO c_nome, c_apelido1, c_dni, c_nacimiento, c_dni_old;

            IF c_final = 1 THEN

                leave bucle;

            END IF;

            INSERT INTO empregados VALUES (c_nome, c_apelido1, c_dni, c_nacimiento, c_dni_old);

        END loop BUCLE;

    CLOSE datos;

END //

DELIMITER ;
