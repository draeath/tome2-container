Just a simple container to run tome2 in, since [compilation](https://github.com/tome2/tome2) is libboost version sensitive and Debian packages a reasonably modern version of the game already.

You should use a volume to keep a copy of `/home/tome/.tome` around.

By default it'll run it in ncurses mode, but feel free to run whatever you want. Game binaries are:
  - `/usr/games/tome-gcu`
  - `/usr/games/tome-gtk2`
  - `/usr/games/tome-x11`
