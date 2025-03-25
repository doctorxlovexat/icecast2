#!/bin/sh

# Postavljanje vrednosti u icecast.xml
set_val() {
    if [ -n "$2" ]; then
        echo "set '$2' to '$1'"
        sed -i "s|<$2>[^<]*</$2>|<$2>$1</$2>|g" /etc/icecast2/icecast.xml
    else
        echo "Setting for '$1' is missing, skipping." >&2
    fi
}

# Direktno postavljanje vrednosti prema XML-u
set_val "zizu" source-password
set_val "zizu" relay-password
set_val "gladijator" admin-user
set_val "zizu" admin-password
set_val "https://icecast2-dw8i.onrender.com" hostname
set_val "100" clients
set_val "2" sources
set_val "524288" queue-size
set_val "30" client-timeout
set_val "15" header-timeout
set_val "10" source-timeout
set_val "1" burst-on-connect
set_val "65535" burst-size
set_val "8000" port
set_val "access.log" accesslog
set_val "error.log" errorlog
set_val "3" loglevel
set_val "10000" logsize
set_val "/var/log" logdir  # Ispravka putanje za logove
set_val "/usr/share/nginx/html" webroot  # Ispravka putanje za statičke fajlove
set_val "/var/www/icecast2/admin" adminroot  # Ispravka putanje za admin panel

# Pokretanje Icecast servera
set -e
# Ako pokrećeš kao root u Dockeru, možeš da ukloniš sudo
exec icecast2 -n -c /etc/icecast2/icecast.xml
