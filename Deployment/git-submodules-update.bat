@echo off

SET BACK="%CD%"
SET REPO2=%~dp0\..\
FOR /F %%i IN ("%REPO2%") DO SET "TOPLEVELREPO=%%~fi"

cd %TOPLEVELREPO%/Repos/MOSIM-CSharp
git submodule update --remote --recursive --init

cd %TOPLEVELREPO%/Repos/MOSIM-Unity
git submodule update --remote --recursive --init

cd %TOPLEVELREPO%/Repos/MOSIM-Python
git submodule update --remote --recursive --init

cd %TOPLEVELREPO%/Repos/Packages/MMIUnity-Core
git submodule update --remote --recursive --init

cd %BACK%