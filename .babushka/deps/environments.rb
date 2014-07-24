dep "environments-console" do

  requires %w(
    vim.managed
    keychain.managed
    encfs.managed
    iotop.managed
    sensors.managed
  )

end

dep 'environments-desktop' do
  requires %w(
    i3.managed
    xfce4-terminal.managed

    smplayer.managed
    thunderbird
    gkrellm.managed

    nm-applet.managed
    redshift-gtk.managed
    lxpolkit.managed
    wallpaperd.managed
    dunst.managed

    humanity-icon-theme.managed
    light-theme-gnome.managed
    disable-tracker

    codecs
    flash

    infinality
    abrt.rm_lib
  )
end

dep "environments-dev" do
  requires %w(
    mariadb.managed
    mariadb-server.managed
    rvm
  )
end

dep "kira" do
  requires "environments-console", "environments-desktop"
  requires 'nvidia'
end

dep "ryuzaki" do
  requires "environments-console", "environments-desktop"
end
