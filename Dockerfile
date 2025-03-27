# Koristi zvaničnu Alpine sliku sa najnovijom verzijom Icecast
FROM alpine:latest

# Instaliraj potrebne pakete za Icecast
RUN apk update && apk add --no-cache \
    icecast \
    bash \
    curl \
    libxml2 \
    libxslt

# Kreiraj direktorijume za logove, admin i web fajlove
RUN mkdir -p /var/log/icecast /var/www/icecast /var/icecast/admin \
    && chown -R icecast:icecast /var/log/icecast /var/www/icecast /var/icecast/admin

# Kopiraj tvoj config fajl u odgovarajući direktorijum
COPY icecast.xml /etc/icecast/

# Promeni korisnika na 'icecast' pre nego što pokreneš server
USER icecast

# Izlaganje porta koji Icecast koristi (npr. 8000)
EXPOSE 8000

# Komanda koja pokreće Icecast
CMD ["icecast", "-c", "/etc/icecast/icecast.xml"]
