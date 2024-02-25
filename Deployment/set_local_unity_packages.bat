@echo off

REM Set absolute path to meta repository
SET HOME2=%~dp0\..
FOR /F %%i IN ("%HOME2%") DO SET "HOME=%%~fi"

SET REPLACE1=/Packages/MMIUnity-Core
SET REPLACE2=/Packages/MMIUnity-TargetEngine

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

SET MANIFEST= %HOME%\Repos\MOSIM-Unity\Demos\SimpleUnityDemo\Packages\manifest.json
python Scripts\String-replace.py %MANIFEST% de.dfki.mmiunity-core file:..\..\..\..%REPLACE1%
python Scripts\String-replace.py %MANIFEST% de.dfki.mmiunity-targetengine file:..\..\..\..%REPLACE2%

SET MANIFEST= %HOME%\Repos\MOSIM-Unity\Adapter\MMIAdapterUnity\Packages\manifest.json
python Scripts\String-replace.py %MANIFEST% de.dfki.mmiunity-core file:..\..\..\..%REPLACE1%

SET MANIFEST= %HOME%\Repos\MOSIM-Unity\Services\UnityPathPlanning\UnityPathPlanningService\Packages\manifest.json
python Scripts\String-replace.py %MANIFEST% de.dfki.mmiunity-core file:..\..\..\..\..%REPLACE1%

SET MANIFEST= %HOME%\Repos\MOSIM-Unity\Services\UnityIKService\Packages\manifest.json
python Scripts\String-replace.py %MANIFEST% de.dfki.mmiunity-core file:..\..\..\..%REPLACE1%


SET MANIFEST= %~dp0..\Repos\MOSIM-Unity\Tools\SkeletonConfigurator\Packages\manifest.json
python Scripts\String-replace.py %MANIFEST% de.dfki.mmiunity-core file:..\..\..\..%REPLACE1%

pause
