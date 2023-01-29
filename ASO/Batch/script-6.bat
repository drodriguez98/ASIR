@echo off

rem Leer ficheros bat de una carpeta.

for %%i in (*.bat) do (

  echo %%i
  type %%i

)
