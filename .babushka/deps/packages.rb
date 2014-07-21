# for nvidia:
dep 'acpid.lib'
dep 'kernel-devel.lib'
dep 'xorg-x11-drv-nvidia-libs.lib'

dep 'libva-utils'
dep 'libva-vdpau-driver'
dep 'vdpauinfo'

# nouveau:
dep 'xorg-x11-drv-nouveau.lib'

# environments:
dep 'vim.managed' do
  installs {
    via :yum, 'vim-minimal'
  }
end

dep 'xfce4-terminal.managed'
dep 'keychain.managed'

dep 'smplayer.managed'
dep 'thunderbird.managed'

dep 'i3.managed' do
  requires 'i3status.managed'
end

dep 'i3status.managed'

dep 'nm-applet.managed' do
  installs {
    via :yum, 'network-manager-applet'
  }
end

dep 'redshift-gtk.managed'

dep 'lxpolkit.managed' do
  met? {
    # Binary is not in path, so query manually:
    '/usr/libexec/lxpolkit'.p.exists?
  }
end

dep 'wallpaperd.managed'
dep 'dunst.managed'

dep 'humanity-icon-theme.managed' do
  provides []
end

dep 'light-theme-gnome.managed' do
  provides []
end

dep 'thunderbird'

dep 'mariadb.managed' do
  provides %w(mysql)
end

dep 'mariadb-server.managed' do
  provides %w(mysqld_safe)
end

dep 'curl.managed'
dep 'gkrellm.managed'

dep 'encfs.managed' do
  installs {
    via :yum, 'fuse-encfs'
  }
end

dep 'repoquery.managed' do
  installs {
    via :yum, 'yum-utils'
  }
end

dep 'iotop.managed'
