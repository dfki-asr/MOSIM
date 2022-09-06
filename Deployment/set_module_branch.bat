@echo off

REM Set absolute path to meta repository
SET HOME2=%~dp0\..
FOR /F %%i IN ("%HOME2%") DO SET "HOME=%%~fi"

set current_branch=
for /F "delims=" %%n in ('git branch --show-current') do set "current_branch=%%n"
if "%current_branch%"=="" echo Not a git branch! && goto :EOF

ECHO "This batch file changes the .gitmodule files of submodules"
ECHO "The branch will be changed to your input"
ECHO "                        "
ECHO " ---------------------- "
ECHO "        _   __ ___      "
ECHO " |\/| / \ (_   |  |\/|  " 
ECHO " |  | \_/ __) _|_ |  |  "
ECHO "                        "
ECHO " ---------------------- "
ECHO.
ECHO.
echo "The current branch of MOSIM is %current_branch%"
echo "The remote branches are:"
git branch -r

echo.
echo.
ECHO "Set the branch for the gitmodules. Example: to set develop as branch write 'develop' "
set /p branch=

REM this is redundant, as it was already changed in MMIUnity-Core
REM set Gmod6= %HOME%\Repos\MOSIM-Unity\MMUs\dfki.mmiunity-core\MMIUnity-Core\.gitmodules
REM this is redundant, as it is an auto-generated library file. 
REM set Gmod7= %HOME%\Repos\MOSIM-Unity\Adapter\MMIAdapterUnity\Library\PackageCache\de.dfki.mmiunity-core@0e765b5bd2\.gitmodules
REM this is redundant as it is an auto-generated library package cache. 
REM set Gmod8= %HOME%\Repos\MOSIM-Unity\Services\UnityPathPlanning\UnityPathPlanningService\Library\PackageCache\de.dfki.mmiunity-core@0e765b5bd2\.gitmodules

cd %HOME%/Deployment

python Scripts/String-replace.py %HOME%\Repos\MOSIM-CSharp\.gitmodules branch %branch%
python Scripts/String-replace.py %HOME%\Repos\MOSIM-Python\MMUs\.gitmodules branch %branch%
python Scripts/String-replace.py %HOME%\Repos\MOSIM-Unity\.gitmodules branch %branch%
python Scripts/String-replace.py %HOME%\Repos\MOSIM-Unreal\.gitmodules branch %branch%

python Scripts/String-replace.py %HOME%\Repos\Packages\MMIUnity-Core\.gitmodules branch %branch%

Echo.
Echo.

Echo "All submodules should now be set to branch: %branch%"

ECHO "To update the unity packages, please call Deployment\set_remote_unity_pacakges.bat separately. 

pause