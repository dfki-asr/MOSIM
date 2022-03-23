@echo off

REM SPDX-License-Identifier: MIT
REM The content of this file has been developed in the context of the MOSIM research project.
REM Original author(s): Janis Sprenger, Bhuvaneshwaran Ilanthirayan, Klaus Fischer

REM This is a deploy script to auto-generate the components of the MOSIM-CSharp projects and move them to a new environment folder. 

SET VERBOSE=0

ECHO " ---------------------- "
ECHO "        _   __ ___      "
ECHO " |\/| / \ (_   |  |\/|  " 
ECHO " |  | \_/ __) _|_ |  |  "
ECHO "                        "
ECHO " ---------------------- "
ECHO.

call :CheckEnv

call :argparse %*

goto :eof

REM call :safeCall deploy_variables.bat "There has been an error when setting the deploy vaiables!"

REM if not exist %BUILDENV% (
REM   md %BUILDENV%
REM )

REM COPY Scripts\enableFirewall.exe .\build\

REM echo Removing doublicated MMUs
pause
call .\remove_double_mmus.bat

echo Removing doublicated MMUs done.

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


:argparse
	if [%1]==[] (
		call :DisplayUsage
		exit /b 0
	)
	if "%1"=="-h" (
		call :DisplayUsage
		exit /b 0
	)
	if "%1"=="--help" ( 
		call :DisplayUsage
		exit /b 0
	)
	if "%1"=="/?" ( 
		call :DisplayUsage
		exit /b 0
	)
	
	FOR /F %%i IN ("%1") DO SET "MOSIM_HOME=%%~fi"
	
	REM SET MOSIM_HOME=%DEPLOY%\Environment
	
	if not exist "%MOSIM_HOME%" (
		REM call :FolderNotFound
		ECHO Creating new environment folder at %MOSIM_HOME%
		MD %MOSIM_HOME%
		MD %MOSIM_HOME%\Environment
		MD %MOSIM_HOME%\Environment\Adapters
		MD %MOSIM_HOME%\Environment\Launcher
		MD %MOSIM_HOME%\Environment\MMUs
		MD %MOSIM_HOME%\Environment\Services
	) ELSE (
		ECHO Updating existing environment in %MOSIM_HOME%
	)	
	
	SET BUILDENV=%MOSIM_HOME%\Environment
	SET LIBRARYPATH=%MOSIM_HOME%\Libraries
	SET REPO2=%~dp0\..\
	FOR /F %%i IN ("%REPO2%") DO SET "TOPLEVELREPO=%%~fi"
	SHIFT
	
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
	echo        -m DeployCS : Deploy only C# components
	echo        -m DeployUnity : Deploy only Unity components
	echo        -m DeployPython : Deploy only Python components
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
	COPY %TOPLEVELREPO%\Deployment\Scripts\enableFirewall.exe %MOSIM_HOME%
	explorer %MOSIM_HOME%

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
			call :halt 1
		)
	) ELSE (
		ECHO Compilation requires Visual Studio. Please setup the variable MOSIM_MSBUILD to point to Visual Studio MSBUILD.
		ECHO example: setx MOSIM_MSBUILD "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\MSBuild\Current\Bin\MSBuild.exe"
		call :halt 1
	)
exit /b 0

:: Sets the errorlevel and stops the batch immediately
:halt
call :__SetErrorLevel %1
call :__ErrorExit 2> nul
goto :eof

:__ErrorExit
rem Creates a syntax error, stops immediately
() 
goto :eof

:__SetErrorLevel
exit /b %time:~-2%
goto :eof
