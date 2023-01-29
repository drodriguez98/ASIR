setlocal ENABLEEXTENSIONS & set "i=0.0.0.0" & set "j="

for /f "tokens=4" %%a in ('route print^|findstr 0.0.0.0.*0.0.0.0') do (

    if not defined j for %%b in (%%a) do set "i=%%b" & set "j=1")

endlocal & set "dip=%i%"

echo Direccion IP = %dip%
