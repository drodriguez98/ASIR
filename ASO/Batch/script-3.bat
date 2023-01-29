@echo off

:partida

set /A num1=(%RANDOM%*6/32768)+1
set /A num2=(%RANDOM%*6/32768)+1

echo %num1% - %num2%

if %num1% == %num2% (

    echo Has ganado!
    goto fin

) else (

    echo Has perdido!
    echo Presiona cualquier tecla para jugar otra ronda
    pause > nul
    goto partida

)

:fin
