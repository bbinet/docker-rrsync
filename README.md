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

Then when starting your rrsync container, you will want to bind ports `22`
from the rrsync container to a host external port.
The rrsync container will write uploaded data to a volume in `/data`, so you
may want to bind this data volume to a host directory or a data container.

For example:

    $ docker pull bbinet/rrsync

    $ docker run --name rrsync -v /home/rrsync/data:/data -p 22:22 bbinet/rrsync