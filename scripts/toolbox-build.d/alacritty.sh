#!/bin/bash

set -euo pipefail

dnf_deps=(
  cargo
  cmake
  gcc-c++

  fontconfig-devel
  libxcb-devel
)

(
  set -x
  sudo dnf install -y "${dnf_deps[@]}"

  # after building, it can be found in ~/.cargo/bin/alacritty
  cargo install alacritty

  cp -v "$HOME/.cargo/bin/alacritty" "$HOME/.local/bin"
)
