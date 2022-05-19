FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt -y update && \
    apt install -y --no-install-recommends \
        locales \
        git \
        ansible \
        rsync \
        grep \
        xz-utils \
        curl \
        wget \
        fakeroot \
        gawk \
        unzip \
        tar \
        squashfs-tools \
        sudo \
        bison \
        pseudo \
        cpio \
        file \
        build-essential \
        xxd \
        file \
        socat \
        python2 \
        python2-dev \
        python3 \
        python3-dev \
        python3-pip \
        kmod \
        bc \
        binfmt-support \
        ca-certificates \
        qemu-utils\
        chrpath \
        diffstat \
        liblz4-1 \
        liblz4-tool \
        zstd \
        bmap-tools

RUN apt clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN dpkg-reconfigure locales && \
    locale-gen en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir kas

WORKDIR /yocto
ENV HOME /yocto

ENTRYPOINT [ "/yocto/docker/entrypoint" ]
