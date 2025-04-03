# Preuzmi sliku iz zajednice (npr. oznu/icecast)
FROM oznu/icecast:latest

# Kopiraj icecast.xml
COPY icecast.xml /etc/icecast/icecast.xml

# Kopiraj mime.types
COPY mime.types /etc/mime.types

# Postavi dozvole
RUN chmod 644 /etc/mime.types

# Izlaganje porta
EXPOSE 8080

# Pokretanje Icecast
CMD ["icecast", "-c", "/etc/icecast/icecast.xml"]
