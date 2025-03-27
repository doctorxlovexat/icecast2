FROM debian:latest

# Instaliraj potrebne pakete
RUN apt-get update && apt-get install -y \
    icecast2 \
    && apt-get clean

# Dodaj korisnika, proveri da li već postoji pre nego što ga kreiramo
RUN id -u icecast &>/dev/null || useradd -m icecast

# Kreiraj direktorijume za logove, web fajlove i admin fajlove
RUN mkdir -p /var/log/icecast2 /var/www/html /log /web /etc/icecast2/admin /etc/icecast2/web

# Dodaj odgovarajuće permisije
RUN chown -R icecast:icecast /var/log/icecast2 /var/www/html /log /web /etc/icecast2/admin /etc/icecast2/web

# Kopiraj Icecast konfiguraciju u odgovarajući direktorijum
COPY ./icecast.xml /etc/icecast2/icecast.xml

# Kopiraj admin fajlove u /etc/icecast2/admin
COPY ./etc/icecast2/admin /etc/icecast2/admin

# Kopiraj web fajlove u /etc/icecast2/web
COPY ./web /etc/icecast2/web

# Postavi korisnika pod kojim će Icecast raditi
USER icecast

# Pokreni Icecast server
CMD ["icecast2", "-c", "/etc/icecast2/icecast.xml"]
