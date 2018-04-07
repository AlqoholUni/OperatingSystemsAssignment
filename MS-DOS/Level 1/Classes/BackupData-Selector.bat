@echo off
setlocal

set "chooser="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please choose a folder.',0,0).self.path""

for /f "usebackq delims=" %%I in (`powershell %chooser%`) do set "source=%%I"

setlocal enabledelayedexpansion
echo You chose %source%
pause
endlocal