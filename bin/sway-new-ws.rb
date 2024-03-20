#!/usr/bin/env ruby

require 'pp'
require 'json'

def notify msg
	%x(notify-send -t 500 "#{msg}")
end

# returns hexadecimal string version of number
def hex(num)
  num.to_s(16)
end

# returns number parsed from hexadecimal string
def from_hex(str)
  str.to_s.hex
end

def ws_name(num)
  return num

  hexversion = hex(num)
  if num != hexversion
    "#{num}: #{hexversion}"
  else
    num
  end
end

WS=%r(sway-ws\.rb\z)
NEW_WS=%r(sway-new-ws\.rb\z)
MOVE_TO_NEW_WS=%r(sway-move-new-ws\.rb\z)

wss = JSON.parse(%x(swaymsg -t get_workspaces))

# Workspaces that are not "numeric" (ie. whos name doesn't start with a number)
# are given the number -1 in i3.
#pp ws_nums = wss.map { |ws| ws["num"] }.reject {|num| num < 0 }.sort
print "ws_names:"
pp ws_names = wss.map { |ws| from_hex(ws["name"]) }.filter { |num| num != 0 }.sort

if $0 =~ WS
	# Create notification with the name of the current workspace.
	if ws = wss.select { |ws| ws["focused"] }.first
		notify "Workspace %s" % ws["name"]
	else
		notify "(Can't find current workspace)"
	end
else
	gap_ws = nil
    #gap_exists = ws_nums.find.each_with_index { |num, i| num != (gap_ws = i+1) }
    gap_exists = ws_names.find.each_with_index { |name, i| hex(name) != (gap_ws = hex(i+1)) }
    new_ws = gap_exists && gap_ws || hex((ws_names.last || 0) + 1)
    #new_ws = gap_exists && gap_ws || (ws_nums.last + 1)
    #new_ws = ws_name(new_ws)

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

