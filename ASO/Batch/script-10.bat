@echo off

rem Mostrar la primera palabra de cada línea

for /f "tokens=*" %%i in (saludo.txt) do echo %%i 
