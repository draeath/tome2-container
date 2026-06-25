#!/usr/bin/env bash
set -euo pipefail

unset APPTAINER_BINDPATH
apptainer build -F build.sif build.def
