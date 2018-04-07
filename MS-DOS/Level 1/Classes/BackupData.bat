@echo off
C:

::Choose Source
:SOURCE
echo Please choose a source file/folder to backup.
set "chooser="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please choose a folder.',0,0).self.path""
for /f "usebackq delims=" %%I in (`powershell %chooser%`) do set "source=%%I"
echo You chose %source%
::End of Source Selection

::Choose Destination
:DESTINATION
echo Please choose a destination folder for your backup.
set "chooser="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please choose a folder.',0,0).self.path""
for /f "usebackq delims=" %%I in (`powershell %chooser%`) do set "destination=%%I"
echo You chose %destination%
::End of Destination Selection

if exist %source% ( 
copy %source% %destination%
) else (
echo "Source doesn't exist - Send Help!"
cls
goto start
)
pause