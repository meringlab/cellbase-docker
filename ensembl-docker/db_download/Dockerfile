FROM ubuntu:xenial
MAINTAINER Milan Simonovic <mbsimonovic@gmail.com>

RUN apt-get update \
 && apt-get install -y mysql-client rsync

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

ENTRYPOINT ["/sbin/entrypoint.sh"]
