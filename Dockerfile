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
    rm -rf /usr/src/sdcc

ENV HEX2BIN_VERSION 2.5

RUN mkdir -p /usr/src/hex2bin
WORKDIR /usr/src/hex2bin
RUN curl -L https://netcologne.dl.sourceforge.net/project/hex2bin/hex2bin/Hex2bin-${HEX2BIN_VERSION}.tar.bz2 | \
    tar xvj --strip-components=1 && \
    make clean || true && \
    make && \
    cp hex2bin /usr/bin && \
    rm -rf /usr/src/hex2bin

WORKDIR /usr/src

