#!/bin/bash

set -euo pipefail

packages=(
  google-chrome-stable
)

# https://docs.fedoraproject.org/en-US/quick-docs/installing-chromium-or-google-chrome-browsers/
function enable_repo {
  sudo dnf install -y fedora-workstation-repositories
  # sudo dnf config-manager --set-enabled google-chrome
  sudo dnf config-manager setopt google-chrome.enabled=1
}

(
  set -x

  enable_repo
  sudo dnf install -y "${packages[@]}"
)
