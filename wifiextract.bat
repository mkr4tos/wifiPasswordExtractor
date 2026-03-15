@echo off

netsh wlan show profile | findstr "usuarios" >./profiles.txt 

setlocal enabledelayedexpansion
set "file=profiles.txt"
set "tempfile=temp.txt"
set "find=Perfil de todos los usuarios     : "
set "reemplazar="

for /f "tokens=*" %%a in (%file%) do (
    set "linea=%%a"
    set "linea=!linea:%find%=%reemplazar%!"
    echo !linea!>>%tempfile%
)
move /y %tempfile% %file% >nul
for /f "delims=" %%a in (profiles.txt) do (netsh wlan show profile "%%a" key=clear) | findstr "Nombre clave" 1>>./passwords.txt
del %file%
type passwords.txt | findstr /v """
