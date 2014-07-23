# For some reason some packages fails the "met?" for managed or lib template,
# so for those we need to query manually:
meta :rpm do
  accepts_list_for :installs, :basename

  template {
    # Currently only works for fedora (dnf).
    requires 'repoquery.managed'
    requires_when_unmet 'package manager'.with(cmd: "dnf")

    def missing
      installs.select { |pkg| %x(repoquery --installed #{pkg}).strip.empty? }
    end

    met? {
      missing = self.missing # cache

      if missing.empty?
        log_ok %(system has #{installs.join(", ")}.)
      else
        missing.each {|pkg| log %(system doesn't have #{pkg}.) }
        false
      end
    }

    meet {
      missing.each do |pkg|
        log_shell %(installing #{pkg}), %(dnf install #{pkg} -y), sudo: true
      end
    }
  }
end
