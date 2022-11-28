@ECHO off

REM Jitterbug.bat - A batch script to run jitterbugpair.exe, and convert its output to a SideStore compatible file type

REM ===== Basic Instructions ================================================================================
ECHO Please connect your iPhone/iPad to your computer via USB cable, and unlock it.
ECHO Keep your device connected and unlocked for the duration of this script.
ECHO.
ECHO Press the spacebar to begin  . . . 
Pause > nul
GOTO Search1

:Search1
REM ===== Initial search, checks to see if Pairing File already exists  =======================================
REM ===== Searching for mobiledevicepairing file ==============================================================
ECHO.
ECHO Now searching for existing Pairing Files
ECHO.
ECHO Searching for .mobiledevicepairing file  . . .
DIR *.mobiledevicepairing /b
if not errorlevel 1 (
	ECHO mobiledevicepairing file found. Now renaming.
	GOTO RenamePLIST
) else (
	GOTO Search2
)

:Search2
REM ===== Second search, checks to see if PLIST Pairing File already exists  =================================
ECHO.
ECHO Searching for .plist file  . . .
ECHO.
DIR *.plist /b
if not errorlevel 1 (
	ECHO Pairing File already exists.
	GOTO Fin
) else (
	ECHO No Pairing File was not found.
	ECHO.
	ECHO Press the spacebar to attempt to generate Pairing File  . . . 
	Pause > nul
	GOTO Jitter1
)

:Jitter1
REM ===== Jitterbug first run - Will probably fail due to Trust prompt ======================================
jitterbugpair /verbose
if not errorlevel 1 (
	ECHO Pairing File successfully generated. Will now rename.
	GOTO RenamePLIST
) else (
	ECHO Pairing File was not made.
	ECHO.
	ECHO Press the spacebar to attempt to pair again  . . . 
	Pause > nul
	GOTO Jitter2
)

:Jitter2
REM ===== Jitterbug second run - Will probably succeed assuming no errors =====================================
jitterbugpair /verbose
if not errorlevel 1 (
	ECHO Pairing File successfully generated. Will now rename.
	GOTO RenamePLIST
) else (
	ECHO Pairing File was not made.
	ECHO.
	ECHO Press the spacebar to proceed  . . . 
	Pause > nul
	GOTO CatError
)
	
:RenamePLIST
REM ===== Renaming .mobiledevicepairing to .plist
ECHO.
ECHO Renaming  . . .
RENAME *.mobiledevicepairing *.plist

REM ===== Find the name of the file we just renamed, turn it into a variable we can Echo ======================
FOR /f %%i in ('DIR *.plist /b') do set pair=%%i
ECHO.
ECHO %pair% has been created
GOTO Fin

:CatError
REM ===== If this runs, it means Jitterbugpair failed to generate Pairing File after 2nd run ==================
REM ===== Recommend user to address any error Jitterbugpair spits out and run script again. ===================
ECHO Please address any errors and run the script again.
GOTO Fin

:Fin
ECHO.
ECHO You have reached the end of the script.
ECHO Press the spacebar to exit  . . . 
Pause > nul
exit
