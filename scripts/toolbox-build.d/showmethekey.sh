#!/bin/bash

set -euo pipefail

version="v1.10.0"
version="v1.9.0"
tmp_dir=~/tmp

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

function build_showmethekey {
    #local prefix=/usr
    local prefix=~/.local

    (
        mkdir -p $tmp_dir
        pushd $tmp_dir

        #rm --recursive --verbose --force "$(readlink -f showmethekey)"
        rm --recursive --verbose --interactive=once "$(readlink -f showmethekey)" || true

        git clone --branch "$version" https://github.com/AlynxZhou/showmethekey.git
        cd showmethekey
        mkdir -p build
        cd build

        meson setup --prefix="$prefix" . ..
        meson compile
        meson install
        popd
    )
}

set -x

sudo dnf install -y "${dnf_showmethekey[@]}"
build_showmethekey
