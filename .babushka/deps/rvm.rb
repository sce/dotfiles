dep 'rvm' do
  requires_when_unmet 'curl.managed'

  met? {
    shell %(rvm info)
  }

  meet {
    shell %(curl -sSL https://get.rvm.io | bash -s stable) do |shell|
      puts shell.stdout
    end
  }
end
