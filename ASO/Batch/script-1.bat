@echo off

set /a contador=0

for %%i in (%*) do (

    echo %%i
    set /a contador+=1
)

echo Se han introducido %contador% parametros.
