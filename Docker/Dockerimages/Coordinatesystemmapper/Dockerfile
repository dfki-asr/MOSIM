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

WORKDIR /root/MOSIM-CSharp/Services/CoordinateSystemMapper

RUN nuget restore CoordinateSystemMapper.sln
RUN msbuild /p:Configuration=Release CoordinateSystemMapper.sln

ENTRYPOINT ["mono", "/root/MOSIM-CSharp/Services/CoordinateSystemMapper/CoordinateSystemMapper/bin/Release/CoordinateSystemMapper.exe"]

# ENTRYPOINT ["/bin/bash" ]