FROM node:8-alpine as builder
COPY package.json ./

FROM nginx:alpine
COPY --from=builder ./package.json /usr/share
