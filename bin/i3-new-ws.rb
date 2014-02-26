#!/usr/bin/env ruby
require 'json'

wss = JSON.parse(%x(i3-msg -t get_workspaces))
ws_nums = wss.map { |ws| ws["num"].to_i }.sort

gap_ws = nil
gap_exists = ws_nums.find.each_with_index { |num, i| num != (gap_ws = i+1) }
new_ws = gap_exists && gap_ws || ws_nums.last + 1

if $0 =~ /i3-move-new-ws\.rb\z/
  %x(i3-msg move container to workspace #{new_ws})
else
  %x(i3-msg workspace #{new_ws})
end
