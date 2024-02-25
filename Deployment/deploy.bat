@echo off
@setlocal enabledelayedexpansion

REM SPDX-License-Identifier: MIT
REM The content of this file has been developed in the context of the MOSIM research project.
REM Original author(s): Janis Sprenger, Bhuvaneshwaran Ilanthirayan, Klaus Fischer

REM This is a deploy script to auto-generate the components of the MOSIM-CSharp projects and move them to a new environment folder. 

call :CheckPowershell PARENT

SET VERBOSE=0

ECHO " ---------------------- "
ECHO "        _   __ ___      "
ECHO " |\/| / \ (_   |  |\/|  " 
ECHO " |  | \_/ __) _|_ |  |  "
ECHO "                        "
ECHO " ---------------------- "
ECHO.

call :argparseHelp %*

call %~dp0\DefaultVariables.bat

call :CheckEnv

call :argparse %*

goto :eof

REM call :safeCall deploy_variables.bat "There has been an error when setting the deploy vaiables!"

REM if not exist %BUILDENV% (
REM   md %BUILDENV%
REM )

REM COPY Scripts\enableFirewall.exe .\build\

REM the link currently does not yet work. 
REM RD build\
REM 
REM call ..\Scripts\link.vbs StartFramework.lnk Environment\Launcher\MMILauncher.exe
REM CD ..\


