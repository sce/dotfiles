# .bash_profile

echo "Running .bash_profile" >&2

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    # bashrc sources `~/.profile`:
    . ~/.bashrc
fi
