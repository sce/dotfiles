dep "environments-console" do
  requires %w(
    vim.managed
    keychain.managed
    encfs.managed
    mta
    rdfind
  )
end

dep 'i3-full' do
  requires %w(
    i3.managed
    lxpolkit.managed
    xfce4-terminal.managed
    nm-applet.managed
    dunst.managed

    i3-portable
  )
end

dep 'i3-portable' do
  requires %w(
    xbacklight
  )
end

dep 'multimedia' do
  requires %w(
    mpv

    codecs

    chromium-full
    firefox-full

    scrot.managed

    spotify
  )
end

dep 'environments-desktop' do
  requires %w(
    i3-full
    multimedia

    disable-tracker
    abrt.rm_lib

    humanity-icon-theme.managed
    light-theme-gnome.managed

    thunderbird
    gkrellm.managed

    xchat
    qpdfview

    gnome-tweak-tool
    redshift-gtk.managed
    pavucontrol
  )
end

dep "environments-dev" do
  requires %w(
    mariadb.managed
    mariadb-server.managed
    rvm
    gftp
  )
end

dep "environments-monitoring" do
  requires %w(
    iotop.managed
    sensors.managed
    atop.managed
    smartmontools
    iftop.managed
    powertop.managed
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

#dep "ryuzaki" do
#  requires %w(
#    environments-console
#    environments-desktop
#    environments-monitoring
#    environments-dev
#  )
#  requires %w(optimus libva-intel-driver.lib)
#end

dep "ryuuzaki" do
  requires %w(
    environments-console
    environments-desktop
    environments-monitoring
  )
end

dep "turtle" do
  requires %w(
    environments-console
    environments-monitoring
  )

  requires %w(nut)
end
