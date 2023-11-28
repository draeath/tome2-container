FROM debian:bookworm

ENV DEBIAN_FRONTEND noninteractive
COPY debian.sources /etc/apt/sources.list.d/debian.sources
RUN apt-get update \
 && apt-get install --no-install-recommends -y tini tome \
 && apt-get clean \
 && rm -rvf /var/lib/apt/lists/*
ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/usr/games/tome-gcu", "--", "-b"]
