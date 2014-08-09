# enable service to be startet at bootup:
meta 'systemd_enable' do
  accepts_list_for :services, :basename

  template {
    requires %w(systemctl.bin)

    met? {
      services.all? do |service|
        shell? %(systemctl is-enabled %s) % service
      end
    }

    meet {
      services.each do |service|
        shell %(systemctl enable %s) % service, sudo: true
      end
    }
  }
end

meta 'sysv_enable' do
  accepts_list_for :services, :basename

  template {
    requires_when_unmet %w(update-rc.d)

    met? {
      services.all? do |service|
        %w(rc3.d rc5.d).each do |level|
          shell? %(readlink -f /etc/%s/S%s) % [level, service]
        end
      end
    }

    meet {
      services.each do |service|
        shell %(update-rc.d enable %s) % service, sudo: true
      end
    }
  }
end

dep 'update-rc.d', template: 'bin'
