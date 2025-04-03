# Koristi stabilniju verziju Debian slike
FROM debian:bullseye

# Instaliraj potrebne pakete
RUN apt-get update && apt-get install -y \
    icecast2 \
    bash \
    curl \
    libxml2 \
    libxslt1.1 \
    && rm -rf /var/lib/apt/lists/*  # Čisti cache nakon instalacije

# Kopiraj icecast.xml u /etc/icecast/
COPY icecast.xml /etc/icecast2/icecast.xml

# Kopiraj mime.types fajl u /etc/ direktorijum
COPY mime.types /etc/mime.types

# Postavi dozvole za mime.types fajl
RUN chmod 644 /etc/mime.types

# Postavi korisnika
USER icecast2

# Izlaganje portova koje Icecast koristi
EXPOSE 8080

# Pokretanje Icecast-a
CMD ["icecast2", "-c", "/etc/icecast2/icecast.xml", "-p", "8080"]
