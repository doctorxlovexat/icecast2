# Koristi Debian sliku
FROM debian:bullseye-slim

# Instaliraj potrebne pakete
RUN apt-get update && apt-get install -y \
    icecast2 \
    curl \
    libxml2 \
    libxslt \
    bash \
    && rm -rf /var/lib/apt/lists/*

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
EXPOSE 8080

# Komanda koja pokreće Icecast
CMD ["icecast2", "-c", "/etc/icecast/icecast.xml"]
