#!/bin/bash

# lua language server

set -euo pipefail

tmp_dir=${1:-$(mktemp -d)}
destination_dir=$HOME/.local/bin

repo_url="https://github.com/LuaLS/lua-language-server.git"
version="3.9.3"

dnf_deps=(
  libstdc++-static
)

function install_deps {
  (
    set -x
    sudo dnf install -y "${dnf_deps[@]}"
  )
}

function build_luals {
  (
    set -x

    cd "$tmp_dir"
    [[ -d lua-language-server ]] || git clone --branch "$version" "$repo_url"

    cd lua-language-server
    ./make.sh

    cp -vi bin/lua-language-server "$destination_dir" || true
  )
}

install_deps
build_luals
