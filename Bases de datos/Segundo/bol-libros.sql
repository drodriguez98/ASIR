--	Procedimiento para insert o update en control 

DELIMITER //

CREATE OR REPLACE PROCEDURE new_libro (codlib int, new_precio int, movemento varchar(20)) 

DETERMINISTIC

BEGIN

INSERT INTO control (nomeusuario, datamod, codlib, new_precio, movemento) VALUES (current_user(), current_timestamp(), codlib, new_precio, movemento);

END //

DELIMITER ;


--	Trigger para insert (after insert)

DELIMITER //

CREATE OR REPLACE TRIGGER insert_control AFTER INSERT ON libros FOR EACH ROW

BEGIN

DECLARE movemento VARCHAR(20);

SET movemento = 'Inserción';

CALL new_libro(new.codigo, new.precio, movemento);

END //

DELIMITER ;


-- 	Trigger para update con tipo de movimiento

DELIMITER //

CREATE OR REPLACE TRIGGER update_control AFTER UPDATE ON libros FOR EACH ROW

BEGIN

DECLARE movemento VARCHAR(20);

SET movemento = 'Actualización';

CALL new_libro (old.codigo, new.precio, movemento);

END //

DELIMITER ;
