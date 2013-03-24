#!/usr/bin/env ruby
require 'json'

wss = JSON.parse(%x(i3-msg -t get_workspaces))
last_ws = wss.map { |ws| ws["num"].to_i }.sort.last
new_ws = last_ws + 1

if $0 =~ /i3-move-new-ws\.rb\z/
  %x(i3-msg move container to workspace #{new_ws})
else
  %x(i3-msg workspace #{new_ws})
end
