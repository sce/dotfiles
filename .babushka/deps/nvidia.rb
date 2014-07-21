dep 'nvidia' do
  requires 'akmod-nvidia.lib'
  requires 'nouveau.rm_lib'
  requires 'nouveau teardown'
end

dep 'akmod-nvidia.lib' do
  requires 'xorg-x11-drv-nvidia-libs.lib', 'kernel-devel.lib', 'acpid.lib'
  requires 'vdpauinfo', 'libva-vdpau-driver', 'libva-utils'

  after 'update initramfs.task'
end

dep 'nvidia.rm_lib' do
  remove 'xorg-x11-drv-nvidia\*'

  after 'update initramfs.task'
end
