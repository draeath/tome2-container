#!/usr/bin/env bash
set -euo pipefail

unset APPTAINER_BINDPATH
if test -f tome.tar; then
  unlink tome.tar
fi
apptainer build --mksquashfs-args "-comp gzip -Xcompression-level 6" -F tome.sif tome.def
