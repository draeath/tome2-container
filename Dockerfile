FROM debian:bookworm

ENV DEBIAN_FRONTEND noninteractive
COPY debian.sources /etc/apt/sources.list.d/debian.sources
RUN apt-get update \
 && apt-get install --no-install-recommends -y tini tome \
 && apt-get clean \
 && rm -rvf /var/lib/apt/lists/*
RUN useradd -m -s /bin/bash tome
USER tome
WORKDIR /home/tome
RUN mkdir -v .tome
ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/usr/games/tome-gcu", "--", "-b"]
