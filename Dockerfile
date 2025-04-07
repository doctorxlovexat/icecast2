# Koristi zvaničnu Node.js sliku
FROM node:latest

# Postavljanje radnog direktorijuma u kontejneru
WORKDIR /app

# Kopiranje konfiguracije i potrebnih fajlova u kontejner
COPY icecast.xml /etc/icecast/
COPY mime.types /etc/

# Instalacija potrebnih paketa za Icecast (ako je potrebno)
RUN apt-get update && apt-get install -y \
    icecast \
    && rm -rf /var/lib/apt/lists/*

# Postavljanje porta na 8080 u Dockerfile-u
EXPOSE 8080

# Pokretanje Icecast servera na portu 8080
CMD ["icecast", "-c", "/etc/icecast/icecast.xml"]
