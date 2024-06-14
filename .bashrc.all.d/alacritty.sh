# Enable correct window title updates for alacritty:
# https://github.com/alacritty/alacritty/issues/1636
case ${TERM} in
  alacritty)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
          ;;
esac
