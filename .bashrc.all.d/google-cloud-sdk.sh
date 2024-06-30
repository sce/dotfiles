sdk_root="$HOME/Downloads/google-cloud-sdk"

# The next line updates PATH for the Google Cloud SDK.
bash_path="$sdk_root/path.bash.inc"
if [ -f "$bash_path" ]; then
  . "$bash_path"
fi

# The next line enables shell command completion for gcloud.
bash_completion="$sdk_root/completion.bash.inc"
if [ -f "$bash_completion" ]; then
  . "$bash_completion"
fi
