FROM debian:stretch

MAINTAINER Bruno Binet <bruno.binet@helioslite.com>

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends openssh-server rsync perl dumb-init

RUN adduser --system --shell /bin/sh rrsync --uid 1000

ADD docker /rrsync
RUN chmod +x /rrsync/rrsync /rrsync/rrsync.sh
RUN mkdir /var/run/sshd /data
RUN chown rrsync: /data

EXPOSE 22

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

ENV HOST_KEY /etc/ssh/ssh_host_rsa_key
ENV AUTHORIZED_KEYS_FILE /etc/ssh/authorized_keys

CMD ["bash", "-c", "/usr/sbin/sshd -f /rrsync/sshd_config -h $HOST_KEY -o AuthorizedKeysFile=$AUTHORIZED_KEYS_FILE -D"]
