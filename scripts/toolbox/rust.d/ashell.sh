#!/bin/bash

# https://malpenzibo.github.io/ashell/docs/installation

set -euo pipefail

tmp_dir=${1:-$(mktemp -d)}
destination_dir="$HOME/.local"

repo_url="https://github.com/MalpenZibo/ashell.git"
version="0.7.0"

dnf_deps=(
  clang
  dbus-devel
  libxkbcommon-devel
  pipewire-devel
  pulseaudio-libs-devel
  wayland-devel
  wayland-protocols-devel
)

function install_deps {
  (
    set -x
    sudo dnf install -y "${dnf_deps[@]}"
  )
}

function build_sw {
  (
    set -x
    cd "$tmp_dir"
    git clone --branch "$version" "$repo_url"

    cd ashell
    cargo build --release
  )
}

function install_sw {
  (
    set -x
    cd "$tmp_dir"
    cd ashell
    cp target/release/ashell "${destination_dir}/bin"
  )
}

install_deps
build_sw
install_sw
