#!/bin/bash

# https://github.com/wong-justin/vic

set -euo pipefail

tmp_dir=${1:-$(mktemp -d)}
destination_dir="$HOME/.local"

repo_url="https://github.com/wong-justin/vic.git"
version="0.8.3"
sw_name="vic"

dnf_deps=(
  chafa-devel
  # needed during runtime:
  chafa
  ffmpeg
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
    git clone --branch "$version" "$repo_url"

    cd "$sw_name"
    cargo build --release
  )
}

function install_sw {
  (
    set -x
    cd "$sw_name"
    cp -i "target/release/$sw_name" "${destination_dir}/bin"
  )
}

install_deps
(
  cd "$tmp_dir"
  build_sw
  install_sw
)
