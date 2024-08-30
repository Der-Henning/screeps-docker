FROM node:12-buster-slim

RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
    netcat \
    python2.7 \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python2.7 /usr/bin/python

COPY scripts/installMods.sh installMods.sh
COPY scripts/resetData.sh resetData.sh

USER node

WORKDIR /world

RUN npm install screeps 
RUN npm install screepsmod-mongo screepsmod-auth screepsmod-admin-utils screepsmod-map-tool

COPY config/mods.json mods.json-temp
COPY config/.screepsrc .screepsrc-temp
COPY config/config.yml config.yml

COPY scripts/startup.sh startup.sh

CMD ["bash", "/world/startup.sh"]
