# Koristi zvaničnu Alpine sliku sa najnovijom verzijom Icecast
FROM alpine:latest

# Instaliraj potrebne pakete za Icecast
RUN apk add --no-cache \
    icecast \
    bash \
    curl \
    libxml2 \
    libxslt \
    mime-types

# Kopiraj tvoj config fajl u odgovarajući direktorijum
COPY icecast.xml /etc/icecast/

# Kopiraj mime types fajl u odgovarajući direktorijum
COPY mime.types /etc/

# Napraviti direktorijum za logove i web root
RUN mkdir -p /var/log/icecast /var/www/icecast

# Kreiraj korisnika i grupu za Icecast, da ga ne pokrećeš kao root
RUN addgroup -S icecast && adduser -S icecast -G icecast

# Promeni vlasništvo nad direktorijumima da ih koristi Icecast korisnik
RUN chown -R icecast:icecast /etc/icecast /var/log/icecast /var/www/icecast

# Prebaci se na korisnika icecast
USER icecast

# Expose port za Icecast server
EXPOSE 8000

# Komanda koja pokreće Icecast
CMD ["icecast", "-c", "/etc/icecast/icecast.xml"]
