@ECHO off
setlocal

REM C# Code distribution
xcopy /Y %~dp0\gen-csharp %~dp0\..\Repos\Packages\MMICSharp-Core\MMIStandard

REM python copy
xcopy /Y/S/E %~dp0\gen-py\MMIStandard %~dp0\..\Repos\Packages\MMIPython-Core\src\MOSIM\mmi

REM copy Cpp generated code
xcopy /Y %~dp0\gen-cpp\*.h %~dp0\..\Repos\Packages\MMI-UnrealPlugin\Source\MMMIScene\Public\gen-cpp
xcopy /Y %~dp0\gen-cpp\*.cpp %~dp0\..\Repos\Packages\MMI-UnrealPlugin\Source\MMMIScene\Private\gen-cpp