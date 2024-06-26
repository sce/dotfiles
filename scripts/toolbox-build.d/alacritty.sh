#!/bin/bash

set -euo pipefail

dnf_alacritty_deps=(
  cargo
  cmake
  gcc-c++

  fontconfig-devel
  libxcb-devel
)

sudo dnf install -y "${dnf_alacritty_deps[@]}"

# after building, it can be run from ~/.cargo/bin/alacritty from the host system
cargo install alacritty
