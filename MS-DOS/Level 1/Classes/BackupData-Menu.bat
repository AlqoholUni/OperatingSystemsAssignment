@echo off
::Menu block
:MENU
echo                               =========================================================
echo                                                         MENU
echo                               =========================================================
echo                                          ===================================
echo                                                   SELECT AN OPTION
echo                                          ===================================
echo.
echo.
echo                                           1. Create backup of a file/files.
echo                                           2. Exit

set /p choice=Choose an option then press ENTER:

if "%choice%"=="1" (
GOTO BACKUP
) else (
if "%choice%"=="2" (
exit
) else (
cls
echo Invalid Choice
GOTO MENU
)
)

:BACKUP
echo 
pause