#!/bin/bash

set -euo pipefail

tmp_dir=${1:-$(mktemp -d)}
destination_dir=$HOME/.local

repo_url="https://github.com/AlynxZhou/showmethekey.git"
version="v1.10.0"
version="v1.9.0"

dnf_showmethekey=(
    cairo-devel
    glib2-devel
    gtk4-devel
    json-glib-devel
    libadwaita-devel
    libevdev-devel
    libinput-devel
    libxkbcommon-devel
    libudev-devel
    pango-devel
    polkit-devel

    gcc
    meson
    ninja-build
)

function install_deps {
  (
    set -x
    sudo dnf install -y "${dnf_showmethekey[@]}"
  )
}

function build_showmethekey {
    (
        cd "$tmp_dir"
        git clone --branch "$version" "$repo_url"

        cd showmethekey
        mkdir -p build
        cd build

        meson setup --prefix="$destination_dir" . ..
        meson compile
        meson install
    )
}

install_deps
build_showmethekey
