FROM python:2.7.13

ENV LANG="en_US.UTF-8" PYTHONPATH="." TERM="xterm"

# Main deps
RUN apt-get update -y && DEBIAN_FRONTEND=noninteractive apt-get install -y \
libmemcached-dev \
libffi-dev \
libffi6 \
libxml2 \
libxml2-dev \
libjpeg-dev \
libmagic1 \
postgresql-client \
locales \
&& sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
echo 'LANG="en_US.UTF-8"'>/etc/default/locale && \
dpkg-reconfigure --frontend=noninteractive locales && \
update-locale LANG=en_US.UTF-8 \
&& mkdir -p /usr/src/app

# App deps
COPY requirements.txt /usr/src/app/
RUN pip install -U -r /usr/src/app/requirements.txt
WORKDIR /usr/src/app

# Copy the rest of the app
COPY . /usr/src/app
RUN bash -l -c 'echo export GIT_RELEASE="$(git rev-parse HEAD)" >> /etc/bash.bashrc'
