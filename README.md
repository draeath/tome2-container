Just a simple container to run tome2 in.

This branch uses Alpine Linux, and as-such also builds the game rather than installing a package. Make sure you grab the submodule! I'm using the [Debian maintainer's repo](https://salsa.debian.org/srivasta/tome) since it's a known working build (with a small patch, see `fixup.patch`). The [real upstream repo](https://github.com/tome2/tome2) is newer but the commits are directly into master. I don't know if that is a sane state.

You should use a volume to keep a copy of `/home/tome/.tome` around. For example, assuming you tagged the image 'tome':

    # the dumb way, using a bind mount
    mkdir -p "${HOME}/.tome" && podman run --rm -it -v "$HOME/.tome:/root/.tome:rw" tome

    # or, using a proper volume (this should create and persist automatically!)
    podman run --rm -it -v tome:/root/.tome tome

This doesn't exactly roll off the fingertips, so consider setting an alias or writing a wrapper script. You do you.

Game binary is: `/usr/games/tome-gcu` (or the symlink `/usr/bin/tome`)
