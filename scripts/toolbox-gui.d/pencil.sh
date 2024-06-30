#!/bin/bash

set -euo pipefail

# https://pencil.evolus.vn/
rpm_name=Pencil-3.1.1.ga.x86_64.rpm
rpm_url=https://pencil.evolus.vn/dl/V3.1.1.ga/$rpm_name

download_dir=$(xdg-user-dir DOWNLOAD)

file=$(readlink -f "$download_dir/$rpm_name")

[[ -f "$file" ]] || (
  tmp_dir=$(mktemp -d)
  tmp_file=$tmp_dir/$rpm_name

  (
    set -x
    wget --verbose $rpm_url --output-document "$tmp_file"
    mv -iv "$tmp_file" "$download_dir"
  )

  rmdir --ignore-fail-on-non-empty "$tmp_dir"
)

(
  set -x
  sudo dnf install -y "$file"
)
