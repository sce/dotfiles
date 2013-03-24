#!/usr/bin/env ruby
require 'json'

last = JSON.parse(%x(i3-msg -t get_workspaces)).map { |ws| ws["num"].to_i }.sort.last
%x(i3-msg move container to workspace #{last + 1})
