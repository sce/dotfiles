#!/bin/bash

set -euo pipefail

packages=(
  # sway things:
  # wdisplays needs libGLESv2 which in fedora is found in libglvnd-gles:
  wdisplays libglvnd-gles wf-recorder

  # misc things:
  pavucontrol gkrellm zenity obs-studio
)

(
  set -x
  sudo dnf install -y "${packages[@]}"
)
