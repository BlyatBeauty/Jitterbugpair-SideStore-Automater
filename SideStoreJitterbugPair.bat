@ECHO off

REM Jitterbug.bat - A batch script to run jitterbugpair.exe, and convert its output to a SideStore compatible file type

REM ===== Basic Instructions ===============================================================
ECHO Please connect your iPhone/iPad to your computer via USB cable, and unlock it.
ECHO Press the spacebar to continue  . . . 
Pause > nul

REM ===== Jitterbug first run - Will probably fail due to Trust prompt =====================
jitterbugpair /verbose
ECHO.
ECHO Press the spacebar to attempt to pair again  . . . 
Pause > nul

REM ===== Jitterbug second run - Will probably succeed =====================================
jitterbugpair /verbose

REM ===== Renaming .mobiledevicepairing to .plist
ECHO Renaming
RENAME *.mobiledevicepairing *.plist

REM ===== Find the name of the file we just renamed, turn it into a variable we can Echo ===
FOR /f %%i in ('DIR *.plist /b') do set pair=%%i
ECHO.
ECHO %pair% has been created

REM ===== Script ends, user exits the prompt ===============================================
ECHO Press the spacebar to exit  . . . 
Pause > nul
exit
