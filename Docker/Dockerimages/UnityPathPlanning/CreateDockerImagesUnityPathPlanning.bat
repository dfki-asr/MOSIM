@echo off

set "MOSIM_UNITY=C:\Program Files\Unity\Hub\Editor\2019.4.25f1\Editor\Unity.exe"
set "MOSIM_UNITY_HOME=%UserProfile%\tmp\MOSIM-Unity"
set "MOSIM_TARGET_PATH=%~dp0build"

if not exist %MOSIM_UNITY_HOME% (
	git clone git@github.com:dfki-asr/MOSIM-Unity.git %MOSIM_UNITY_HOME%
	cd %MOSIM_UNITY_HOME%
	git submodule update --init --remote --recursive
)

if not exist %MOSIM_UNITY_HOME%\Services\UnityPathPlanning\UnityPathPlanningService\build (
	echo "%MOSIM_UNITY_HOME%\Services\UnityPathPlanning\UnityPathPlanningService"
	cd %MOSIM_UNITY_HOME%\Services\UnityPathPlanning\UnityPathPlanningService
	call %~dp0deploy_unity_linux.bat
)

if not exist %MOSIM_TARGET_PATH% (
	md %MOSIM_TARGET_PATH%
	echo %MOSIM_UNITY_HOME%\Services\UnityPathPlanning\UnityPathPlanningService\build\
	dir "%MOSIM_UNITY_HOME%\Services\UnityPathPlanning\UnityPathPlanningService\build\"
	xcopy /y/E/H %MOSIM_UNITY_HOME%\Services\UnityPathPlanning\UnityPathPlanningService\build\ %MOSIM_TARGET_PATH%
)

if not exist "%MOSIM_TARGET_PATH%\Dockerfile" (
	copy "%~dp0Dockerfile" "%MOSIM_TARGET_PATH%"
)

if not exist "%MOSIM_TARGET_PATH%\run.sh" (
	copy "%~dp0\run.sh" "%MOSIM_TARGET_PATH%"
)

cd "%MOSIM_TARGET_PATH%

docker build -t unitypathplanning .

echo "Docker image for Unity Path Planning successfully built."

