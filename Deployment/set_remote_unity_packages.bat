@echo off

SET MANIFEST= %~dp0..\Repos\MOSIM-Unity\Demos\SimpleUnityDemo\Packages\manifest.json
SET MANIFEST2= %~dp0..\Repos\MOSIM-Unity\Tools\SkeletonConfigurator\Packages\manifest.json
SET DEPLOY= %CD%
cd ..
cd .\Repos\MOSIM-Unity
set current_branch=
for /F "delims=" %%n in ('git branch --show-current') do set "current_branch=%%n"
if "%current_branch%"=="" echo Not a git branch! && goto :EOF

cd %DEPLOY%
SET REPLACE1= https://github.com/dfki-asr/MMIUnity-Core.git#%Current_Branch%
SET REPLACE2= https://github.com/dfki-asr/MMIUnity-TargetEngine.git#%Current_Branch%

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

python Scripts\String-replace.py %MANIFEST% de.dfki.mmiunity-core %REPLACE1%
python Scripts\String-replace.py %MANIFEST% de.dfki.mmiunity-targetengine %REPLACE2%

python Scripts\String-replace.py %MANIFEST2% de.dfki.mmiunity-core %REPLACE1%
pause
