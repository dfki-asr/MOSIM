FROM unityci/base:latest

WORKDIR /root
ADD . /root

EXPOSE 8900

RUN cd ~ \
   && git clone https://github.com/dfki-asr/MOSIM.git

ENTRYPOINT [ "/bin/bash" , "/root/MOSIM/Docker/Framework-V3/Unity/run.sh" ]

# ENTRYPOINT [ "/bin/bash" ]

# RUN chmod +x /root/run.sh
# ENTRYPOINT [ "/root/run.sh" ]
