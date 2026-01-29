FROM docker.io/library/alpine:3.22 AS build
LABEL org.opencontainers.image.source="https://github.com/draeath/tome2-container.git"
LABEL org.opencontainers.image.version="2.41-ah~0.git.20200131-1"
LABEL org.opencontainers.image.upstream.source="https://salsa.debian.org/srivasta/tome.git"
LABEL org.opencontainers.image.upstream.revision="7661a944652f6e71c93a31b2b7f7a4136e360f30"

RUN apk update && apk add binutils boost1.84-dev cmake g++ gcc jansson-dev libc-dev make ncurses-dev patch
ADD tome /root/tome
COPY fixup.patch /root/tome/fixup.patch
WORKDIR /root/tome
RUN patch -p1 < fixup.patch
ENV CFLAGS="-flto=auto -fwhole-program -fno-fat-lto-objects -march=native -O2"
ENV CXXFLAGS="${CFLAGS}"
RUN cmake -Wno-dev -DSYSTEM_INSTALL:BOOL=true -DCMAKE_BUILD_TYPE=Release .
RUN make -j$(nproc)
RUN make install
RUN strip --strip-unneeded /usr/local/games/tome-gcu

FROM docker.io/library/alpine:3.22 AS runtime
RUN apk update && apk add tini boost1.84-filesystem libncursesw libstdc++ libgcc
COPY --from=build /usr/local/games/tome-gcu /usr/local/games/tome-gcu
COPY --from=build /var/games/tome /var/games/tome
RUN ln -sv /usr/local/games/tome-gcu /usr/bin/tome
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/usr/bin/tome", "--", "-b"]
