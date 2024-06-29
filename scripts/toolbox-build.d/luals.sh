#!/bin/bash

# lua language server

set -euo pipefail

tmp_dir=${1:-$(mktemp -d)}
destination_dir=$HOME/.local/lua-language-server
destination_bin=$HOME/.local/bin

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
  )
}

function install_luals {
  (
    set -x

    [[ -d "$destination_dir" ]] && rm -rI "$destination_dir"
    mkdir -p "$destination_dir"

    cd "$tmp_dir"/lua-language-server
    # These files are in the release tar ball and are needed to make the
    # install work:
    cp -R main.lua debugger.lua bin locale meta script "$destination_dir"

    ln -sf "$destination_dir"/bin/lua-language-server "$destination_bin"
  )

  echo -e "\nInstalled lua-language-server into:"
  echo "    $destination_dir"
  echo "    $destination_bin"
}

function cleanup {
  echo -e "\nThe temporary files can safely be deleted. Remove $tmp_dir ?"
  select yn in "Yes" "No"; do
      case $yn in
          Yes) rm -fr "$tmp_dir"; break;;
          No) break;;
      esac
  done
}

install_deps
build_luals
install_luals
cleanup
