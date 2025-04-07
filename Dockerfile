# Koristi zvaničnu Node.js sliku
FROM node:latest

# Instaliraj zavisnosti za Icecast
RUN apt-get update && apt-get install -y \
    icecast2 \
    && rm -rf /var/lib/apt/lists/*

# Kopiraj konfiguraciju Icecast servera
COPY icecast.xml /etc/icecast/

# Postavi port na 8080
EXPOSE 8080

# Pokreni Icecast server
CMD ["icecast2", "-c", "/etc/icecast/icecast.xml"]
