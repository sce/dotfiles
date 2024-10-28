# .bash_profile

echo "Running .bash_profile" >&2

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs
if [ -f ~/.profile ]; then
   . ~/.profile
fi
