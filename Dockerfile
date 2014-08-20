FROM debian:wheezy

MAINTAINER Bruno Binet <bruno.binet@helioslite.com>

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends openssh-server rsync perl

RUN adduser --system --no-create-home rrsync

ADD sshd_config /config/sshd_config
RUN chmod 700 /config
ADD rrsync /rrsync
RUN chmod +x /rrsync

VOLUME ["/data"]

RUN mkdir /var/run/sshd

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
