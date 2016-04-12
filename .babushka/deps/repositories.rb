dep 'rpmfusion' do
  requires %w(rpmfusion-free.repository rpmfusion-nonfree.repository)
end

dep 'rpmfusion-free.repository' do
  url %(http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-#{release}.noarch.rpm)
end

dep 'rpmfusion-nonfree.repository' do
  url %(http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-#{release}.noarch.rpm)
end

dep 'adobe.repository' do
  installs %w(adobe-linux-x86_64)
  url %(http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm)
end

dep 'infinality.repository' do
  url %(http://www.infinality.net/fedora/linux/infinality-repo-1.0-1.noarch.rpm)
end
