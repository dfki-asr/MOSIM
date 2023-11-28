FROM mono:latest

MAINTAINER Klaus Fischer <Klaus.Fischer@dfki.de>

EXPOSE 8900

RUN apt-get update \ 
   && apt-get -y install git \
   && apt-get -y install mono-complete

RUN cd ~ \
   && git clone https://github.com/dfki-asr/MOSIM.git

RUN cd ~ \
   && git clone https://github.com/dfki-asr/MOSIM-CSharp
   
RUN cd ~/MOSIM-CSharp \
	&& git submodule update --init --remote --recursive

WORKDIR /root/MOSIM-CSharp/Core/MMICSharp-Core
RUN nuget restore MMICSharp-Core.sln
RUN msbuild /p:Configuration=Release MMICSharp-Core.sln

WORKDIR /root/MOSIM-CSharp/MMUs
RUN nuget restore CS.sln
RUN msbuild /p:Configuration=Debug CS.sln
# RUN /bin/bash -c /root/MOSIM/Docker/Framework/CSharpAdapter/copy.sh

WORKDIR /root/MOSIM-CSharp/Core/Adapter
RUN nuget restore Adapter.sln
RUN msbuild /p:Configuration=Debug Adapter.sln

WORKDIR /root/MOSIM-CSharp/Services/CoordinateSystemMapper
RUN nuget restore CoordinateSystemMapper.sln
RUN msbuild /p:Configuration=Release CoordinateSystemMapper.sln

WORKDIR /root/MOSIM-CSharp/Services/PostureBlendingService
RUN nuget restore PostureBlendingService.sln
RUN msbuild /p:Configuration=Release PostureBlendingService.sln

WORKDIR /root/MOSIM-CSharp/Services/RetargetingService
RUN nuget restore RetargetingService.sln
RUN msbuild /p:Configuration=Release RetargetingService.sln

WORKDIR /root/MOSIM-CSharp/Services/SkeletonAccessService
RUN nuget restore SkeletonAccessService.sln
RUN msbuild /p:Configuration=Release SkeletonAccessService.sln

WORKDIR /root/MOSIM-CSharp/Core/Launcher/MMILauncher.Console
RUN nuget restore MMILauncher.Console.csproj -PackagesDirectory ../packages
RUN msbuild /p:Configuration=Debug MMILauncher.Console.csproj

# ADD . /mnt

WORKDIR /root

# ENTRYPOINT ["/bin/bash" ]

ENTRYPOINT [ "/root/MOSIM/Docker/Framework-V3/CSharp/run.sh" ]

# ENTRYPOINT [ "/mnt/run.sh" ]