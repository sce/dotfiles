#!/usr/bin/env ruby

require 'pp'
require 'json'

def notify msg
  # on some monitors it might take about 3 seconds to actually change resolution:
  %x(notify-send -t 6000 "#{msg}")
end

outputs = JSON.parse(%x(swaymsg -t get_outputs))

output = outputs.find { |out| out['focused'] }

output_name = output['name']

# we don't care about refresh rates:
pp modes = output['modes'].map { |mode| mode.delete 'refresh'; mode }.uniq

current_mode = output['current_mode']
current_mode.delete 'refresh'

def mode_mark(mode, current_mode)
  mode == current_mode ? " *" : ""
end

pp mode_texts = modes.map { |mode| "#{mode['width']}x#{mode['height']}#{mode_mark(mode, current_mode)}" }.join("\n")

title = "Choose hw resolution for #{output_name}"
res = %x(echo "#{mode_texts}" | wofi -d -p "#{title}").strip

if res == "" or res.include?("*")
  # do nothing
else
  p cmd = %(swaymsg output #{output_name} mode #{res})
  puts %x(#{cmd})
  notify "Set resolution on #{output_name} to #{res}"
end
