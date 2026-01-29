Just a simple container to run tome2 in.

This branch uses Alpine Linux, and as-such also builds the game rather than installing a package. Make sure you grab the submodule! I'm using the [Debian maintainer's repo](https://salsa.debian.org/srivasta/tome) since it's a known working build (with a small patch, see `fixup.patch`). The [real upstream repo](https://github.com/tome2/tome2) is newer but the commits are directly into master. I don't know if that is a sane state.

We use Alpine 3.22 as 3.23 brings build errors with it that I don't feel like trying to track down or patch.

You should use a volume to keep a copy of `/home/tome/.tome` around. For example, assuming you tagged the image 'tome':

    # the dumb way, using a bind mount
    mkdir -p "${HOME}/.tome" && podman run --rm -it -v "$HOME/.tome:/root/.tome:rw,z" tome

    # or, using a proper volume (this should create and persist automatically!)
    podman run --rm -it -v tome:/root/.tome:rw,z tome

This doesn't exactly roll off the fingertips, so consider setting an alias or writing a wrapper script. You do you.

Game binary is: `/usr/local/games/tome-gcu`

----

Alternatively, if you have [apptainer](https://apptainer.org/docs/user/latest/introduction.html) or [singularity](https://apptainer.org/docs/user/latest/singularity_compatibility.html) you can use the `build.def` and `tome.def` instead. This will produce a runnable tome artifact that's only about 8mb in size, which mounts your userspace etc for transparent operation. I definitly recommend this!

1. Do once: `apptainer build build.sif build.def`
2. To build the game runtime: `apptainer build tome.sif tome.def`

Treat `tome.sif` like any other binary.
