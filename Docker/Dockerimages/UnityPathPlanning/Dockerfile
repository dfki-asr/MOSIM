FROM unityci/base:latest

WORKDIR /root
ADD . .

# EXPOSE 8900
RUN chmod +x UnityPathPlanningService

ENTRYPOINT ["/bin/bash", "run.sh"]

# ENTRYPOINT [ "/bin/bash" ]

