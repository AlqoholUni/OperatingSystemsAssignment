@echo off

:AUTOBACKUP
C:
::Choose Source
echo Please choose a source file/folder to backup.
set "chooser="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please choose a folder.',0,0).self.path""
for /f "usebackq delims=" %%I in (`powershell %chooser%`) do set "source=%%I"
::End of Source Selection


::Choose Destination
echo Please choose a destination folder for your backup.
set "chooser="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please choose a folder.',0,0).self.path""
for /f "usebackq delims=" %%I in (`powershell %chooser%`) do set "destination=%%I"
set /p name=Enter a filename for the backup: 
echo xcopy "%source%" "%destination%" /e /h /i /y > %name%.bat
::End of Destination Selection