#!/bin/bash

set -xeuo pipefail

ruby -ryaml -e "pp YAML.load(STDIN.read)" < $1
