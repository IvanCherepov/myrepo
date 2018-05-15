# STAGE 1

# We label our stage as 'builder'

FROM node:8-alpine

COPY package.json ./

RUN npm set progress=false && npm config set depth 0 && npm cache clean --force

## Storing node modules on a separate layer will prevent unnecessary npm installs at each build

RUN npm i && mkdir /ng-app && cp -R ./node_modules ./ng-app

WORKDIR /ng-app

COPY . .

## Build the angular app in production mode and store the artifacts in dist folder

# RUN npm run build --

# STAGE 2

FROM nginx:alpine

RUN apk update && apk add bash

# Define working directory.

WORKDIR /etc/nginx

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

COPY --from=0 /ng-app/dist /usr/share/nginx/html

# Replace env vars. Be sure to set the $ENV variable.

ADD replace-envs.sh /replace-envs.sh

RUN chmod +x /replace-envs.sh

# Define default command.

CMD /bin/bash /replace-envs.sh && nginx

# Expose ports.

EXPOSE 80
