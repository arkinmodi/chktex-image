FROM alpine:latest AS builder

RUN apk add --update --no-cache \
    autoconf \
    automake \
    gcc \
    git \
    libc-dev \
    make

RUN : \
    && mkdir /opt/chktex \
    && git clone https://git.savannah.nongnu.org/git/chktex.git /opt/chktex \
    && cd /opt/chktex/chktex \
    && ./autogen.sh \
    && ./configure \
    && make

FROM alpine:latest

# perl is needed for deweb
RUN apk add --update --no-cache \
    dumb-init \
    perl

ENV CHKTEXRC=/usr/local/share/chktexrc

COPY --from=builder /opt/chktex/chktex/chktex /usr/bin/
COPY --from=builder /opt/chktex/chktex/chktexrc /usr/local/share/chktexrc/.chktexrc
COPY --from=builder /opt/chktex/chktex/chkweb /usr/bin/
COPY --from=builder /opt/chktex/chktex/deweb /usr/bin

RUN chmod +x /usr/bin/deweb

ENTRYPOINT ["dumb-init", "--"]
