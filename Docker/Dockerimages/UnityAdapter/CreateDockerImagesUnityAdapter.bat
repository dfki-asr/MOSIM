@echo off

set "MOSIM_UNITY=C:\Program Files\Unity\Hub\Editor\2019.4.25f1\Editor\Unity.exe"
set "MOSIM_UNITY_HOME=%UserProfile%\tmp\MOSIM-Unity"
set "MOSIM_TARGET_PATH=%~dp0build"

if not exist %MOSIM_UNITY_HOME% (
	git clone git@github.com:dfki-asr/MOSIM-Unity.git %MOSIM_UNITY_HOME%
	cd %MOSIM_UNITY_HOME%
	git submodule update --init --remote --recursive
)

if not exist %MOSIM_UNITY_HOME%\Adapter\MMIAdapterUnity\build (
	echo "%MOSIM_UNITY_HOME%\Adapter\MMIAdapterUnity"
	cd %MOSIM_UNITY_HOME%\Adapter\MMIAdapterUnity
	echo "Hallo 1"
	call %~dp0deploy_unity_linux.bat
)

if not exist %MOSIM_TARGET_PATH% (
	md %MOSIM_TARGET_PATH%
	xcopy /y/E/H %MOSIM_UNITY_HOME%\Adapter\MMIAdapterUnity\build\ %MOSIM_TARGET_PATH%
)

if not exist "%MOSIM_TARGET_PATH%\MMUs" (
	md %MOSIM_TARGET_PATH%\MMUs
	xcopy /y/E/H %MOSIM_UNITY_HOME%\MMUs\build\ %MOSIM_TARGET_PATH%\MMUs
)

if not exist "%MOSIM_TARGET_PATH%\Dockerfile" (
	copy "%~dp0Dockerfile" "%MOSIM_TARGET_PATH%"
)

if not exist "%MOSIM_TARGET_PATH%\run.sh" %MOSIM_TARGET_PATH%(
	copy "%~dp0\run.sh" "%MOSIM_TARGET_PATH%"
)

cd "%MOSIM_TARGET_PATH%"

docker build -t unityadapter .

echo "Unity Adapter Docker image successfully built."

