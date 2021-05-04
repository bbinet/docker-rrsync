FROM debian:buster

MAINTAINER Bruno Binet <bruno.binet@helioslite.com>

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends openssh-server rsync perl dumb-init

RUN adduser --system --shell /bin/sh rrsync --uid 1000

ADD docker /rrsync
RUN chmod +x /rrsync/rrsync /rrsync/rrsync.sh
RUN mkdir /var/run/sshd
RUN mkdir -p /data/trlogs /data/tmpdata /data/fitterms

EXPOSE 22

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

ENV HOST_KEY /etc/ssh/ssh_host_rsa_key
ENV AUTHORIZED_KEYS_FILE /etc/ssh/authorized_keys

CMD ["bash", "-c", "mkdir -p /home/rrsync/.ssh && cp -a $AUTHORIZED_KEYS_FILE /home/rrsync/.ssh/authorized_keys && chmod -R go-rwx /home/rrsync && chown -R rrsync:root /data /home/rrsync && /usr/sbin/sshd -f /rrsync/sshd_config -h $HOST_KEY -o AuthorizedKeysFile=/home/rrsync/.ssh/authorized_keys -D"]
