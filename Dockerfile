FROM debian:wheezy

MAINTAINER Bruno Binet <bruno.binet@helioslite.com>

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends openssh-server rsync perl

RUN adduser --system --home /data --no-create-home rrsync --uid 500

RUN mkdir /var/run/sshd
ADD sshd_config /config/sshd_config
ADD rrsync /rrsync
RUN chmod +x /rrsync

VOLUME ["/data"]


EXPOSE 22

CMD ["/usr/sbin/sshd", "-f", "/config/sshd_config", "-D"]
