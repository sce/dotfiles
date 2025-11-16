if ! [[ "$PATH" =~ "$HOME/.local/jdk-11/bin:" ]]
then
    PATH="$HOME/.local/jdk-11/bin:$PATH"
fi
export PATH
