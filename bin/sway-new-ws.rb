#!/usr/bin/env ruby

require 'pp'
require 'json'

def notify msg
	%x(notify-send -t 500 "#{msg}")
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
	pp ws_nums = wss.map { |ws| ws["num"].to_i }.reject {|num| num < 0 }.sort

	gap_ws = nil
	gap_exists = ws_nums.find.each_with_index { |num, i| num != (gap_ws = i+1) }
	new_ws = gap_exists && gap_ws || ws_nums.last.to_i + 1

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

