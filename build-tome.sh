#!/usr/bin/env bash
set -euo pipefail

if test -f tome.tar; then
  unlink tome.tar
fi
apptainer build -F tome.sif tome.def
