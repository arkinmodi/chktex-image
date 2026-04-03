FROM alpine:latest AS builder

RUN apk add --update --no-cache \
    autoconf \
    automake \
    curl \
    gcc \
    libc-dev \
    make \
    ncurses-dev

ARG CHKTEX_VERSION=1.7.10
ARG CHKTEX_SHA256=cea81a1cde2f151db2b5d2adf2271becfd3c0c1f40eca5cf45b52beeb4a636f9

RUN : \
    && curl --silent --location --output /tmp/chktex.tar.gz http://download.savannah.gnu.org/releases/chktex/chktex-${CHKTEX_VERSION}.tar.gz \
    && echo "${CHKTEX_SHA256}  /tmp/chktex.tar.gz" | sha256sum -c \
    && mkdir /opt/chktex \
    && tar --strip-components 1 --directory /opt/chktex -xf /tmp/chktex.tar.gz \
    && cd /opt/chktex \
    && ./autogen.sh \
    && ./configure LIBS="-lncurses" \
    && make

FROM alpine:latest

LABEL \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/arkinmodi/chktex-image" \
    org.opencontainers.image.title="ChkTeX Slim"

RUN apk add --update --no-cache \
    dumb-init

ENV CHKTEXRC=/usr/local/share/chktexrc

COPY --from=builder /opt/chktex/chktex /usr/bin/
COPY --from=builder /opt/chktex/chktexrc /usr/local/share/chktexrc/.chktexrc

ENTRYPOINT ["dumb-init", "--"]
