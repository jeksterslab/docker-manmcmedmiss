FROM jeksterslab/template:latest@sha256:8ebf7557dcdd190733acc13822eeae1fd70f5ab3b97308e821d53138b4222964

ADD manMCMedMiss_0.9.1.tar.gz /usr/src/local
COPY scripts/setup.sh /usr/src/local/setup.sh
RUN chmod 777 /usr/src/local/setup.sh         && \
    ./usr/src/local/setup.sh                  && \
    rm -rf /usr/src/local/setup.sh

# author
MAINTAINER "Ivan Jacob Agaloos Pesigan <learn.jeksterslab@gmail.com>"

# extra metadata
LABEL version="0.9.1"
LABEL description="manMCMedMiss_0.9.1 archlinux container."
