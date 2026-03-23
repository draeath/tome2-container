#!/usr/bin/env bash
set -euo pipefail

apptainer build --mksquashfs-args "-comp zstd -Xcompression-level 22" -F tome.sif tome.def
