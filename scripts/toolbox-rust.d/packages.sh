#!/bin/bash

set -euo pipefail

packages=(
  neovim vim
  keychain dnf5
  jq entr
  # these give us ansi2txt for stripping color codes:
  graphviz colorized-logs

  cargo
  rust
  rust-analyzer
  rustfmt
)

(
  set -x
  sudo dnf install -y "${packages[@]}"
)
