#!/bin/bash
#
# Some scripts only work properly when they are sourced, so this file creates
# functions for those scripts to automatically do that:
#

function ,cd {
  source ~/bin/,cd
}

function ,source-bash {
  source ~/bin/,source-bash
}

function ,keychain {
  source ~/.bashrc.all.d/keychain.sh
}
