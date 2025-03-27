FROM ubuntu:latest

# Instalacija potrebnih paketa
RUN apt-get update && apt-get install -y icecast2 && rm -rf /var/lib/apt/lists/*

# Kreiranje direktorijuma za logove
RUN mkdir -p /var/log/icecast2/log

# Kopiranje konfiguracionog fajla
COPY icecast.xml /etc/icecast2/icecast.xml

# Eksponovanje porta
EXPOSE 8000

# Pokretanje Icecast servera
CMD ["icecast2", "-c", "/etc/icecast2/icecast.xml"]
