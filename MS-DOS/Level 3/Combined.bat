@echo off


::Checks to see if the script has any arguments, if not, the it proceeds as normal; otherwise quickly backing up.
if ["%1"]==[""] (
	goto MENU
) else (
if ["%2"]==[""] (
	goto MENU
	)
)


:SOURCECHK
	IF EXIST "%1" (
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
	IF EXIST "%2" (
		xcopy "%1" "%2" /E /H /I /Y
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
		mkdir "%2"
		xcopy "%1" "%2" /E /H /I /Y
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


:MENU
	echo                               =========================================================
	echo                                                         MENU
	echo                               =========================================================
	echo                                          ===================================
	echo                                                   SELECT AN OPTION
	echo                                          ===================================
	echo.
	echo.
	echo                                          1. Create backup of a file/folder.
	echo                                          2. Create an Automated backup file.
	echo                                          3. Exit.

	set /p choice=Choose an option then press ENTER: 
	if "%choice%"=="1" (
		goto BACKUP
	) else (
	if "%choice%"=="2" (
		cls
		echo                               =========================================================
		echo                                                      AUTO BACKUP
		echo                               =========================================================
		goto AUTOBACKUP
	) else (
	if "%choice%"=="3" (
		exit
	) else (
		cls
		echo 					     Please choose a valid choice.
		goto MENU
	)
	)
	)
	)


:BACKUP
	C:
	::Choose Source
	set /p source="Please choose a source file/folder to backup. eg. (C:\Users\John\Desktop\Folder)"
	IF EXIST "%source%" (
		goto DESTCHOICE
	) else (
		echo The File/Folder you have selected doesn't exist
		goto BACKUP
	)
::End of Source Selection


:DESTCHOICE
	::Choose Destination
	set /p destination="Please choose a source file/folder to backup. eg. (C:\Users\John\Desktop\Folder2)"
	IF EXIST "%destination%" (
		xcopy "%source%" "%destination%" /E /H /I /Y
		echo                               =========================================================
		echo							       SUCCESS
		echo                               =========================================================
		timeout 5 > NUL
		cls
		goto MENU
	) else (
	set /p createDestination="The File/Folder you have selected doesn't exist, Would you like to create it instead? [yes/no]"
	if "%createDestination%"=="yes" (
		mkdir "%destination%"
		xcopy "%source%" "%destination%" /E /H /I /Y
		echo                               =========================================================
		echo							       SUCCESS
		echo                               =========================================================
		timeout 5 > NUL
		cls
		goto MENU
	) else (
		if "%createDestination%"=="no" (
		echo Going to Menu...
		timeout 5 > NUL
		goto MENU
	) else (
		mkdir "%destination%"
		xcopy "%source%" "%destination%" /E /H /I /Y
		echo                               =========================================================
		echo							       SUCCESS
		echo                               =========================================================
		timeout 5 > NUL
		cls
		goto MENU
	)
	)
	)
	)
::End of Destination Selection

::Auto backup process
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
	echo xcopy "%source%" "%destination%" /E /H /I /Y > %name%.bat
	cls
	echo                               =========================================================
	echo							       SUCCESS
	echo                               =========================================================
	timeout 5 > NUL
	cls
	goto MENU
::End of Destination Selection
	pause