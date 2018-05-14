FROM node:8-alpine
COPY package.json ./

FROM nginx:alpine
COPY --from=0 ./package.json /usr/share
