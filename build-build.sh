#!/usr/bin/env bash
set -euo pipefail

apptainer build --mksquashfs-args "-comp lz4" -F build.sif build.def
