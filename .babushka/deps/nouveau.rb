dep 'nouveau' do
  requires 'xorg-x11-drv-nouveau.lib'
  requires 'nouveau setup'
  requires 'nvidia.rm_lib'
end

dep 'nouveau.rm_lib' do
  remove 'xorg-x11-drv-nouveau'
end

dep 'nouveau setup' do
  def dir
    '/etc/X11/'
  end

  met? {
    files = Dir[dir + "xorg.conf"] + Dir[dir + "xorg.conf.d/*"]

    files.any? { |file|
      file.p.grep /nouveau/ and file.p.grep /GLXVBlank/
    }
  }

  meet {
    src = File.join File.dirname(__FILE__), "data", "20-nouveau.conf"
    dest = File.join dir, "xorg.conf.d", "20-nouveau.conf"

    shell %(cp -v %s %s) % [src, dest], sudo: true
  }
end

dep 'nouveau teardown' do
  def dir
    '/etc/X11/'
  end

  def nouveau_config
    files = Dir[dir + "xorg.conf"] + Dir[dir + "xorg.conf.d/*"]

    files.find { |file|
      file.p.grep /nouveau/ and file.p.grep /GLXVBlank/
    }
  end

  met? { not nouveau_config }

  meet {
    unmeetable! "File %s contains nouveau config." % nouveau_config
  }
end
