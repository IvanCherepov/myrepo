FROM node:8-alpine as builder
COPY package.json ./

RUN npm set progress=false && npm config set depth 0 && npm cache clean --force

WORKDIR /ng-app

COPY . .

RUN npm run build -- --env=containerized --aot

FROM nginx:alpine
WORKDIR /etc/nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
COPY --from=builder ./package.json /usr/share
