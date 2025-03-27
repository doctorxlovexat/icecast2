FROM debian:latest

# Instaliraj potrebne pakete
RUN apt-get update && apt-get install -y \
    icecast2 \
    && apt-get clean

# Dodaj korisnika, proveri da li već postoji pre nego što ga kreiramo
RUN id -u icecast &>/dev/null || useradd -m icecast

# Kreiraj direktorijume za logove, ako već ne postoje
RUN mkdir -p /var/log/icecast2 /var/www/html

# Dodaj odgovarajuće permisije
RUN chown -R icecast:icecast /var/log/icecast2 /var/www/html

# Kopiraj Icecast konfiguraciju u odgovarajući direktorijum
COPY ./icecast.xml /etc/icecast2/icecast.xml

# Postavi korisnika pod kojim će Icecast raditi
USER icecast

# Pokreni Icecast server
CMD ["icecast2", "-c", "/etc/icecast2/icecast.xml"]
