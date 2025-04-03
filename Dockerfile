# Koristi stariju verziju Alpine slike
FROM alpine:3.15

# Instaliraj potrebne pakete
RUN apk update && apk add --no-cache \
    icecast \
    bash \
    curl \
    libxml2 \
    libxslt

# Kreiraj direktorijum za logove
RUN mkdir -p /var/log/icecast && chown icecast:icecast /var/log/icecast

# Kopiraj mime.types fajl u /etc/ direktorijum
COPY mime.types /etc/mime.types

# Postavi dozvole za mime.types fajl
RUN chmod 644 /etc/mime.types

# Kopiraj icecast.xml u /etc/icecast/
COPY icecast.xml /etc/icecast/

# Postavi radni direktorijum
WORKDIR /etc/icecast

# Izlaganje porta koji Icecast koristi
EXPOSE 8080

RUN adduser -D -H icecast && chown -R icecast:icecast /etc/icecast /var/log/icecast
USER icecast


# Komanda koja pokreće Icecast
CMD ["icecast", "-c", "/etc/icecast/icecast.xml"]
