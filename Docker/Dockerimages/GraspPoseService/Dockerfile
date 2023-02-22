FROM mono:latest

MAINTAINER Klaus Fischer <Klaus.Fischer@dfki.de>

EXPOSE 8900

RUN apt-get update \ 
   && apt-get -y install git

RUN cd ~ \
   && git clone https://github.com/dfki-asr/MOSIM-CSharp
   
RUN cd ~/MOSIM-CSharp \
	&& git submodule update --init --remote --recursive
	
WORKDIR /root/MOSIM-CSharp/Core/MMICSharp-Core
RUN nuget restore MMICSharp-Core.sln
RUN msbuild /p:Configuration=Release MMICSharp-Core.sln

WORKDIR /root/MOSIM-CSharp/Services/GraspPoseService

RUN nuget restore GraspPoseService.sln
RUN msbuild /p:Configuration=Release GraspPoseService.sln

ENTRYPOINT ["mono", "/root/MOSIM-CSharp/Services/GraspPoseService/GraspPoseService/bin/Release/GraspPoseService.exe"]

# ENTRYPOINT ["/bin/bash" ]