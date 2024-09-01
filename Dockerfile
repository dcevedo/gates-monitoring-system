# Use the original image as the base
FROM nodered/node-red

# Copy package.json to the WORKDIR so npm builds all
# of your added nodes modules for Node-RED

WORKDIR /data
COPY package.json /data
RUN npm install --unsafe-perm --no-update-notifier --no-fund --only=production
WORKDIR /usr/src/node-red

user root
RUN set -ex && \
 deluser node-red && \
 adduser -h /usr/src/node-red -D -H node-red -u 1880 && \
 chown -R node-red:root /data && chmod -R g+rwX /data && \
 chown -R node-red:root /usr/src/node-red && chmod -R g+rwX /usr/src/node-red
#Copy _your_ Node-RED project files into place
# NOTE: This will only work if you DO NOT later mount /data as an external volume.
#       If you need to use an external volume for persistence then
#       copy your settings and flows files to that volume instead.
user node-red
COPY settings_dcevedo.js /data/settings.js
COPY flows_cred.json /data/flows_cred.json
COPY flows.json /data/flows.json
