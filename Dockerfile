FROM node:latest
WORKDIR /opt/game
COPY package*.json ./
RUN npm install -g
RUN npm install -g grunt-cli
RUN npm install -g liftup
COPY . .
EXPOSE 1050
CMD ["grunt", "connect"]