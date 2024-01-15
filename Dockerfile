FROM ubuntu:latest

ARG java=java

SHELL ["/bin/bash", "-c"]
RUN mkdir /scripts
COPY $java /java
COPY --chmod=555 startup.sh /scripts/startup.sh
COPY --chmod=555 mc-up.sh /scripts/mc-up.sh
RUN apt-get update -y
RUN apt-get install jq curl wget gosu -y

VOLUME ["/data"]
WORKDIR /data

STOPSIGNAL SIGTERM

EXPOSE 25565

# Environment variables for script
ENV JAVA_HOME=/java
ENV SERVER_JAR=server.jar
ENV INSTALL=FALSE
ENV EULA=TRUE

# User and Group setting
ENV UID=1000 GID=1000

CMD [ "/bin/bash", "-c", "/scripts/startup.sh" ]
ENTRYPOINT [ "/bin/bash", "-c", "/scripts/startup.sh" ]

