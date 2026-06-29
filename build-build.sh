#!/usr/bin/env bash
set -euo pipefail

unset APPTAINER_BINDPATH
apptainer build --mksquashfs-args "-comp gzip -Xcompression-level 6" -F build.sif build.def
