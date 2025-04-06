# Koristi zvaničnu Icecast sliku
FROM ghcr.io/azuracast/icecast:latest

# Kopiraj tvoj XML konfiguracioni fajl u kontejner
COPY icecast.xml /etc/icecast2/icecast.xml

# Expose port
EXPOSE 8080

# Start Icecast server
CMD ["icecast", "-c", "/etc/icecast2/icecast.xml"]
