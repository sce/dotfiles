# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
# for cargo system wide binaries:
if ! [[ "$PATH" =~ "$HOME/.cargo/bin:" ]]
then
    PATH="$HOME/.cargo/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Enable correct window title updates for alacritty:
# https://github.com/alacritty/alacritty/issues/1636
case ${TERM} in
  alacritty)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
          ;;
esac

# default to nvim, but try vi if it's not found:
VISUAL=nvim
EDITOR=vi

# Remember history across multiple terminals:
# https://askubuntu.com/a/673283
# -a for append right now; -n for read new entries right now
PROMPT_COMMAND='history -a; history -n;'$PROMPT_COMMAND

# enable fzf shell keybindings (when fzf package is installed)
script=/usr/share/fzf/shell/key-bindings.bash
if [ -f "$script" ]; then . "$script"; fi

alias ls="ls --color"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
#export PATH="$PATH:$HOME/.rvm/bin"

# go:
export PATH=$PATH:$HOME/go/bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/cel/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/home/cel/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/cel/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/home/cel/Downloads/google-cloud-sdk/completion.bash.inc'; fi

# disable storybook telemetry by default:
# https://storybook.js.org/docs/react/configure/telemetry#how-to-opt-out
export STORYBOOK_DISABLE_TELEMETRY=1

# for ssh-agent:
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
