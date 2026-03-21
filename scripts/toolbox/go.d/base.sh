#!/bin/bash

#
# Go (golang) environment
#
set -euo pipefail

packages=(
  neovim
  fzf bat
  cmake # for telescope-fzf-native

  graphviz # "dot" etc.

  # go:
  golang
  golang-x-tools-gopls
)

(
  set -x
  sudo dnf install -y "${packages[@]}"
)
