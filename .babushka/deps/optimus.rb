# The nouveau driver is buggy and causing graphical glitches/corruption when
# doing offload work in optimus, so we disable it. (And since it's activated
# very early we do it via the kernel commandline.)
dep 'optimus' do
  met? {
    '/etc/default/grub'.p.grep(/modprobe.blacklist=nouveau/)
  }

  meet {
    unmeetable! %(/etc/default/grub needs to blacklist nouveau.)
  }
end
