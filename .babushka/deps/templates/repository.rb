# yum repository.
meta 'repository' do
  accepts_list_for :installs, :basename

  template {
    def repositories
      # the first two lines are headers, the last is footer.
      raw_shell(%(yum repolist)).stdout.split(/\n/)[2..-2].map do |line|
        line.split(%r( |/)).first
      end
    end

    met? {
     (installs - repositories).empty?
    }
  }
end
