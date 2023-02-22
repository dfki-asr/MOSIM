FROM mono:latest

MAINTAINER Klaus Fischer <Klaus.Fischer@dfki.de>

EXPOSE 8900

RUN apt-get update \ 
   && apt-get -y install git \
   && apt-get -y install mono-complete

RUN cd ~ \
   && git clone https://github.com/dfki-asr/MOSIM-CSharp
   
RUN cd ~/MOSIM-CSharp \
	&& git submodule update --init --remote --recursive
	
WORKDIR /root/MOSIM-CSharp/Core/MMICSharp-Core
RUN nuget restore MMICSharp-Core.sln
RUN msbuild /p:Configuration=Release MMICSharp-Core.sln

WORKDIR /root/MOSIM-CSharp/Services/RetargetingService
RUN nuget restore RetargetingService.sln
RUN msbuild /p:Configuration=Release RetargetingService.sln

ENTRYPOINT ["mono", "/root/MOSIM-CSharp/Services/RetargetingService/RetargetingService/bin/Release/RetargetingService.exe"]

# ENTRYPOINT ["/bin/bash" ]