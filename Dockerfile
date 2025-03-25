FROM debian:stable-slim

MAINTAINER Manfred Touron "m@42.am"

ENV DEBIAN_FRONTEND=noninteractive

# Ažuriranje i instalacija paketa
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install icecast2 python3-setuptools sudo && \
    apt-get -y autoclean && \
    apt-get clean && \
    mkdir -p /var/log/icecast2/log && \
    chown -R icecast2:icecast2 /var/log/icecast2 && \
    chmod -R 777 /var/log/icecast2

# Kreiranje korisnika i grupe icecast2
RUN addgroup --system icecast2 && adduser --system --no-create-home --ingroup icecast2 icecast2

# Kopiraj icecast.xml iz korenskog direktorijuma u /etc/icecast2
COPY ./icecast.xml /etc/icecast2/icecast.xml

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
