FROM ubuntu:latest

# Instalacija potrebnih paketa
RUN apt-get update && apt-get install -y icecast2 sudo && rm -rf /var/lib/apt/lists/*

# Kreiranje korisnika za Icecast
RUN useradd -m -d /home/icecast icecast

# Kreiranje direktorijuma za logove
RUN mkdir -p /var/log/icecast2/log && chown -R icecast:icecast /var/log/icecast2

# Kopiranje konfiguracionog fajla
COPY icecast.xml /etc/icecast2/icecast.xml

# Postavljanje korisnika
USER icecast

# Eksponovanje porta
EXPOSE 8000

# Pokretanje Icecast servera
CMD ["icecast2", "-c", "/etc/icecast2/icecast.xml"]
