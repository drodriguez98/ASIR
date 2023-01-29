@echo off

cls

for /f "tokens=1-3 delims=;" %%a in (paises.csv) do (

    echo %%a - %%b - %%c

)
