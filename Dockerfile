FROM ubuntu:latest

# Instalacija potrebnih paketa
RUN echo "Updating apt-get and installing dependencies..." && apt-get update && apt-get install -y icecast2 sudo && rm -rf /var/lib/apt/lists/*
RUN echo "Installation complete!"

# Kreiranje običnog korisnika icecast
RUN echo "Creating user icecast..." && useradd -m icecast && echo "User icecast created!"

# Kreiranje direktorijuma za logove
RUN echo "Creating log directory..." && mkdir -p /var/log/icecast2/log && chown -R icecast:icecast /var/log/icecast2

# Kopiranje konfiguracionog fajla
RUN echo "Copying icecast.xml..." && cp /icecast.xml /etc/icecast2/icecast.xml && echo "icecast.xml copied!"

# Postavljanje korisnika
USER icecast
RUN echo "Switched to icecast user."

# Eksponovanje porta
EXPOSE 8000

# Pokretanje Icecast servera
CMD ["icecast2", "-c", "/etc/icecast2/icecast.xml"]
