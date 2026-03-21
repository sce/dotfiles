#!/bin/bash

# https://github.com/wong-justin/vic

set -euo pipefail

tmp_dir=${1:-$(mktemp -d)}
destination_dir="$HOME/.local"

repo_url="https://github.com/emin-ozata/lazycut.git"
version="v0.3.3"
sw_name="lazycut"

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
    go build
  )
}

function install_sw {
  (
    set -x
    cd "$sw_name"
    cp -i "$sw_name" "${destination_dir}/bin"
  )
}

install_deps
(
  cd "$tmp_dir"
  build_sw
  install_sw
)
