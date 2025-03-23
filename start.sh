#!/bin/sh

# Ispisuje sve environment varijable (korisno za debugging)
env

# Postavljanje shell opcija
set -x

# Funkcija za postavljanje vrednosti u icecast.xml
set_val() {
    if [ -n "$2" ]; then
        echo "set '$2' to '$1'"
        sed -i "s|<$2>[^<]*</$2>|<$2>$1</$2>|g" /etc/icecast2/icecast.xml
    else
        echo "Setting for '$1' is missing, skipping." >&2
    fi
}

# Postavljanje vrednosti za parametre u icecast.xml
set_val $ICECAST_SOURCE_PASSWORD source-password
set_val $ICECAST_RELAY_PASSWORD relay-password
set_val $ICECAST_ADMIN_PASSWORD admin-password
set_val $ICECAST_PASSWORD password
set_val $ICECAST_HOSTNAME hostname

# Ako sve bude u redu, pokrećemo Icecast server
set -e
sudo -Eu icecast2 icecast2 -n -c /etc/icecast2/icecast.xml
