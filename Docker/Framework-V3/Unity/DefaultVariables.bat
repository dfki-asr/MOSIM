@echo off

call :CheckPowershell PARENT

REM Please adjust the following paths to your system. 
SET "DEFAULT_MOSIM_MSBUILD=C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\MSBuild\Current\Bin\MSBuild.exe"
SET "DEFAULT_MOSIM_UNITY=C:\Program Files\Unity\Hub\Editor\2021.3.9f1\Editor\Unity.exe"
SET "DEFAULT_MOSIM_TARGET_PATH=C:\entw\MOSIM\Docker\Unity"
SET "DOCKER_MOSIM_HOME=C:\tmp\MOSIM"

REM Please do not adjust the following values
REM These values are set to be used in the following session
REM and for partial deployments. 

REM Set variables persistently
ECHO Setting environment variables to User
SETX MOSIM_MSBUILD "%DEFAULT_MOSIM_MSBUILD%"
SETX MOSIM_UNITY "%DEFAULT_MOSIM_UNITY%"
SETX MOSIM_TARGET_PATH %DEFAULT_MOSIM_TARGET_PATH%
REM set variables for current session

ECHO Setting local variables for this CMD session
SET "MOSIM_MSBUILD=%DEFAULT_MOSIM_MSBUILD%"
SET "MOSIM_UNITY=%DEFAULT_MOSIM_UNITY%"
SET "MOSIM_TARGET_PATH=%DEFAULT_MOSIM_TARGET_PATH%"

ECHO Successfully set all variables
ECHO MOSIM_MSBUILD is set to "%MOSIM_MSBUILD%"
ECHO MOSIM_Unity is set to "%MOSIM_UNITY%"
ECHO MOSIM_TARGET_PATH is set to "%MOSIM_TARGET_PATH%"
ECHO DOCKER_MOSIM_HOME is set to "%DOCKER_MOSIM_HOME%"


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
