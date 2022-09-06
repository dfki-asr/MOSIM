@echo off

REM Set absolute path to meta repository
SET HOME2=%~dp0\..
FOR /F %%i IN ("%HOME2%") DO SET "HOME=%%~fi"

REM get current branch
cd %HOME%\Repos\MOSIM-Unity
set current_branch=
for /F "delims=" %%n in ('git branch --show-current') do set "current_branch=%%n"
if "%current_branch%"=="" echo Not a git branch! && goto :EOF


if "%current_branch%"=="master" DO (
	SET REPLACE1= https://github.com/dfki-asr/MMIUnity-Core.git
	SET REPLACE2= https://github.com/dfki-asr/MMIUnity-TargetEngine.git
) else (
	SET REPLACE1= https://github.com/dfki-asr/MMIUnity-Core.git#%Current_Branch%
	SET REPLACE2= https://github.com/dfki-asr/MMIUnity-TargetEngine.git#%Current_Branch%
)

cd %HOME%\Deployment


ECHO "This batch file changes the manifest.json."
ECHO "It will result in the git packages being used as the Unity packages."
echo "The current branch of MOSIM-Unity is %current_branch%"
ECHO "                        "
ECHO " ---------------------- "
ECHO "        _   __ ___      "
ECHO " |\/| / \ (_   |  |\/|  " 
ECHO " |  | \_/ __) _|_ |  |  "
ECHO "                        "
ECHO " ---------------------- "
ECHO.

SET MANIFEST= %HOME%\Repos\MOSIM-Unity\Demos\SimpleUnityDemo\Packages\manifest.json
python Scripts\String-replace.py %MANIFEST% de.dfki.mmiunity-core %REPLACE1%
python Scripts\String-replace.py %MANIFEST% de.dfki.mmiunity-targetengine %REPLACE2%

SET MANIFEST= %HOME%\Repos\MOSIM-Unity\Adapter\MMIAdapterUnity\Packages\manifest.json
python Scripts\String-replace.py %MANIFEST% de.dfki.mmiunity-core %REPLACE1%

SET MANIFEST= %HOME%\Repos\MOSIM-Unity\Services\UnityPathPlanning\UnityPathPlanningService\Packages\manifest.json
python Scripts\String-replace.py %MANIFEST% de.dfki.mmiunity-core %REPLACE1%

SET MANIFEST= %~dp0..\Repos\MOSIM-Unity\Tools\SkeletonConfigurator\Packages\manifest.json
python Scripts\String-replace.py %MANIFEST% de.dfki.mmiunity-core %REPLACE1%

pause