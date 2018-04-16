FROM debian:jessie
MAINTAINER Carles Amigó, fr3nd@fr3nd.net

ENV SDCC_VERSION 3.7.0

RUN apt-get update && apt-get install -y \
      bison \
      build-essential \
      curl \
      flex \
      gputils \
      libboost-dev \
      texinfo \
      && rm -rf /usr/share/doc/* && \
      rm -rf /usr/share/info/* && \
      rm -rf /tmp/* && \
      rm -rf /var/tmp/*

RUN mkdir -p /usr/src/sdcc
WORKDIR /usr/src/sdcc
RUN curl -L https://kent.dl.sourceforge.net/project/sdcc/sdcc/${SDCC_VERSION}/sdcc-src-${SDCC_VERSION}.tar.bz2 | \
    tar xvj --strip-components=1 && \
    ./configure --prefix=/usr && \
    make && \
    make install && \
    rm -rf /usr/src/deluge
WORKDIR /usr/src

