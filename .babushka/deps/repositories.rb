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

#dep 'fedora-chromium-stable.repository' do
#end

dep 'spot-chromium.copr', installs: "spot/chromium"

dep 'russianfedora' do
  requires %w(russianfedora-free.repository russianfedora-nonfree.repository)
end

dep 'russianfedora-free.repository' do
  # no gpg-check ...
  url %(http://mirror.yandex.ru/fedora/russianfedora/russianfedora/free/fedora/russianfedora-free-release-stable.noarch.rpm)
end

dep 'russianfedora-nonfree.repository' do
  # no gpg-check ...
  url %(http://mirror.yandex.ru/fedora/russianfedora/russianfedora/nonfree/fedora/russianfedora-nonfree-release-stable.noarch.rpm)
end
