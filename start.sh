#!/bin/bash

# Pokreće Icecast unutar Docker kontejnera
docker build -t my-icecast .  # Izgradi Docker image (ako je potrebno)
docker run -d -p 10000:10000 --name icecast my-icecast  # Pokreće kontejner u pozadini, izlažući port 10000
