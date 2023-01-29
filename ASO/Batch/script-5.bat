@echo off

:menu

echo "1 - Ping | 2 - Tracert | 3 - Recuperar IP | x - Finalizar"

choice /n /c:123x /m "Selecciona unha opcion"

if %errorlevel% == 1 (

    goto 1

)

if %errorlevel% == 2 (

    goto 2
    
)

if %errorlevel% == 3 (

    goto 3
    
)

if %errorlevel% == x (

    goto fin
    
)

:1

set /p valor=Introduce una ip o un dominio: 
ping %valor% 

goto menu

:2

set /p valor=Introduce una ip: 
tracert %valor% 

goto menu

:3

call ip.bat
echo %dip%

goto menu

:fin

cls & exit
