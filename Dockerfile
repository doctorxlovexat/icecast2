# Koristi stabilniju verziju Alpine slike
FROM alpine:3.12

# Instaliraj potrebne pakete
RUN apk update && apk add --no-cache \
    icecast \
    bash \
    curl \
    libxml2 \
    libxslt

# Kreiraj direktorijum za logove ako ne postoji
RUN mkdir -p /var/log/icecast2/log \
    && chown -R icecast:icecast /var/log/icecast2/

# Kopiraj log direktorijum (ako je potrebno)
COPY --chown=icecast:icecast ./log /var/log/icecast2/log

# Kopiraj mime.types fajl u /etc/ direktorijum
COPY mime.types /etc/mime.types

# Postavi dozvole za mime.types fajl
RUN chmod 644 /etc/mime.types

# Kopiraj icecast.xml u /etc/icecast/
COPY icecast.xml /etc/icecast/

# Postavi korisnika i radni direktorijum
USER icecast
WORKDIR /var/log/icecast2/log

# Izlaganje portova koji Icecast koristi
EXPOSE 80

# Pokretanje Icecast-a
CMD ["icecast", "-c", "/etc/icecast/icecast.xml"]