ECHO [92mSuccessfully deployed the Framework to %cd%/build/Environment.   [0m
ECHO If this is the first time, the framework was deployed, consider utilizing the script %cd%\build\enableFirewall.exe to setup all firewall exceptions. 
ECHO [92mTo start the framework[0m, start the launcher at %cd%\build\Environment\Launcher\MMILauncher.exe To use the framework, please open the Unity Demo-Scene at %cd%\Demos\Unity or any other MOSIM-enabled Project.

REM explorer.exe %cd%\build

pause

:argparseHelp
	if "%1"=="-h" (
		call :DisplayUsage
		call :halt 0
	)
	if "%1"=="--help" ( 
		call :DisplayUsage
		call :halt 0
	)
	if "%1"=="/?" ( 
		call :DisplayUsage
		call :halt 0
	)
exit /b 0

:argparse
	
	SET REPO2=%~dp0\..\
	FOR /F %%i IN ("%REPO2%") DO SET "TOPLEVELREPO=%%~fi"
	
	IF "%1"=="" (
		ECHO Taking default MOSIM Target Path "%MOSIM_TARGET_PATH%"
		SET "MOSIM_HOME=%MOSIM_TARGET_PATH%"
	) ELSE (
		SET "var=%1"
		IF "!var:~0,1!"=="-" (
			ECHO Taking default MOSIM Target Path "%MOSIM_TARGET_PATH%"
			SET "MOSIM_HOME=%MOSIM_TARGET_PATH%"
		) ELSE (
			FOR /F %%i IN ("%1") DO SET "MOSIM_HOME=%%~fi"	
			ECHO Taking provided MOSIM Target Path at "!MOSIM_HOME!"
			SHIFT
		)
	)
	
	if "%MOSIM_HOME%"=="" (
		ECHO Please provide a target directory 
		ECHO     - either as a parameter to this script or 
		ECHO     - adjust the Deployment\DefaultVariables.bat in the meta repository and run Deployment\Initialize.bat
		ECHO     - or use SETX MOSIM_TARGET_PATH C:\Path\To\My\Target to set the variable manually. 
		call :halt 1
	)
	
	
	
	REM SET MOSIM_HOME=%DEPLOY%\Environment
	
	if not exist "%MOSIM_HOME%" (
		REM call :FolderNotFound
		ECHO Creating new environment folder at "%MOSIM_HOME%"
		MD "%MOSIM_HOME%"
		MD "%MOSIM_HOME%\Environment"
		MD "%MOSIM_HOME%\Environment\Adapters"
		MD "%MOSIM_HOME%\Environment\Launcher"
		MD "%MOSIM_HOME%\Environment\MMUs"
		MD "%MOSIM_HOME%\Environment\Services"
	) ELSE (
		ECHO Updating existing environment in "%MOSIM_HOME%"
	)	
	
	SET "BUILDENV=%MOSIM_HOME%\Environment"
	SET "LIBRARYPATH=%MOSIM_HOME%\Libraries"

	
	if "%1"=="-v" (
		ECHO Running in Verbose mode
		SET VERBOSE=1
		SHIFT
	)
	
	if [%1]==[] (
		call :DeployAll
		exit /b 0
	)

	:argparse_loop
	if not [%1]==[] (
		if "%1"=="-m" (
			if "%2"=="CSharp" (
				call :DeployCS
			) ELSE (
				if "%2"=="Unity" (
					call :DeployUnity
				) ELSE (
					if "%2"=="Python" (
						call :DeployPython
					) ELSE (
						IF "%2"=="Packages" (
							call :CopyPackages
						)
					)
				)
			)
			SHIFT
		) else ( 
			if "%1"=="-a" (
				call :DeployAll
			)
		)
		SHIFT
		goto :argparse_loop
	)
	
exit /b 0


::DisplayUsage
:DisplayUsage
	echo Usage of this deploy script: 
	echo.
	echo deploy.bat destination [-m Component] 
	echo        -m CSharp : Deploy only C# components
	echo        -m Unity : Deploy only Unity components
	echo        -m Python : Deploy only Python components
	echo        -m Packages : Copy Packages to output directory
	echo.
	echo deploy.bat -h: Display this information
exit /b 0

::FolderNotFound
:FolderNotFound
	echo Folder Not Found
exit /b 0

::DeployCS
:DeployCS
	ECHO Deploy CS at "%TOPLEVELREPO%\Repos\MOSIM-CSharp\Deployment\deploy.bat" %MOSIM_HOME%
	call "%TOPLEVELREPO%\Repos\MOSIM-CSharp\Deployment\deploy.bat" %MOSIM_HOME%
exit /b 0

::DeployUnity
:DeployUnity
	ECHO Deploy Unity at "%TOPLEVELREPO%\Repos\MOSIM-Unity\Deployment\deploy.bat" %MOSIM_HOME%
	call "%TOPLEVELREPO%\Repos\MOSIM-Unity\Deployment\deploy.bat" %MOSIM_HOME%
exit /b 0

::DeployPython
:DeployPython
	call "%TOPLEVELREPO%\Repos\MOSIM-Python\Deployment\deploy.bat" %MOSIM_HOME%
exit /b 0

:CopyPackages
	if NOT EXIST "%MOSIM_HOME%/packages" (
		MD "%MOSIM_HOME%/packages"
	)
	if EXIST "%MOSIM_HOME%/packages/MMIPython-Core" (
		RMDIR /S/Q "%MOSIM_HOME%/packages/MMIPython-Core"
	)
	cmd /c xcopy /S/Y/Q "%TOPLEVELREPO%/Repos/packages/MMIPython-Core" "%MOSIM_HOME%/packages/MMIPython-Core\"
	python "%MOSIM_HOME%/packages/MMIPython-Core\setup.py" clean --all
	
	if EXIST "%MOSIM_HOME%/packages/MMIUnity-Core" (
		RMDIR /S/Q "%MOSIM_HOME%/packages/MMIUnity-Core"
	)
	cmd /c xcopy /S/Y/Q "%TOPLEVELREPO%/Repos/packages/MMIUnity-Core" "%MOSIM_HOME%/packages/MMIUnity-Core\"
	
	if EXIST "%MOSIM_HOME%/packages/MMIUnity-TargetEngine" (
		RMDIR /S/Q "%MOSIM_HOME%/packages/MMIUnity-TargetEngine"
	)
	cmd /c xcopy /S/Y/Q/D "%TOPLEVELREPO%/Repos/packages/MMIUnity-TargetEngine" "%MOSIM_HOME%/packages/MMIUnity-TargetEngine\"
	
	if EXIST "%MOSIM_HOME%/packages/MMU-Generator" (
		RMDIR /S/Q "%MOSIM_HOME%\packages\MMU-Generator\"
	)
	cmd /c xcopy /S/Y/Q "%TOPLEVELREPO%/Repos/packages/MMU-Generator" "%MOSIM_HOME%/packages/MMU-Generator\"
	
exit /b 0

::DeployAll
:DeployAll
	ECHO Deploy all languages
	call :DeployCS
	call :DeployUnity
	call :DeployPython
	COPY "%TOPLEVELREPO%\Deployment\Scripts\enableFirewall.exe" "%MOSIM_HOME%"
	explorer "%MOSIM_HOME%"

exit /b 0

::CopyFiles
:CopyFiles

exit /b 0

::Check Environment Variables
:CheckEnv
	IF NOT "%MOSIM_MSBUILD%"=="" (
		IF NOT EXIST "%MOSIM_MSBUILD%" (
			ECHO Please update your environment variable MOSIM_MSBUILD to point to Visual Studio MSBUILD.
			ECHO example: setx MOSIM_MSBUILD "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\MSBuild\Current\Bin\MSBuild.exe"
			ECHO.
			ECHO Or adjust the default variables and run the Initialize script in the Meta repository. 
			call :halt 1
		)
	) ELSE (
		ECHO Compilation requires Visual Studio. Please setup the variable MOSIM_MSBUILD to point to Visual Studio MSBUILD.
		ECHO example: setx MOSIM_MSBUILD "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\MSBuild\Current\Bin\MSBuild.exe"
		ECHO.
		ECHO Or adjust the default variables and run the Initialize script in the Meta repository. 
		call :halt 1
	)
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
