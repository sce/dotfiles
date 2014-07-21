dep 'disable-tracker' do
  requires %w(stop-tracker mask-tracker)
end

dep 'stop-tracker' do
  met? {
    not raw_shell(%(tracker-control -p)).stdout[/tracker-miner/]
  }

  meet {
    shell %(tracker-control -r)
  }
end

dep 'mask-tracker' do
  def conf_files
    Dir['/etc/xdg/autostart/*.desktop'].select do |file|
      file.p.grep %r(tracker-miner)
    end
  end

  met? {
    conf_files.empty?
  }

  meet {
    conf_files.each do |file|
      # We just remove them. To renable just reinstall tracker.
      sudo %(rm %s) % file
    end
  }
end
