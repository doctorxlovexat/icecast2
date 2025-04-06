#!/bin/bash

# Pokreni Docker container sa Icecast serverom
docker build -t icecast-server .
docker run -d -p 8080:8080 --name icecast-container icecast-server
