FROM docker.io/library/alpine:3.21 AS build

RUN apk update && apk add binutils boost1.84-dev cmake g++ gcc jansson-dev libc-dev make ncurses-dev patch
ADD tome /root/tome
COPY fixup.patch /root/tome/fixup.patch
WORKDIR /root/tome
RUN patch -p1 < fixup.patch
ENV CFLAGS="-flto=auto -fwhole-program -fno-fat-lto-objects"
ENV CXXFLAGS="-flto=auto -fwhole-program -fno-fat-lto-objects"
RUN cmake -Wno-dev -DSYSTEM_INSTALL:BOOL=true -DCMAKE_BUILD_TYPE=Release .
RUN make -j$(nproc)
RUN make install
RUN strip --strip-unneeded /usr/local/games/tome-gcu

FROM docker.io/library/alpine:3.21 AS runtime
RUN apk update && apk add tini boost1.84-filesystem libncursesw libstdc++ libgcc
COPY --from=build /usr/local/games/tome-gcu /usr/local/games/tome-gcu
COPY --from=build /var/games/tome /var/games/tome
RUN ln -sv /usr/local/games/tome-gcu /usr/bin/tome
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/usr/bin/tome", "--", "-b"]
