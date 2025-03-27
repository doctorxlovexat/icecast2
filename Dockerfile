FROM ubuntu:20.04

# Instaliraj Icecast
RUN apt-get update && apt-get install -y icecast2

# Kopiraj konfiguraciju
COPY ./icecast.xml /etc/icecast2/icecast.xml

# Expose port
EXPOSE 8000

# Pokreni Icecast
CMD ["icecast", "-c", "/etc/icecast2/icecast.xml"]
