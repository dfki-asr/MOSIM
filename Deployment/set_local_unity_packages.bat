@echo off

SET MANIFEST= %~dp0..\Repos\MOSIM-Unity\Demos\SimpleUnityDemo\Packages\manifest.json
SET MANIFEST2= %~dp0..\Repos\MOSIM-Unity\Tools\SkeletonConfigurator\Packages\manifest.json
SET DEPLOY= %CD%
cd ..
SET HOME=%CD%
cd %DEPLOY%
SET REPLACE1= file:%HOME%/Repos/Packages/MMIUnity-Core
SET REPLACE2= file:%HOME%/Repos/Packages/MMIUnity-TargetEngine

ECHO "This batch file changes the manifest.json."
ECHO "It will result in the local packages being used as the Unity packages."
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
