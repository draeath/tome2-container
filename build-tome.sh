#!/usr/bin/env bash
set -euo pipefail

if test -f tome.tar; then
  unlink tome.tar
fi
apptainer build --mksquashfs-args "-comp zstd -Xcompression-level 22" -F --mount "type=bind,src=${CCACHE_DIR:-$HOME/.cache/ccache},dst=/tmp/.ccache" tome.sif tome.def
