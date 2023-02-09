-- Evento que cada 3 meses (QUARTER) comprueba los autores que no han publicado ninguna noticia y añade la "fecha de borrado" en la tabla usuarios a aquellos que cumplen la condición.
  
  --  Habilitando os eventos.
  
    SET GLOBAL event_scheduler = 1;

  --  Novo campo de táboa autores.
  
    ALTER TABLE autores ADD f_borrado DATETIME; 

  --  Evento. Para facer a proba cambiamos o intervalo no que se repite o evento: EVERY 15 SECOND ON COMPLETION PRESERVE.


    DELIMITER //

    CREATE OR REPLACE EVENT borrado ON SCHEDULE EVERY 1 QUARTER ENABLE DO

    BEGIN

        UPDATE autores SET f_borrado = CURRENT_DATE() WHERE id_autor IN (SELECT autor_id FROM noticias WHERE timestampdiff (MONTH, fecha_pub, CURRENT_DATE()) > 2 GROUP BY autor_id);

    END //

    DELIMITER ;
