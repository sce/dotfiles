meta :rm_lib do
  accepts_list_for :remove, :basename

  template {
    # Currently only works for fedora (dnf).
    requires 'repoquery.managed'
    requires_when_unmet 'package manager'.with(cmd: "dnf")

    def installed
      # pgk_helper uses log_ok for each installed package (which should be
      # log_error in our case).
      #remove.select { |pkg| Babushka.host.pkg_helper.has?(pkg) }

      remove.reject { |pkg| %x(repoquery --installed #{pkg}).strip.empty? }
    end

    met? {
      installed = self.installed # cache

      if installed.empty?
        log_ok %(system does not have #{remove.join(", ")}.)
      else
        installed.each {|pkg| log %(system has #{pkg} installed.) }
        false
      end
    }

    meet {
      installed.each do |pkg|
        log_shell %(removing #{pkg}), %(dnf erase #{pkg} -y), sudo: true
      end
    }
  }
end
