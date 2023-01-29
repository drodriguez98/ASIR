@echo off

rem Localizar todos los archivos que contengan una palabra dentro de un directorio.

for %%f in (C:\Windows\*.*) do find "Microsoft" %%f >> resultado.txt
