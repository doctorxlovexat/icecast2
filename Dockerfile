FROM debian:stable-slim

MAINTAINER Manfred Touron "m@42.am"

ENV DEBIAN_FRONTEND noninteractive

# Update i instalacija potrebnih paketa
RUN apt-get -qq -y update && \
    apt-get -qq -y full-upgrade && \
    apt-get -qq -y install icecast2 python-setuptools sudo cron-apt && \
    apt-get -y autoclean && \
    apt-get clean && \
    mkdir -p /var/log/icecast2 && \
    chown -R icecast2:icecast2 /var/log/icecast2 && \
    chmod -R 777 /var/log/icecast2 && \
    chmod 777 /var/log/icecast2/access.log && \
    chmod 777 /var/log/icecast2/error.log

# Kopiraj start.sh
ADD ./start.sh /start.sh

# Obezbedi dozvole za start.sh
RUN chmod +x /start.sh

# Postavi komandu za pokretanje
CMD ["/start.sh"]

# Izloži port
EXPOSE 8000

# Postavi volumen
VOLUME ["/config", "/var/log/icecast2", "/etc/icecast2"]
