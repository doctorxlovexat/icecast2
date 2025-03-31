# Koristi stabilniju verziju Debian slike
FROM debian:bullseye

# Instaliraj potrebne pakete

# Kopiraj konfiguracione fajlove pre instalacije
COPY icecast.xml /etc/icecast2/icecast.xml
COPY mime.types /etc/mime.types

# Instalacija paketa
RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
    icecast2 \
    bash \
    curl \
    libxml2 \
    libxslt1.1 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*


# Kreiraj direktorijum za logove ako ne postoji
RUN mkdir -p /var/log/icecast2/log \
    && chown icecast2:icecast /var/log/icecast2/log  # Postavljamo dozvole za Icecast korisnika

# Postavi dozvole za mime.types fajl
RUN chmod 644 /etc/mime.types

# Postavi korisnika i radni direktorijum
USER icecast2
WORKDIR /var/log/icecast2/log

# Izlaganje portova koje Icecast koristi
EXPOSE 8080

# Pokretanje Icecast-a
CMD ["icecast2", "-c", "/etc/icecast2/icecast.xml", "-p", "8080"]
