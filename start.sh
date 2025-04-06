#!/bin/bash

# Instaliraj Icecast
apt-get update
apt-get install -y icecast2

# Kopiraj tvoj XML konfiguracioni fajl
cp icecast.xml /etc/icecast2/icecast.xml

# Pokreni Icecast server
icecast -c /etc/icecast2/icecast.xml
