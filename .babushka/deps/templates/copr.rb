# yum copr repository.
meta 'copr' do
  accepts_list_for :installs, :basename

  template {
    def release
      which %(rpm) or log_error %(Release only available for rpm-based distributions.)
      raw_shell(%(rpm -E %fedora)).stdout.strip
    end

    def repositories
      # the first two lines are headers, the last is footer.
      raw_shell(%(dnf repolist)).stdout.split(/\n/)[2..-2].map do |line|
        # we just use the first part and remove prefix if it exists.
        line.split(%r( |/)).first.sub(/^\*|^!/, "")
      end
    end

    met? {
      # spot/chromium => spot-chromium
      missing = installs.map { |name| name.gsub("/", "-") } - repositories
      log_error "Missing: %s" % missing.join(", ") if missing.any?
      missing.empty?
    }

    meet {
      installs.each do |name|
        shell %(dnf copr enable #{name}), sudo: true
      end
    }
  }
end

