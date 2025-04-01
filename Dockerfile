# Koristi stariju verziju Alpine slike
FROM alpine:3.15

# Instaliraj potrebne pakete
RUN apk update && apk add --no-cache \
    icecast \
    bash \
    curl \
    libxml2 \
    libxslt

# Kreiraj log direktorijume u korenskom direktorijumu
RUN mkdir -p /logs && \
    chmod -R 777 /logs

# Kopiraj mime.types fajl u /etc/ direktorijum
COPY mime.types /etc/mime.types

# Postavi dozvole za mime.types fajl
RUN chmod 644 /etc/mime.types

# Kopiraj icecast.xml u /etc/icecast/
COPY icecast.xml /etc/icecast/

# Promeni korisnika na 'icecast' pre nego što pokrećeš server
USER icecast

# Izlaganje porta koji Icecast koristi
EXPOSE 8080

# Komanda koja pokreće Icecast
CMD ["icecast", "-c", "/etc/icecast/icecast.xml"]
