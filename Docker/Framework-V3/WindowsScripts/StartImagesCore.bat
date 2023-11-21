REM @echo off

call SetAddresses.bat

echo %MOSIM_IPA%

REM exit /b

if not defined MOSIM_IPA (
	echo [31mIP address of host not set![0m
	echo [31mPlease set environment variable MOSIM_IPA to the IP address of the host on which you want to run the images.[0m
	echo "[31mPlease note: Using localhost (127.0.0.1) is not supported so far![0m"
	exit /b 1
)

if not defined DOCKER_STDP (
	echo [31mDOCKER_STDP is not defined which should give the standard prot number used in the Docker imagages![0m
	echo [31mPlease set environment variable MOSIM_IPA to the IP address of the host on which you want to run the images.[0m
	echo "[31mPlease note: Using localhost (127.0.0.1) is not supported so far![0m"
	exit /b 1
)

REM start cmd.exe /c "docker run -p %LAUNCHER%:%LAUNCHER% -it -v C:\Repositories\AIToC-MOSIM\MOSIM\Dockerfiles\data:/data launcher:latest"
REM timeout /t 10

REM start cmd.exe /c "docker run -p %BlenderIK%:%DOCKER_STDP% -t blenderik:latest -a %MOSIM_IPA%:%BlenderIK% -aint %DOCKER_STD_IPP% -r %MOSIM_IPA%:%LAUNCHER% -l"
REM timeout /t 10

start cmd.exe /c "docker run -p %CSharpAdapter%:%DOCKER_STDP% -t csharpadapter:latest %MOSIM_IPA% %DOCKER_STDP% %CSharpAdapter% %LAUNCHER% -m ../../MMUs" REM REM 
timeout /t 5

start cmd.exe /c "docker run -p %CoSimulation%:%DOCKER_STDP% -p %CoSimulationServ%:%CoSimulationServInt% -t cosimulation:latest %MOSIM_IPA% %DOCKER_STDP% %CoSimulationServInt% %CoSimulation% %CoSimulationServ% %LAUNCHER%" 
REM timeout /t 5

REM start cmd.exe /c "docker run -p %UnityAdapter%:%DOCKER_STDP% -t unityadapter -a %MOSIM_IPA%:%UnityAdapter% -aint %DOCKER_STD_IPP% -r %MOSIM_IPA%:%LAUNCHER% -m ./MMUs"
REM timeout /t 5

REM start cmd.exe /c "docker run -p %CoordinateSystemMapper%:%DOCKER_STDP% -t coordinatesystemmapper:latest %MOSIM_IPA% %DOCKER_STDP% %CoordinateSystemMapper% %LAUNCHER%"
REM timeout /t 5

REM start cmd.exe /c "docker run -p %PostureBlending%:%DOCKER_STDP% -t postureblending:latest %MOSIM_IPA% %DOCKER_STDP% %PostureBlending% %LAUNCHER%"
REM timeout /t 5 

REM start cmd.exe /c "docker run -p %Retargeting%:%DOCKER_STDP% -t retargeting:latest -a %MOSIM_IPA%:%Retargeting% -aint %DOCKER_STD_IPP% -r %MOSIM_IPA%:%LAUNCHER%"
REM timeout /t 5 

REM start cmd.exe /c "docker run -p %SkeletonAccess%:%DOCKER_STDP% -t skeletonaccess:latest -a %MOSIM_IPA%:%SkeletonAccess% -aint %DOCKER_STD_IPP% -r %MOSIM_IPA%:%LAUNCHER% -l"
REM timeout /t 5

REM start cmd.exe /c "docker run -p 9091:9091 -l -t unityik -a %MOSIM_IPA%:9091 -r %MOSIM_IPA%:9009 -l"
REM timeout /t 5

REM start cmd.exe /c "docker run -p %UnityPathPlanning%:%DOCKER_STDP% -t unitypathplanning -a %MOSIM_IPA%:%UnityPathPlanning% -aint %DOCKER_STD_IPP% -r %MOSIM_IPA%:%LAUNCHER%"
REM timeout /t 5
