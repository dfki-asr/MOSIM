FROM mono:latest

MAINTAINER Klaus Fischer <Klaus.Fischer@dfki.de>

EXPOSE 8900

RUN apt-get update \ 
   && apt-get -y install git \
   && apt-get -y install mono-complete

RUN cd ~ \
    && git clone https://github.com/dfki-asr/MOSIM-CSharp
   
RUN cd ~/MOSIM-CSharp \
	&& git submodule update --init --remote --recursive \
	&& git pull
	
COPY copy.sh /root

WORKDIR /root/MOSIM-CSharp/Core/MMICSharp-Core
RUN nuget restore MMICSharp-Core.sln
RUN msbuild /p:Configuration=Release MMICSharp-Core.sln

WORKDIR /root/MOSIM-CSharp/Core/Adapter
RUN nuget restore Adapter.sln
RUN msbuild /p:Configuration=Release Adapter.sln

WORKDIR /root/MOSIM-CSharp/MMUs
RUN nuget restore CS.sln
RUN msbuild /p:Configuration=Debug CS.sln

WORKDIR /root

RUN /bin/bash -c /root/copy.sh

WORKDIR /Environment/Adapters/CSharpAdapter

ENTRYPOINT [ "mono", "MMIAdapterCSharp.exe"]

# ENTRYPOINT [ "/bin/bash" ]



