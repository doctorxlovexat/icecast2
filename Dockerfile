FROM debian:stable-slim

MAINTAINER Manfred Touron "m@42.am"

# Postavljanje non-interactive mod
ENV DEBIAN_FRONTEND noninteractive

# Instalacija potrebnih paketa
RUN apt-get -qq -y update; \
    apt-get -qq -y full-upgrade; \
    apt-get -qq -y install icecast2 python-setuptools sudo cron-apt; \
    apt-get -y autoclean; \
    apt-get clean; \
    chown -R icecast2 /etc/icecast2; \
    chmod 777 /var/log/icecast2/access.log; \
    chmod 777 /var/log/icecast2/error.log

# Dodajemo start script
ADD ./start.sh /start.sh

# Dodajemo konfiguraciju
ADD ./etc /etc

# Postavljanje environment varijabli prema podacima iz icecast.xml
ENV ICECAST_SOURCE_PASSWORD=zizu
ENV ICECAST_RELAY_PASSWORD=zizu
ENV ICECAST_ADMIN_USER=gladijator
ENV ICECAST_ADMIN_PASSWORD=zizu
ENV ICECAST_HOSTNAME=127.0.0.1
ENV ICECAST_PORT=8000

# Startovanje Icecast-a sa start.sh
CMD ["/start.sh"]

# Otvorimo port za pristup
EXPOSE 8000

# Definisanje volumena
VOLUME ["/config", "/var/log/icecast2", "/etc/icecast2"]
