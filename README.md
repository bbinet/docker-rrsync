docker-rrsync
=============

Rrsync (restricted rsync) docker container.


Build
-----

To create the image `bbinet/rrsync`, execute the following command in the
`docker-rrsync` folder:

    docker build -t bbinet/rrsync .

You can now push the new image to the public registry:
    
    docker push bbinet/rrsync

Run
---

Then, when starting your rrsync container, you will want to bind ports `22`
from the rrsync container to a host external port.

The rrsync container will write uploaded data to the `/data` directory, so you
may want to bind this directory to a host directory or a data container, which
should be writable for user uid 500.

You also need to provide a read-only `authorized_keys` file that will be use to
allow some users to rsync data based on their public ssh key.

You can also provide a read-only `rrsync.sh` wrapper script that will be used
to validate `SSH_ORIGINAL_COMMAND` before passing it to rrsync (for additional
security).

For example:

    $ docker pull bbinet/rrsync

    $ docker run --name rrsync \
        -v authorized_keys:/config/authorized_keys:ro \
        -v rrsync.sh:/rrsync.sh:ro \
        -v /home/rrsync/data:/data \
        -p 22:22 \
        bbinet/rrsync
