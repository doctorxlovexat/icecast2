# Koristi zvaničnu Alpine sliku sa najnovijom verzijom Icecast
FROM alpine:latest

# Instaliraj potrebne pakete za Icecast
RUN apk add --no-cache \
    icecast \
    bash \
    curl \
    libxml2 \
    libxslt \
    mime.types

# Kopiraj tvoj config fajl u odgovarajući direktorijum
COPY icecast.xml /etc/icecast/

# Kopiraj MIME types fajl u odgovarajući direktorijum
COPY mime.types /etc/mime.types

# Napraviti direktorijum za logove i web root
RUN mkdir -p /var/log/icecast /var/www/icecast

# Kreiraj korisnika za Icecast i pokreni ga sa njim
RUN adduser -D icecast
USER icecast

# Izlaganje porta koji Icecast koristi (npr. 8080)
EXPOSE 8080

# Komanda koja pokreće Icecast
CMD ["icecast", "-c", "/etc/icecast/icecast.xml"]
