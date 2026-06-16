#!/usr/bin/env bash
set -euo pipefail

apptainer build -F build.sif build.def
