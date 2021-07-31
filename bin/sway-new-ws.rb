#!/usr/bin/env ruby

require 'pp'
require 'json'

def notify msg
	%x(notify-send -t 500 "#{msg}")
end

def hex(num)
  num.to_s(16)
end

def from_hex(str)
  str.to_s.hex
end

WS=%r(sway-ws\.rb\z)
NEW_WS=%r(sway-new-ws\.rb\z)
MOVE_TO_NEW_WS=%r(sway-move-new-ws\.rb\z)

pp wss = JSON.parse(%x(swaymsg -t get_workspaces))

if $0 =~ WS
	# Create notification with the name of the current workspace.
	if ws = wss.select { |ws| ws["focused"] }.first
		notify "Workspace %s" % ws["name"]
	else
		notify "(Can't find current workspace)"
	end
else
	# Workspaces that are not "numeric" (ie. whos name doesn't start with a number)
	# are given the number -1 in i3.
	# pp ws_nums = wss.map { |ws| from_hex(ws["num"]) }.reject {|num| num < 0 }.sort
	pp ws_nums = wss.map { |ws| from_hex(ws["name"]) }

	gap_ws = nil
    gap_exists = ws_nums.find.each_with_index { |num, i| hex(num) != (gap_ws = hex(i+1)) }
    new_ws = gap_exists && gap_ws || hex(from(hex(ws_nums.last) + 1))

	if $0 =~ MOVE_TO_NEW_WS
	  pp cmd = %(swaymsg move container to workspace #{new_ws})
    %x(#{cmd})
	  notify "=> Workspace %s" % new_ws
	else
	  pp cmd = %(swaymsg workspace #{new_ws})
    %x(#{cmd})
	  notify "Workspace %s" % new_ws
	end
end

