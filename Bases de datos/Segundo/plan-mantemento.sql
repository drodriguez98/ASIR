--  Restaurar copia de seguridad.

mysql -u root -p < backup.sql

--  Scripts para tareas diarias.

  --  Script para chequeo diario con crontab.

  mysqlcheck --al-databases -u root -pabc1234. > /home/admin/checks/checks.txt

  --  Script para backup diaria con crontab.

  #!/bin/bash
  
  ARCHIVO=/home/admin/backups/backup-$(date + %d-%m-%y)
  mysqldump --all-databases -u root -pabc1234. > $ARCHIVO.sql
  tar czvf $ARCHIVO.tar $ARCHIVO.sql
