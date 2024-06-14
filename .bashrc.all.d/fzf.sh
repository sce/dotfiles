# enable fzf shell keybindings (when fzf package is installed)
script=/usr/share/fzf/shell/key-bindings.bash
if [ -f "$script" ]; then . "$script"; fi
