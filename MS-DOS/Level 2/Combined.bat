REM @echo off
C:

::Checks to see if the script has any arguments, if not, the it proceeds as normal; otherwise quickly backing up.
if [%1]==[] (
goto MENU
) else (
if [%2]==[] (
goto MENU
)
)


:SOURCECHK
if exist %1 (
goto DESTINATIONCHK
) else (
cls
echo                               =========================================================
echo				               ERROR - INVALID SOURCE LOCATION
echo                               =========================================================
timeout 5 > NUL
cls
goto MENU
)


:DESTINATIONCHK
if exist %2 (
xcopy %1 %2 /e /h /i /y
cls
echo                               =========================================================
echo							       SUCCESS
echo                               =========================================================
timeout 5 > NUL
cls
goto MENU
) else (
cls
goto CREATEDIR
)


::IF error in destination, then this screen will appear and solve it.
:CREATEDIR
echo                               =========================================================
echo				             ERROR - INVALID DESTINATION LOCATION
echo                               =========================================================
set /p create=Would you like to create the destination instead? [yes/no]
if "%create%"=="yes" (
mkdir %2
xcopy %1 %2 /e /h /i /y
cls
echo                               =========================================================
echo							       SUCCESS
echo                               =========================================================
timeout 5 > NUL
cls
goto MENU
) else (
if "%create%"=="no" (
echo Going to Menu...
timeout 5 > NUL
cls
goto MENU
) else (
cls
goto CREATEDIR
)
)


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
C:
::Choose Source
echo Please choose a source file/folder to backup.
set "chooser="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please choose a folder.',0,0).self.path""
for /f "usebackq delims=" %%I in (`powershell %chooser%`) do set "source=%%I"
echo You chose %source%
::End of Source Selection


::Choose Destination
echo Please choose a destination folder for your backup.
set "chooser="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please choose a folder.',0,0).self.path""
for /f "usebackq delims=" %%I in (`powershell %chooser%`) do set "destination=%%I"
echo You chose %destination%
::End of Destination Selection


if exist %source% ( 
xcopy %source% %destination% /e /h /i /y
cls
echo                               =========================================================
echo							       SUCCESS
echo                               =========================================================
timeout 5 > NUL
cls
goto MENU
) else (
cls
echo                               =========================================================
echo							      ERROR
echo                               =========================================================
timeout 5 > NUL
cls
goto MENU
)
pause