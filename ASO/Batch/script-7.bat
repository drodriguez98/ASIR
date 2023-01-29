@echo off

rem Listar subcarpetas de un directorio.

for /D %%i in (C:\Users\drodriguez\*) do (
 
  echo %%i
 
)
