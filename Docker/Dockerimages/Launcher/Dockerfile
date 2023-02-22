FROM mono:latest

MAINTAINER Klaus Fischer <Klaus.Fischer@dfki.de>

EXPOSE 9009

RUN apt-get update \ 
   && apt-get -y install git

RUN cd ~ \
    && git clone https://github.com/dfki-asr/MOSIM-CSharp
   
RUN cd ~/MOSIM-CSharp \
	&& git pull \
	&& git submodule update --init --remote --recursive
	
WORKDIR /root/MOSIM-CSharp/Core/MMICSharp-Core
RUN nuget restore MMICSharp-Core.sln
RUN msbuild /p:Configuration=Release MMICSharp-Core.sln
	
RUN cd ~/MOSIM-CSharp/Core/Launcher \
	&& mkdir packages
	
WORKDIR /root/MOSIM-CSharp/Core/Launcher/MMILauncher.Console
RUN nuget restore MMILauncher.Console.csproj -PackagesDirectory ../packages
RUN msbuild /p:Configuration=Debug MMILauncher.Console.csproj

WORKDIR /root/MOSIM-CSharp/Core/Launcher/MMILauncher.Console/bin/Debug

RUN mkdir ../Adapters
RUN mkdir ../MMUs
RUN mkdir ../Services

RUN chmod +x MMILauncher.Console.exe
CMD [ "mono", "MMILauncher.Console.exe"]
# CMD [ "/bin/bash" ]
