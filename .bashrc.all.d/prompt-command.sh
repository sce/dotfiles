# Remember history across multiple terminals:
# https://askubuntu.com/a/673283
# -a for append right now; -n for read new entries right now
PROMPT_COMMAND='history -a; history -n;'$PROMPT_COMMAND
