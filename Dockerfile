# Koristi stariju verziju Alpine slike
FROM alpine:3.15

# Instaliraj potrebne pakete
RUN apk update && apk add --no-cache \
    icecast \
    bash \
    curl \
    libxml2 \
    libxslt

RUN mkdir -p /var/log/icecast2/log && \
    chmod -R 777 /var/log/icecast2


# Kopiraj mime.types fajl u /etc/ direktorijum
COPY mime.types /etc/mime.types

# Postavi dozvole za mime.types fajl
RUN chmod 644 /etc/mime.types

# Kopiraj icecast.xml u /etc/icecast/
COPY icecast.xml /etc/icecast/

# Promeni korisnika na 'icecast' pre nego što pokreneš server
USER icecast

# Izlaganje porta koji Icecast koristi
EXPOSE 8080

# Komanda koja pokreće Icecast
CMD ["icecast", "-c", "/etc/icecast/icecast.xml"]
