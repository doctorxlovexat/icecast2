# Koristi stariju verziju Alpine slike
FROM alpine:3.15

# Instaliraj potrebne pakete
RUN apk update && apk add --no-cache \
    icecast \
    bash \
    curl \
    libxml2 \
    libxslt

# Kopiraj log direktorijum (ako je potrebno)
COPY ./log /var/log/icecast2/log

# Kreiraj direktorijume za log fajlove (ako nisu već kreirani)
RUN mkdir -p /var/log/icecast2/log \
    && chown -R icecast:icecast /var/log/icecast2/log

# Kopiraj mime.types fajl u /etc/ direktorijum
COPY mime.types /etc/mime.types

# Postavi dozvole za mime.types fajl
RUN chmod 644 /etc/mime.types

# Kopiraj icecast.xml u /etc/icecast/
COPY icecast.xml /etc/icecast/

# Promeni korisnika na 'icecast' pre nego što pokreneš server
USER icecast

# Izlaganje portova koji Icecast koristi (koristi port 8080)
EXPOSE $PORT


# Komanda koja pokreće Icecast, koristi PORT iz Render varijable
CMD ["icecast", "-c", "/etc/icecast/icecast.xml", "-p", "$PORT"]
