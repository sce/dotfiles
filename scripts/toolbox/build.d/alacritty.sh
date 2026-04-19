#!/bin/bash

set -euo pipefail

dest_dir="$HOME/.local/bin"

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

  mkdir -pv "$dest_dir"
  cp -v "$HOME/.cargo/bin/alacritty" "$dest_dir"
)
