# yum repository.
meta 'repository' do
  accepts_list_for :installs, :basename
  accepts_list_for :url, []

  template {
    def repositories
      # the first two lines are headers, the last is footer.
      raw_shell(%(yum repolist)).stdout.split(/\n/)[2..-2].map do |line|
        # we just use the first part and remove prefix if it exists.
        line.split(%r( |/)).first.sub(/^\*|^!/, "")
      end
    end

    met? {
     (installs - repositories).empty?
    }

    meet {
      url.each do |rpm_url|
        shell %(rpm -Uvh #{rpm_url}), sudo: true
      end
    }
  }
end
