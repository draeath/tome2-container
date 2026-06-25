#!/usr/bin/env bash
set -euo pipefail

unset APPTAINER_BINDPATH
if test -f tome.tar; then
  unlink tome.tar
fi
apptainer build tome.sif tome.def
