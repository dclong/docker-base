# NAME: dclong/ubuntu_b
FROM debian:testing

WORKDIR /root
RUN mkdir -p /workdir && chmod 777 /workdir
COPY scripts /scripts

RUN apt-get update -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        sudo \
        software-properties-common apt-transport-https \
        file zip \
        tzdata locales \
        bash-completion man-db \
        neovim git openssh-client \
        rsync curl \
    && echo "Set disable_coredump false" >> /etc/sudo.conf \
    && /scripts/sys/purge_cache.sh

# timezone
ARG TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

# locale
COPY settings/locale.gen /etc/locale.gen
RUN locale-gen
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8



