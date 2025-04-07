# Koristi zvaničnu Node.js sliku
FROM node:latest

# Instaliraj zavisnosti za Icecast
RUN apt-get update && apt-get install -y \
    icecast2 \
    && rm -rf /var/lib/apt/lists/*

# Kreiraj korisnika
RUN adduser --disabled-password --gecos '' icecastuser

# Kopiraj konfiguraciju i log folder
COPY icecast.xml /etc/icecast/
COPY log /usr/local/icecast/logs

# Postavi dozvole
RUN chown icecastuser:icecastuser /etc/icecast/icecast.xml && \
    chown -R icecastuser:icecastuser /usr/local/icecast/logs

# Kopiraj status.xsl iz foldera web u direktorijum gde Icecast očekuje fajl
COPY web/status.xsl /usr/local/icecast/web/status.xsl


# Izloži port
EXPOSE 8080

# Pokreni kao običan korisnik
USER icecastuser
CMD ["icecast2", "-c", "/etc/icecast/icecast.xml"]
