# Koristi stariju verziju Alpine slike
FROM alpine:3.15

# Instaliraj potrebne pakete za Icecast
RUN apk update && apk add --no-cache \
    icecast \
    bash \
    curl \
    libxml2 \
    libxslt

# Kreiraj direktorijume za log fajlove i postavi odgovarajuće dozvole
RUN mkdir -p /var/log/icecast2/log \
    && touch /var/log/icecast2/log/access.log /var/log/icecast2/log/error.log \
    && chown -R icecast:icecast /var/log/icecast2

# Kreiraj /etc direktorijum, ako ne postoji, i kopiraj mime.types fajl
RUN mkdir -p /etc
COPY mime.types /etc/mime.types

# Kopiraj tvoj config fajl u odgovarajući direktorijum
COPY icecast.xml /etc/icecast/

# Promeni korisnika na 'icecast' pre nego što pokreneš server
USER icecast

# Izlaganje porta koji Icecast koristi (npr. 8000)
EXPOSE 8000

# Komanda koja pokreće Icecast
CMD ["icecast", "-c", "/etc/icecast/icecast.xml"]
