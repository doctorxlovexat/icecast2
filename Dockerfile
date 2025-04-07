# Koristi zvaničnu Node.js sliku
FROM node:latest

# Instaliraj zavisnosti za Icecast
RUN apt-get update && apt-get install -y \
    icecast2 \
    && rm -rf /var/lib/apt/lists/*

# Kopiraj konfiguraciju Icecast servera
COPY icecast.xml /etc/icecast/

RUN adduser --disabled-password --gecos '' icecastuser && \
    chown icecastuser:icecastuser /etc/icecast/icecast.xml

    COPY log /usr/local/icecast/logs
RUN chown -R icecastuser:icecastuser /usr/local/icecast/logs



# Postavi port na 8080
EXPOSE 8080

USER icecastuser
CMD ["icecast2", "-c", "/etc/icecast/icecast.xml"]
