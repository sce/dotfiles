#!/bin/bash

packages=(
  neovim vim fzf
  keychain
  jq entr bat ripgrep
  # these give us ansi2txt for stripping color codes
  graphviz colorized-logs

  # to compile things:
  cmake make gcc

  # bashls:
  shellcheck

  # for bash-language-server:
  nodejs yarnpkg

  # convenience, wl-copy etc:
  wl-clipboard

  rclone
  NetworkManager-tui
)

yarns=(
  bash-language-server
)

dnf_install "${packages[@]}"
yarn_add "${yarns[@]}"
