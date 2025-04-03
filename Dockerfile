# Koristi zvaničnu Icecast sliku
FROM icecast/icecast:2.4.4

# Kopiraj svoj icecast.xml i mime.types
COPY icecast.xml /etc/icecast2/icecast.xml
COPY mime.types /etc/mime.types

# Postavi dozvole za mime.types fajl
RUN chmod 644 /etc/mime.types

# Izloženi port
EXPOSE 8080

# Pokretanje Icecast-a
CMD ["icecast2", "-c", "/etc/icecast2/icecast.xml"]
