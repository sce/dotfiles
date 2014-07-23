dep 'rpmfusion.repository' do
  installs %w(rpmfusion-free rpmfusion-free-updates rpmfusion-nonfree rpmfusion-nonfree-updates)

  meet {
    shell %( \
      yum localinstall --nogpgcheck \
      http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
      http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    ), sudo: true
  }
end

dep 'adobe.repository' do
  installs %w(adobe-linux-x86_64)

  def url
    "http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm"
  end

  meet {
    shell %(rpm -ivh #{url}), sudo: true
    shell %(rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux), sudo: true
  }
end
