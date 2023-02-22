@echo off
REM SPDX-License-Identifier: MIT
REM The content of this file has been developed in the context of the MOSIM research project.
REM Original author(s): Janis Sprenger, Bhuvaneshwaran Ilanthirayan


ECHO.
ECHO _______________________________________________________
ECHO [33mdeploy_unity.bat[0m at %cd%\deploy_unity.bat Deploying the Unity adapter project. 
ECHO _______________________________________________________
ECHO.

if not defined MOSIM_UNITY (
  ECHO [31mMOSIM_UNITY Environment variable pointing to the Unity.exe for Unity version 2019.18.1f1 is missing.[0m
  ECHO    e.g. SETX MOSIM_UNITY "C:\Program Files\Unity Environments\2018.4.1f1\Editor\Unity.exe\"
  ECHO MOSIM_UNITY defined as: "%MOSIM_UNITY%"
  pause
  exit /b 1
) else (
  if not exist "%MOSIM_UNITY%" (
    ECHO Unity does not seem to be installed at "%MOSIM_UNITY%" or path name in deploy_variables.bat is wrong.
    exit /b 2
  )

)

IF EXIST build (
  RD /S/Q build
)

REM Build Unity Project:

ECHO Building the Unity Adapter project. This step may take some while, so please wait...
@REM call "%UNITY2018_4_1%" -batchmode -quit -logFile build.log -projectPath . -buildWindowsPlayer "build/UnityAdapter.exe"
call "%MOSIM_UNITY%" -quit -batchmode -logFile build.log -projectPath "." -executeMethod BuildPathPlanning.CreateServerBuildLinux

if %ERRORLEVEL% EQU 0 (
  COPY .\configurations\avatar.mos build\
  COPY .\description.json build\
  ECHO [92mSuccessfully deployed Unity Adapter[0m
  exit /b 0
) else (
  ECHO [31mDeployment of Unity Adapter failed. Please open the Unity Adapter project within Unity and investigate. [0m
  exit /b 1
)