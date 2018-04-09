FROM alpine:3.7

LABEL maintainer "Michal Cichra <michal@cichra.cz>"
ENV LUA_VERSION=5.3
ENV LUACHECK_VERSION=0.21.2

WORKDIR /tmp
COPY Gemfile* /tmp/

USER app
VOLUME /code
WORKDIR /code

COPY engine.json /
COPY bin /usr/local/bin/
COPY lib /usr/local/share/lua/${LUA_VERSION}/

CMD ["engine-luacheck"]
