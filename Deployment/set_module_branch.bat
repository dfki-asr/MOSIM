@echo off

SET DEPLOY= %CD%
cd ..
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

set Gmod1= %CD%\Repos\MOSIM-CSharp\.gitmodules
set Gmod2= %CD%\Repos\MOSIM-Unity\.gitmodules
set Gmod3= %CD%\Repos\MOSIM-Unreal\.gitmodules
set Gmod4= %CD%\Repos\\MOSIM-Python\MMUs\.gitmodules
set Gmod5= %CD%\Repos\Packages\MMIUnity-Core\.gitmodules
set Gmod6= %CD%\Repos\MOSIM-Unity\MMUs\dfki.mmiunity-core\MMIUnity-Core\.gitmodules
set Gmod7= %CD%\Repos\MOSIM-Unity\Adapter\MMIAdapterUnity\Library\PackageCache\de.dfki.mmiunity-core@0e765b5bd2\.gitmodules
set Gmod8= %CD%\Repos\MOSIM-Unity\Services\UnityPathPlanning\UnityPathPlanningService\Library\PackageCache\de.dfki.mmiunity-core@0e765b5bd2\.gitmodules
cd %Deploy%

python Scripts/String-replace.py %Gmod1% branch %branch%
python Scripts/String-replace.py %Gmod2% branch %branch%
python Scripts/String-replace.py %Gmod3% branch %branch%
python Scripts/String-replace.py %Gmod4% branch %branch%
python Scripts/String-replace.py %Gmod5% branch %branch%
python Scripts/String-replace.py %Gmod6% branch %branch%
python Scripts/String-replace.py %Gmod7% branch %branch%
python Scripts/String-replace.py %Gmod8% branch %branch%

Echo.
Echo.

Echo "All submodules should now be set to branch: %branch%"

pause