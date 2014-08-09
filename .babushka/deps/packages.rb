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
    otherwise 'vim'
  }
end

dep 'xfce4-terminal.managed'
dep 'keychain.managed'

dep 'smplayer.managed'
dep 'thunderbird.managed'

dep 'i3.managed' do
  requires %w(i3status.managed i3lock.managed)
end

dep 'i3status.managed'
dep 'i3lock.managed'

# screenshot capture:
dep 'scrot.managed'

dep 'nm-applet.managed' do
  installs {
    via :yum, 'network-manager-applet'
    otherwise 'network-manager-applet'
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
    via :apt, 'encfs'
    otherwise 'encfs'
  }
end

dep 'repoquery.managed' do
  installs {
    via :yum, 'yum-utils'
  }
end

dep 'iotop.managed'

dep 'sensors.managed' do
  installs {
    via :yum, %w(lm_sensors)
  }
end

dep 'codecs' do
  requires %w(
    rpmfusion.repository

    ffmpeg.lib

    gstreamer-plugins-bad.rpm
    gstreamer-plugins-bad-free.lib
    gstreamer-plugins-bad-nonfree.lib
    gstreamer-plugins-good.lib
    gstreamer-plugins-ugly.rpm

    gstreamer1-libav.lib

    gstreamer1-plugins-bad-free.lib
    gstreamer1-plugins-good.lib
    gstreamer1-plugins-ugly.lib
  )
end

# For some of these packages we need to use rpm instead of lib, or else the
# "met?" test doesn't work for some reason.
dep 'ffmpeg.lib'

dep 'gstreamer-plugins-bad.rpm'
dep 'gstreamer-plugins-bad-free.lib'
dep 'gstreamer-plugins-bad-nonfree.lib'

dep 'gstreamer-plugins-good.lib'
dep 'gstreamer-plugins-ugly.rpm'

dep 'gstreamer1-libav.lib'

dep 'gstreamer1-plugins-bad-free.lib'
dep 'gstreamer1-plugins-good.lib'
dep 'gstreamer1-plugins-ugly.lib'

dep 'flash' do
  requires %w(flash-plugin.lib nspluginwrapper.lib alsa-plugins-pulseaudio.lib)
end

dep 'nspluginwrapper.lib' do requires %w(adobe.repository) end
dep 'flash-plugin.lib' do requires %w(adobe.repository) end
dep 'alsa-plugins-pulseaudio.lib' do requires %w(adobe.repository) end

dep 'infinality' do
 requires %w(
   fontconfig-infinality.lib
   fontforge-infinality.rpm
   freetype-infinality.rpm
 )
end

# Need to use special "rpm" template for some of these, for some reason.
dep 'fontconfig-infinality.lib' do requires 'infinality.repository' end
dep 'fontforge-infinality.rpm' do requires 'infinality.repository' end
dep 'freetype-infinality.rpm' do requires 'infinality.repository' end

# hw video decode support for intel graphics.
dep 'libva-intel-driver.lib' do requires 'rpmfusion.repository' end

dep 'abrt.rm_lib' do
  requires %w(abrt-libs.rm_lib abrt-gui-libs.rm_lib)
end

dep 'abrt-libs.rm_lib'
dep 'abrt-gui-libs.rm_lib'

dep 'mta' do
  requires 'postfix.managed'
end

dep 'postfix.managed'

dep 'checkrestart', template: 'bin' do
  installs {
    via :apt, 'debian-goodies'
    via :yum, 'yum-utils'
    otherwise 'debian-goodies'
  }

  provides {
    via :apt, 'checkrestart'
    via :yum, 'needs-restarting'
    otherwise 'needs-restarting'
  }
end

dep 'debian-goodies.managed'
dep 'yum-utils.managed'

dep 'systemctl.bin' do
  installs {
    via :yum, 'systemd'
  }
end

dep 'atop.managed'
dep 'iftop.managed'

dep 'smartmontools' do
  requires %w(smartmontools.lib smartd.enable)
end

dep 'smartmontools.lib'
dep 'smartd.enable' do
  requires %w(smartd.systemd_enable smartd.sysv_enable)
end

dep 'smartd.systemd_enable', for: :fedora
dep 'smartd.sysv_enable', for: :ubuntu

dep 'gftp', template: 'managed'

dep 'rdfind' do
  requires %w(rdfind.managed rdfind.src)
end

dep 'rdfind.managed', for: :ubuntu

dep 'rdfind.src', :version, for: :fedora do
  version.default!('1.3.4')
  source "http://rdfind.pauldreik.se/rdfind-#{version}.tar.gz"
  provides "rdfind = #{version}"

  requires 'nettle-devel'
end

dep 'nettle-devel', template: 'lib'

# network ups tools:
dep 'nut', template: 'managed' do
  provides %w(upsd)
end
