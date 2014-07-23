dep 'rpmfusion' do
  def repositories
    # the first two lines are headers, the last is footer.
    raw_shell(%(yum repolist rpmfusion-*)).stdout.split(/\n/)[2..-2].map do |line|
      line.split("/").first
    end
  end

  def needed
    %w(rpmfusion-free rpmfusion-free-updates rpmfusion-nonfree rpmfusion-nonfree-updates)
  end

  met? {
   (needed - repositories).empty?
  }

  meet {
    shell %( \
      yum localinstall --nogpgcheck \
      http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
      http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    ), sudo: true
  }
end
