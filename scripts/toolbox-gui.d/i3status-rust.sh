#!/bin/bash

set -euo pipefail

copr_i3status_rs="atim/i3status-rust"

packages=(
  i3status-rust
)

set -x

sudo dnf copr enable -y $copr_i3status_rs
sudo dnf install -y "${packages[@]}"
