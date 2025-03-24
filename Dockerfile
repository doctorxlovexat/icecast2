FROM debian:stable-slim

MAINTAINER Manfred Touron "m@42.am"

ENV DEBIAN_FRONTEND=noninteractive

# Ažuriranje i instalacija paketa
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install icecast2 python3-setuptools sudo && \
    apt-get -y autoclean && \
    apt-get clean && \
    mkdir -p /var/log/icecast2 && \
    chown -R icecast2:icecast2 /var/log/icecast2 && \
    chmod -R 777 /var/log/icecast2

# Kopiraj start.sh skriptu
COPY start.sh /start.sh

# Obezbedi dozvole za start.sh
RUN chmod +x /start.sh

# Postavi komandu za pokretanje
CMD ["/start.sh"]

# Izloži port
EXPOSE 8000

# Postavi volumen
VOLUME ["/config", "/var/log/icecast2", "/etc/icecast2"]
