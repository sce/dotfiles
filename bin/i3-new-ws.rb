#!/usr/bin/env ruby
require 'json'

wss = JSON.parse(%x(i3-msg -t get_workspaces))
ws_nums = wss.map { |ws| ws["num"].to_i }.sort

open_ws = nil
is_open = ws_nums.find.each_with_index { |num, i| num != (open_ws = i+1) }
new_ws = is_open && open_ws || ws_nums.last + 1

if $0 =~ /i3-move-new-ws\.rb\z/
  %x(i3-msg move container to workspace #{new_ws})
else
  %x(i3-msg workspace #{new_ws})
end
