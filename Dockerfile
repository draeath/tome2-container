FROM debian:bookworm

ENV LANG en_US.UTF-8
ENV LC_ALL C.utf8
ENV DEBIAN_FRONTEND noninteractive
COPY debian.sources /etc/apt/sources.list.d/debian.sources
RUN apt-get update && apt dist-upgrade -y && apt autoremove -y \
 && apt-get install --no-install-recommends -y locales-all tini tome \
 && apt-get clean \
 && rm -rvf /var/lib/apt/lists/*
ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/usr/games/tome-gcu", "--", "-b"]
