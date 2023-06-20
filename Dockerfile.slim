FROM alpine:latest AS builder

RUN apk add --update --no-cache \
    autoconf \
    automake \
    curl \
    gcc \
    libc-dev \
    make

ARG CHKTEX_VERSION=1.7.8
ARG CHKTEX_SHA256=5286f7844f0771ac0711c7313cf5e0421ed509dc626f9b43b4f4257fb1591ea8

RUN : \
    && curl --silent --location --output /tmp/chktex.tar.gz http://download.savannah.gnu.org/releases/chktex/chktex-${CHKTEX_VERSION}.tar.gz \
    && echo "${CHKTEX_SHA256}  /tmp/chktex.tar.gz" | sha256sum -c \
    && mkdir /opt/chktex \
    && tar --strip-components 1 --directory /opt/chktex -xf /tmp/chktex.tar.gz \
    && cd /opt/chktex \
    && ./autogen.sh \
    && ./configure \
    && make

FROM alpine:latest

RUN apk add --update --no-cache \
    dumb-init

ENV CHKTEXRC=/usr/local/share/chktexrc

COPY --from=builder /opt/chktex/chktex /usr/bin/
COPY --from=builder /opt/chktex/chktexrc /usr/local/share/chktexrc/.chktexrc

ENTRYPOINT ["dumb-init", "--"]
