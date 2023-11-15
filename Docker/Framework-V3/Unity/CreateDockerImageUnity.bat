@echo off

SET VERBOSE=0
REM SET DIRTY=0
REM SET mode=Debug

call :CheckPowershell PARENT

call DefaultVariables.bat

call :CheckEnv

if not exist %DOCKER_MOSIM_HOME% (
	cd %DOCKER_MOSIM_HOME%\..
	meta git clone git@github.com:dfki-asr/MOSIM.git %DOCKER_MOSIM_HOME%
	cd "%~dp0"
)

copy DefaultVariables.bat "%DOCKER_MOSIM_HOME%\Deployment\"
echo "Hallo 1"
copy Adapter\deploy.bat "%DOCKER_MOSIM_HOME%\Repos\MOSIM-Unity\Adapter\MMIAdapterUnity\"
copy Adapter\deploy_unity_linux.bat "%DOCKER_MOSIM_HOME%\Repos\MOSIM-Unity\Adapter\MMIAdapterUnity\"
copy PathPlanning\deploy.bat "%DOCKER_MOSIM_HOME%\Repos\MOSIM-Unity\Services\UnityPathPlanning\"
copy PathPlanning\deploy_unity_linux.bat "%DOCKER_MOSIM_HOME%\Repos\MOSIM-Unity\Services\UnityPathPlanning\"

echo "Hallo 2"

if not exist "%MOSIM_TARGET_PATH%\Environment" (
	cd %DOCKER_MOSIM_HOME%\Deployment
	call Initialize.bat
	cd %DOCKER_MOSIM_HOME%\Deployment
	call deplOy.bat -m Unit
)

cd "%~dp0"

REM docker build -t unity .

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

::MSBUILD
:MSBUILD

  for /F "delims=" %%i in (%1) do set dirname="%%~dpi"
  for /F "delims=" %%i in (%1) do set filename="%%~nxi"
  
  set mode=Debug
  SETLOCAL EnableDelayedExpansion 
  
  set back=%CD%

  echo "Hallo 2 %dirname%"
  
  if exist %dirname% (
  	echo "Hallo 3"
	echo %dirname%
	echo %filename%
  )
  
  if exist %dirname% (
	echo "Hallo 3"
	cd %dirname%
	
	if %VERBOSE%==1 (
		"%MOSIM_MSBUILD%" %filename% -t:restore -p:RestorePackagesConfig=true
		"%MOSIM_MSBUILD%" %filename% -t:Build -p:Configuration=%mode% -flp:logfile=build.log
	) else (
		>>deploy.log (
			"%MOSIM_MSBUILD%" %filename% -t:restore -p:RestorePackagesConfig=true
			"%MOSIM_MSBUILD%" %filename% -t:Build -p:Configuration=%mode% -flp:logfile=build.log
		)
	)
  )
	REM If the build was sucessfull, copy all files to the respective build folders. 
	
	echo "Hallo 4"

	if !ERRORLEVEL! EQU 0 (
		if not [%2]==[] (
			if %VERBOSE%==1 (
				ECHO copy from ".\%2\%mode%\*" to "%BUILDENV%\%3\"
				cmd /c xcopy /S/Y/Q ".\%2\%mode%\*" "%BUILDENV%\%3\"
			) else (
				>>deploy.log (
					cmd /c xcopy /S/Y/Q ".\%2\%mode%\*" "%BUILDENV%\%3\"
				)
			)
		)
		if not [%4]==[] (
			if %VERBOSE%==1 (
				cmd /c xcopy /S/Y/Q ".\%4\%mode%\*" "%BUILDENV%\%5\"
			) else (
				>>deploy.log (
					cmd /c xcopy /S/Y/Q ".\%4\%mode%\*" "%BUILDENV%\%5\"
				)
			)
		)
		if not [%6]==[] (
			if %VERBOSE%==1 (
				cmd /c xcopy /S/Y/Q ".\%6\%mode%\*" "%BUILDENV%\%7\"
			) else (
				>>deploy.log (
					cmd /c xcopy /S/Y/Q ".\%6\%mode%\*" "%BUILDENV%\%7\"
				)
			)
		)
		ECHO [92mSuccessfully deployed %filename%. [0m
	) else (
		type deploy.log 
		ECHO [31mDeployment of %filename% failed. Please consider the build.log for more information.[0m 
		cd %back%
		call :halt %ERRORLEVEL%
	)
  ) else (
    ECHO -----------
	ECHO [31m Path %1 does not exist and thus will not be deployed.[0m
	ECHO -----------
  )
cd %back%
exit /b


