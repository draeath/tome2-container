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

Note that I am specifically spoofing the two X11-related dependencies of the tome package, and as-such the `tome-gtk2` and `tome-x11` binaries in this container are intentionally broken. The dependencies increase the container image size. Ideally they'd be packaged separately, but they aren't and so we make do. If you really want them to work, edit the Dockerfile and remove the lines referencing `tome-gui-dummy-deps_1.0_all.deb`. Getting them to do anything useful from within a container, well, I leave that up to you.
