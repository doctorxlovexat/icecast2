# Koristi zvaničnu Alpine sliku sa najnovijom verzijom Icecast
FROM alpine:latest

# Instaliraj potrebne pakete za Icecast
RUN apk add --no-cache \
    icecast \
    bash \
    curl \
    libxml2 \
    libxslt

# Kopiraj tvoj config fajl u odgovarajući direktorijum
COPY icecast.xml /etc/icecast/

# Napraviti direktorijum za logove i web root
RUN mkdir -p /var/log/icecast /var/www/icecast

RUN adduser -D icecast
RUN chown -R icecast:icecast /etc/icecast /var/log/icecast
USER icecast


# Kopiraj mime.types fajl u /etc/ direktorijum
COPY mime.types /etc/mime.types


# Izlaganje porta koji Icecast koristi (npr. 8000)
EXPOSE 8080

# Komanda koja pokreće Icecast
CMD ["icecast", "-c", "/etc/icecast/icecast.xml"]
