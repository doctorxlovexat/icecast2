# Korišćenje zvanične Icecast slike
FROM icecast/icecast-docker:latest

# Kopiraj tvoj icecast.xml u kontejner
COPY ./icecast.xml /etc/icecast2/icecast.xml

# Kopiraj log direktorijum (ako želiš)
COPY ./log /var/log/icecast2

# Postavi radnu putanju (ako je potrebno)
WORKDIR /etc/icecast2

# Pokreni Icecast
CMD ["icecast2", "-c", "/etc/icecast2/icecast.xml"]
