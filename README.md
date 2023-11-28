Just a simple container to run tome2 in, since [compilation](https://github.com/tome2/tome2) is libboost version sensitive and Debian packages a reasonably modern version of the game already.

You should use a volume to keep a copy of `/home/tome/.tome` around. For example, assuming you tagged the image 'tome':

    # the dumb way, using a bind mount
    mkdir -p "${HOME}/.tome" && podman run --rm -it -v "$HOME/.tome:/root/.tome:rw" tome

    # or, using a proper volume (this should persist automatically!)
    podman volume create --ignore tome && podman run --rm -it -v tome:/root/.tome tome

This doesn't exactly roll off the fingertips, so consider setting an alias or writing a wrapper script. You do you.

Game binaries are:
  - `/usr/games/tome-gcu`
  - `/usr/games/tome-gtk2`
  - `/usr/games/tome-x11`

By default it'll run it in ncurses mode (-gcu), but feel free to run whatever you want. How you get Xorg to work with the container is a joy you get to discover yourself. You'll probably need to make changes to the container, and fuss with `--userns` and so on. Have fun.
