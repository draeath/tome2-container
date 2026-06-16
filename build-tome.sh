#!/usr/bin/env bash
set -euo pipefail

if test -f tome.tar; then
  unlink tome.tar
fi
apptainer build --mksquashfs-args "-comp lz4" -F tome.sif tome.def
