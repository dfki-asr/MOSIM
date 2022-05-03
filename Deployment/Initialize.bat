@echo off

REM This script initializes the repository to the current version and sets up all variables. 

call :CheckPowershell PARENT

REM TODO: Adjust this to be be able to run without meta. 

REM call meta git fetch
REM remove this once its merged to master
call meta git pull
call %~dp0\git-submodules-update.bat
call %~dp0\DefaultVariables.bat
REM Set variables persistently
SETX MOSIM_MSBUILD "%DEFAULT_MOSIM_MSBUILD%"
SETX MOSIM_UNITY "%DEFAULT_MOSIM_UNITY%"
SETX MOSIM_TARGET_PATH %DEFAULT_MOSIM_TARGET_PATH%
REM set variables for current session
SET "MOSIM_MSBUILD=%DEFAULT_MOSIM_MSBUILD%"
SET "MOSIM_UNITY=%DEFAULT_MOSIM_UNITY%"
SET "MOSIM_TARGET_PATH=%DEFAULT_MOSIM_TARGET_PATH%"

ECHO Successfully set all variables
ECHO MOSIM_MSBUILD is set to "%MOSIM_MSBUILD%"
ECHO MOSIM_Unity is set to "%MOSIM_UNITY%"
ECHO MOSIM_TARGET_PATH is set to "%MOSIM_TARGET_PATH%"


pause

exit /b 0


:CheckPowershell
SET "PSCMD=$ppid=$pid;while($i++ -lt 3 -and ($ppid=(Get-CimInstance Win32_Process -Filter ('ProcessID='+$ppid)).ParentProcessId)) {}; (Get-Process -EA Ignore -ID $ppid).Name"

for /f "tokens=*" %%i in ('powershell -noprofile -command "%PSCMD%"') do SET %1=%%i

IF ["%PARENT%"] == ["powershell"] (
	ECHO This script should not run from within a Powershell but a Command Prompt aka cmd
	call :halt 1
) ELSE (
    exit /b 1
)

:: Sets the errorlevel and stops the batch immediately
:halt
call :__SetErrorLevel %1
call :__ErrorExit 2> nul
goto :eof

:__ErrorExit
rem Creates a syntax error, stops immediately
pause
() 
goto :eof

:__SetErrorLevel
exit /b %time:~-2%
goto :eof
