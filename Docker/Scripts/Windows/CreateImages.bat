echo "Hallo1: %cd%"

set "mypwd=%cd%"

echo "Hallo2: %mypwd%"

cd "%mypwd%\BlenderIK"

REM docker build -t blenderik .

cd "%mypwd%\Coordinatesystemmapper"

docker build -t coordinatesystemmapper .

cd "%mypwd%\CoSimulation"

docker build -t cosimulation .

cd "%mypwd%\CsharpAdapter"

docker build -t csharpadapter .

cd "%mypwd%\GraspPoseService"

docker build -t grasppose .

cd "%mypwd%\PostureBlendingService"

docker build -t postureblending .

cd "%mypwd%\RetargetingService"

docker build -t retargeting .

cd "%mypwd%\SkeletonAccessService"

docker build -t skeletonaccess .

cd "%mypwd%\UnityAdapter"

CreateDockerImagesUnityAdapter.bat

cd "%mypwd%\UnityPathPlanning"

CreateDockerImagesUnityPathPlanning.bat
