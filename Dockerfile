FROM arm64v8/debian:sid-slim

MAINTAINER recluse

LABEL version="0.1"
LABEL description="Debian:sid-slim with Lazylibrarian and Calibre installed for ARM64v8"

ARG UID
ARG GID

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils && \
    apt-get install -y tzdata git && \
    apt-get install -y --no-install-recommends calibre && \
    groupadd -r -o -g $GID abc && \
    useradd -r -u $UID -g abc -s /bin/false abc && \
    mkdir app && mkdir /app/lazylibrarian  && \
    git clone --depth 1 https://gitlab.com/LazyLibrarian/LazyLibrarian.git /app/lazylibrarian && \
    chown -R $UID:$GID /app/lazylibrarian && \
    apt-get purge -y apt-utils && apt-get autoremove -y && rm -rf /var/lib/apt/lists/* 

VOLUME /media /config /books /audiobook /magazines /comics /downloads
EXPOSE 5299
USER abc
COPY --chown=abc:abc ./LazyLibrarian/example_ebook_convert.py /app/lazylibrarian
COPY --chown=abc:abc ./cmd.sh /
CMD ["/cmd.sh"]
