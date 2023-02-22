FROM mono:latest

MAINTAINER Klaus Fischer <Klaus.Fischer@dfki.de>

EXPOSE 8900
EXPOSE 8901

RUN apt-get update \ 
   && apt-get -y install git

RUN cd ~ \
    && git clone https://github.com/dfki-asr/MOSIM-CSharp
  
RUN cd ~/MOSIM-CSharp \
	&& git pull \
	&& git submodule update --init --remote --recursive \
	&& git pull
	
WORKDIR /root/MOSIM-CSharp/Core/MMICSharp-Core
RUN nuget restore MMICSharp-Core.sln
RUN msbuild /p:Configuration=Release MMICSharp-Core.sln

WORKDIR /root/MOSIM-CSharp/Core/CoSimulator
RUN nuget restore MMICoSimulator.sln
RUN msbuild /p:Configuration=Release MMICoSimulator.sln

WORKDIR /root/MOSIM-CSharp/Core/CoSimulator/CoSimulationStandalone/bin/Release/

ENTRYPOINT [ "mono", "CoSimulationStandalone.exe"]

