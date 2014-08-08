# enable service to be startet at bootup:
meta 'enable' do
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
