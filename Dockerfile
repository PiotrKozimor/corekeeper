FROM cm2network/steamcmd:root

RUN apt-get update -yy && apt-get install -yy  xvfb

USER steam
RUN /home/steam/steamcmd/steamcmd.sh +login anonymous +app_update 1963720 +quit
RUN mv /home/steam/Steam/steamapps/common/Core\ Keeper\ Dedicated\ Server/ /home/steam/Steam/steamapps/common/corekeeper
WORKDIR /home/steam/Steam/steamapps/common/corekeeper
VOLUME /var/corekeeper
COPY start.sh .


