#!/bin/bash

set -euo pipefail

dest_dir="$HOME/.local/bin"
repo_url="https://github.com/negrel/wooz"

dnf_deps=(
  gcc-c++
  meson
  ninja

  wayland-devel
  wayland-protocols-devel
  wlr-protocols-devel
)

(
  set -x
  sudo dnf install -y "${dnf_deps[@]}"

  tmp_dir=$(mktemp -d)
  cd "$tmp_dir"
  git clone "$repo_url"

  cd wooz
  mkdir -p build

  export CFLAGS="-O3"
  meson build
  ninja -C build

  mkdir -pv "$dest_dir"
  cp -v "./build/wooz" "$dest_dir"

  rm -rf "$tmp_dir"
)
