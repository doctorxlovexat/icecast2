FROM alpine:3.21 as builder

ARG ICECAST_VERSION="2.4.4" \
    SHA256="49b5979f9f614140b6a38046154203ee28218d8fc549888596a683ad604e4d44"

RUN apk update && \
    apk upgrade && \
    apk add --upgrade --no-cache --virtual=build-dependencies \
        build-base \
        coreutils \
        curl-dev \
        libxslt-dev \
        libxml2-dev \
        libogg-dev \
        libvorbis-dev \
        libtheora-dev \
        speex-dev \
        openssl-dev

WORKDIR /build

RUN wget https://downloads.xiph.org/releases/icecast/icecast-$ICECAST_VERSION.tar.gz -O /build/icecast-$ICECAST_VERSION.tar.gz && \
    echo "$SHA256 /build/icecast-$ICECAST_VERSION.tar.gz" | sha256sum -c - && \
    tar -xvf icecast-$ICECAST_VERSION.tar.gz -C .

WORKDIR /build/icecast-$ICECAST_VERSION

RUN ./configure \
        --prefix=/usr \
        --localstatedir=/var \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --infodir=/usr/share/info \
        --with-curl

RUN make check
RUN make install DESTDIR=/build/output

FROM alpine:3.21

LABEL name="docker-icecast" \
      maintainer="Jee jee@jeer.fr" \
      description="Icecast is free server software for streaming multimedia." \
      url="https://icecast.org" \
      org.label-schema.vcs-url="https://github.com/jee-r/docker-icecast" \
      org.opencontainers.image.source="https://github.com/jee-r/docker-icecast"

# Ne koristi rootfs, samo kopiraj icecast.xml
COPY icecast.xml /config/icecast.xml

RUN apk update && \
    apk upgrade && \
    apk add --upgrade --no-cache --virtual=base \
        curl \
        libxslt \
        libxml2 \
        libogg \
        libvorbis \
        libtheora \
        speex \
        openssl \
        mailcap \
        tzdata && \
    chmod -R 777 /config && \
    rm -rf /tmp/* 

COPY --from=builder /build/output /

# Izmenjen port na 8080
EXPOSE 8080

WORKDIR /config

# Healthcheck i signalizacija
HEALTHCHECK --interval=1m --timeout=10s --start-period=30s --retries=5 \
    CMD curl --fail --silent --show-error --output /dev/null --write-out "%{http_code}"  http://127.0.0.1:8080/status-json.xsl || exit 1

STOPSIGNAL SIGQUIT

# Pokreće Icecast sa konfiguracijom
ENTRYPOINT ["icecast", "-c", "/config/icecast.xml"]
