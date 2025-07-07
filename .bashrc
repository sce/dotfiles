# .bashrc

echo "Running .bashrc" >&2

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment and startup programs
if [ -f ~/.profile ]; then
    . ~/.profile
fi

# User specific environment
# .config/environment.d/300-path.conf and .profile should take care of this now.
# # if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
# #     PATH="$HOME/.local/bin:$HOME/bin:$PATH"
# # fi
# # export PATH
#
# # VISUAL=,,vanilla-nvim
# # EDITOR=$VISUAL

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

alias ls="ls --color"
