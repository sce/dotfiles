dep 'update initramfs.task' do
  run {
    log_shell 'Updating initramfs', %(dracut -f)
  }
end
