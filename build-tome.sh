#!/usr/bin/env bash
set -euo pipefail

if test -f tome.tar; then
  unlink tome.tar
fi
apptainer build --mksquashfs-args "-comp lzo" -F tome.sif tome.def
