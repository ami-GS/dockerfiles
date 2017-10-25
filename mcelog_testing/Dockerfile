FROM ubuntu:latest
MAINTAINER Daiki Aminaka <1991.daiki@gmail.com>

ENV CONFIG_X86_MCE_INJECT y
ENV CONFIG_HWPOISON_INJECT y
RUN apt-get update && apt-get install -y \
    build-essential \
    bison \
    flex \
    git \
    pkg-config \
    apt-utils \
    mcelog \
    modprobe \
    && rm -rf /var/lib/apt/lists/* \
    && git clone https://git.kernel.org/pub/scm/utils/cpu/mce/mce-inject.git /root/mce-inject \
    && cd /root/mce-inject && make install \
    && git clone https://git.kernel.org/pub/scm/utils/cpu/mce/mce-test.git /root/mce-test \
    && cd /root/mce-test

WORKDIR /root
