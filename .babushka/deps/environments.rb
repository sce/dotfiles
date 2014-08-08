dep "environments-console" do
  requires %w(
    vim.managed
    keychain.managed
    encfs.managed
    mta
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
    scrot.managed

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

dep "environments-monitoring" do
  requires %w(
    iotop.managed
    sensors.managed
    atop.managed
    smartmontools
    iftop.managed
  )
end

dep "environments-server" do
  requires %w(
    environments-monitoring
    checkrestart
  )
end

dep "kira" do
  requires %w(
    environments-console
    environments-desktop
    environments-monitoring
  )
  requires 'nvidia'
end

dep "ryuzaki" do
  requires %w(
    environments-console
    environments-desktop
    environments-monitoring
  )
  requires %w(optimus libva-intel-driver.lib)
end
