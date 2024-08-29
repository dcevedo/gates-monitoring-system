# Use the original image as the base
FROM nodered/node-red

# Copy package.json to the WORKDIR so npm builds all
# of your added nodes modules for Node-RED
WORKDIR /data
COPY package.json /data
RUN npm install --unsafe-perm --no-update-notifier --no-fund --only=production
WORKDIR /usr/src/node-red

# Continue with any additional customizations if needed
