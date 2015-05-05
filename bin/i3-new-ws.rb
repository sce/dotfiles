#!/usr/bin/env ruby

require 'json'

wss = JSON.parse(%x(i3-msg -t get_workspaces))

# Workspaces that are not "numeric" (ie. whos name doesn't start with a number)
# are given the number -1 by i3.
ws_nums = wss.map { |ws| ws["num"].to_i }.reject {|num| num < 0 }.sort

gap_ws = nil
gap_exists = ws_nums.find.each_with_index { |num, i| num != (gap_ws = i+1) }
new_ws = gap_exists && gap_ws || ws_nums.last.to_i + 1

if $0 =~ /i3-move-new-ws\.rb\z/
  %x(i3-msg move container to workspace #{new_ws})
else
  %x(i3-msg workspace #{new_ws})
end
