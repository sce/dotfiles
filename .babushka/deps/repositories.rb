dep 'rpmfusion.repository' do
  def release
    raw_shell(%(rpm -E %fedora)).stdout.strip
  end

  installs %w(rpmfusion-free rpmfusion-free-updates rpmfusion-nonfree rpmfusion-nonfree-updates)
  url %W(
    http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-#{release}.noarch.rpm
    http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-#{release}.noarch.rpm
  )
end

dep 'adobe.repository' do
  installs %w(adobe-linux-x86_64)
  url %(http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm)
end

dep 'infinality.repository' do
  url %(http://www.infinality.net/fedora/linux/infinality-repo-1.0-1.noarch.rpm)
end
