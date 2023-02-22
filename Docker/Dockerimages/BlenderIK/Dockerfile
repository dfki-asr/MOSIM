#Maintainer Klaus Fischer <Klaus.Fischer@dfki.de>
FROM ubuntu:bionic

LABEL authors="Isaac (Ike) Arias <ikester@gmail.com>"

RUN apt-get update && \
	apt-get install -y \
		curl \
		libfreetype6 \
		libglu1-mesa \
		libxi6 \
		libxrender1 \
		p7zip-full \
		xz-utils && \
	apt-get -y autoremove && \
	apt-get -y install git && \
	rm -rf /var/lib/apt/lists/*

RUN cd ~ && curl -L https://github.com/git-lfs/git-lfs/releases/download/v2.9.0/git-lfs-linux-amd64-v2.9.0.tar.gz --output lfs.tgz && tar xzf  lfs.tgz && ./install.sh

RUN cd ~ && git lfs install

RUN cd ~ \
    && git clone https://github.com/dfki-asr/MOSIM-Python

# RUN cd ~ \
#    && git clone --branch develop https://github.com/Daimler/MOSIM_Services.git Services
	
WORKDIR /root/MOSIM-Python/Services/BlenderIK

COPY deploy.sh .

RUN ./deploy.sh

EXPOSE 8900

WORKDIR /root/MOSIM-Python/Services/BlenderIK/build

RUN chmod u+x Start_IKService.sh
	
ENTRYPOINT [ "/bin/bash" ,"Start_IKService.sh" ]

# ENTRYPOINT [ "/bin/bash" ]

