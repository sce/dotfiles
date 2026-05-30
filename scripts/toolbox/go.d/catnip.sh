#!/bin/bash

# https://github.com/noriah/catnip

set -euo pipefail

tmp_dir=${1:-$(mktemp -d)}
destination_dir="$HOME/.local"

repo_url="https://github.com/noriah/catnip.git"
version="v1.8.7"
sw_name="catnip"

dnf_deps=(
)

function install_deps {
  if [[ -n "${dnf_deps[*]}" ]]; then
    (
      set -x
      sudo dnf install -y "${dnf_deps[@]}"
    )
  fi
}

function build_sw {
  (
    set -x
    git clone --branch "$version" "$repo_url"

    cd "$sw_name"
    go build ./cmd/catnip
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

echo Done.
