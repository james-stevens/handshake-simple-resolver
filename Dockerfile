# (c) Copyright 2019-2025, James Stevens ... see LICENSE for details
# Alternative license arrangements are possible, contact me for more information

FROM alpine:3.22
RUN apk update
RUN apk upgrade

RUN rm -rf /run /tmp
RUN ln -s /dev/shm /run
RUN ln -s /dev/shm /tmp

RUN apk add bind

RUN rm -f /etc/bind/rndc.key
RUN ln -s /run/rndc.conf /etc/bind/rndc.conf

COPY inittab /etc/inittab
COPY cron.root /etc/crontabs/root
COPY etc /usr/local/etc
COPY bin /usr/local/bin

COPY build.txt /usr/local/etc/build.txt
CMD [ "/usr/local/bin/run_init" ]
