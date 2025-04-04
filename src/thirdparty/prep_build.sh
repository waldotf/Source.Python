#!/bin/bash

# Enable globbing for collecting libs/includes
shopt -s globstar

#Setup build container
#Python build process insists on using build-dep...
sed -i 's/^Types: deb$/Types: deb deb-src/' /etc/apt/sources.list.d/debian.sources
apt update
# Python deps
apt build-dep -y python3
apt install -y git \
               pkg-config \
               build-essential \
               gdb \
               lcov \
               pkg-config \
               libbz2-dev \
               libffi-dev \
               libgdbm-dev \
               libgdbm-compat-dev \
               liblzma-dev \
               libncurses5-dev \
               libreadline6-dev \
               libsqlite3-dev \
               libssl-dev \
               lzma \
               lzma-dev \
               tk-dev \
               uuid-dev \
               zlib1g-dev \
               wget \
               cmake \
               vim

cd /src/src/thirdparty
